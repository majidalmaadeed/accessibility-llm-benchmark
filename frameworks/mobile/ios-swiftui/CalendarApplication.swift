import SwiftUI

struct CalendarApplication: View {
    @State private var selectedDate: Date = Date()
    @State private var currentView: CalendarView = .month
    @State private var events: [CalendarEvent] = []
    @State private var showEventForm: Bool = false
    @State private var selectedEvent: CalendarEvent? = nil
    @State private var showFilters: Bool = false
    @State private var filterCategories: Set<String> = []
    @State private var searchQuery: String = ""
    
    let viewTypes: [CalendarView] = [.day, .week, .month, .year]
    let categories = ["Work", "Personal", "Health", "Travel", "Family", "Other"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                headerView
                viewControlsView
                
                if showFilters {
                    filtersView
                }
                
                calendarContentView
                
                if !events.isEmpty {
                    eventsListView
                }
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadEvents()
            }
        }
        .sheet(isPresented: $showEventForm) {
            EventFormView(
                event: selectedEvent,
                onSave: { event in
                    saveEvent(event)
                },
                onDelete: { event in
                    deleteEvent(event)
                }
            )
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Calendar")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: showFilters ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: { showEventForm = true }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            
            HStack {
                Button(action: { navigateToPrevious() }) {
                    Image(systemName: "chevron.left")
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Text(formatDateHeader(selectedDate))
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: { navigateToNext() }) {
                    Image(systemName: "chevron.right")
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
    
    private var viewControlsView: some View {
        HStack {
            Text("View")
                .font(.headline)
            
            Spacer()
            
            Picker("View", selection: $currentView) {
                ForEach(viewTypes, id: \.self) { view in
                    Text(view.displayName).tag(view)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(.horizontal)
    }
    
    private var filtersView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Filters")
                    .font(.headline)
                Spacer()
                Button("Clear All") {
                    filterCategories.removeAll()
                }
                .buttonStyle(.bordered)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    FilterChip(
                        title: category,
                        isSelected: filterCategories.contains(category)
                    ) {
                        toggleCategory(category)
                    }
                }
            }
            
            HStack {
                TextField("Search events...", text: $searchQuery)
                    .textFieldStyle(.roundedBorder)
                
                if !searchQuery.isEmpty {
                    Button("Clear") {
                        searchQuery = ""
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var calendarContentView: some View {
        VStack(spacing: 0) {
            switch currentView {
            case .day:
                dayView
            case .week:
                weekView
            case .month:
                monthView
            case .year:
                yearView
            }
        }
        .frame(maxHeight: .infinity)
    }
    
    private var dayView: some View {
        VStack(spacing: 16) {
            HStack {
                Text(formatDate(selectedDate, format: "EEEE, MMMM d, yyyy"))
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Today") {
                    selectedDate = Date()
                }
                .buttonStyle(.bordered)
            }
            .padding()
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(hourSlots, id: \.hour) { slot in
                        HourSlotView(
                            hour: slot.hour,
                            events: eventsForHour(slot.hour)
                        ) { event in
                            selectedEvent = event
                            showEventForm = true
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var weekView: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(weekDays, id: \.self) { date in
                    VStack(spacing: 8) {
                        Text(formatDate(date, format: "EEE"))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(formatDate(date, format: "d"))
                            .font(.headline)
                            .fontWeight(isToday(date) ? .bold : .regular)
                            .foregroundColor(isToday(date) ? .blue : .primary)
                            .frame(width: 30, height: 30)
                            .background(isToday(date) ? Color.blue.opacity(0.2) : Color.clear)
                            .cornerRadius(15)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(hourSlots, id: \.hour) { slot in
                        WeekHourRowView(
                            hour: slot.hour,
                            weekDays: weekDays,
                            events: eventsForWeekHour(slot.hour)
                        ) { event in
                            selectedEvent = event
                            showEventForm = true
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var monthView: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 1) {
                ForEach(monthDays, id: \.self) { date in
                    MonthDayView(
                        date: date,
                        isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                        isToday: isToday(date),
                        events: eventsForDate(date)
                    ) {
                        selectedDate = date
                    } onEventTap: { event in
                        selectedEvent = event
                        showEventForm = true
                    }
                }
            }
        }
    }
    
    private var yearView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
            ForEach(1...12, id: \.self) { month in
                YearMonthView(
                    month: month,
                    year: Calendar.current.component(.year, from: selectedDate),
                    events: eventsForMonth(month)
                ) { date in
                    selectedDate = date
                    currentView = .month
                }
            }
        }
        .padding()
    }
    
    private var eventsListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Upcoming Events")
                    .font(.headline)
                
                Spacer()
                
                Text("\(filteredEvents.count) events")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(filteredEvents.prefix(5)) { event in
                        EventRowView(event: event) {
                            selectedEvent = event
                            showEventForm = true
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 200)
        }
    }
    
    // MARK: - Computed Properties
    
    private var hourSlots: [HourSlot] {
        (0...23).map { HourSlot(hour: $0) }
    }
    
    private var weekDays: [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: selectedDate)?.start ?? selectedDate
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    private var monthDays: [Date] {
        let calendar = Calendar.current
        let startOfMonth = calendar.dateInterval(of: .month, for: selectedDate)?.start ?? selectedDate
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: startOfMonth)?.start ?? startOfMonth
        
        var days: [Date] = []
        for i in 0..<42 {
            if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                days.append(date)
            }
        }
        return days
    }
    
    private var filteredEvents: [CalendarEvent] {
        var filtered = events
        
        if !filterCategories.isEmpty {
            filtered = filtered.filter { filterCategories.contains($0.category) }
        }
        
        if !searchQuery.isEmpty {
            filtered = filtered.filter { event in
                event.title.localizedCaseInsensitiveContains(searchQuery) ||
                event.description.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        
        return filtered.sorted { $0.startDate < $1.startDate }
    }
    
    // MARK: - Methods
    
    private func loadEvents() {
        events = [
            CalendarEvent(
                id: UUID(),
                title: "Team Meeting",
                description: "Weekly team standup",
                startDate: Date().addingTimeInterval(3600),
                endDate: Date().addingTimeInterval(7200),
                category: "Work",
                isAllDay: false,
                location: "Conference Room A"
            ),
            CalendarEvent(
                id: UUID(),
                title: "Doctor Appointment",
                description: "Annual checkup",
                startDate: Date().addingTimeInterval(86400),
                endDate: Date().addingTimeInterval(90000),
                category: "Health",
                isAllDay: false,
                location: "Medical Center"
            ),
            CalendarEvent(
                id: UUID(),
                title: "Birthday Party",
                description: "Sarah's birthday celebration",
                startDate: Date().addingTimeInterval(172800),
                endDate: Date().addingTimeInterval(180000),
                category: "Family",
                isAllDay: false,
                location: "Home"
            )
        ]
    }
    
    private func saveEvent(_ event: CalendarEvent) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
        } else {
            events.append(event)
        }
        selectedEvent = nil
    }
    
    private func deleteEvent(_ event: CalendarEvent) {
        events.removeAll { $0.id == event.id }
        selectedEvent = nil
    }
    
    private func navigateToPrevious() {
        let calendar = Calendar.current
        switch currentView {
        case .day:
            selectedDate = calendar.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
        case .week:
            selectedDate = calendar.date(byAdding: .weekOfYear, value: -1, to: selectedDate) ?? selectedDate
        case .month:
            selectedDate = calendar.date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
        case .year:
            selectedDate = calendar.date(byAdding: .year, value: -1, to: selectedDate) ?? selectedDate
        }
    }
    
    private func navigateToNext() {
        let calendar = Calendar.current
        switch currentView {
        case .day:
            selectedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
        case .week:
            selectedDate = calendar.date(byAdding: .weekOfYear, value: 1, to: selectedDate) ?? selectedDate
        case .month:
            selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
        case .year:
            selectedDate = calendar.date(byAdding: .year, value: 1, to: selectedDate) ?? selectedDate
        }
    }
    
    private func toggleCategory(_ category: String) {
        if filterCategories.contains(category) {
            filterCategories.remove(category)
        } else {
            filterCategories.insert(category)
        }
    }
    
    private func eventsForDate(_ date: Date) -> [CalendarEvent] {
        let calendar = Calendar.current
        return events.filter { event in
            calendar.isDate(event.startDate, inSameDayAs: date)
        }
    }
    
    private func eventsForHour(_ hour: Int) -> [CalendarEvent] {
        let calendar = Calendar.current
        return events.filter { event in
            calendar.component(.hour, from: event.startDate) == hour
        }
    }
    
    private func eventsForWeekHour(_ hour: Int) -> [CalendarEvent] {
        let calendar = Calendar.current
        return events.filter { event in
            calendar.component(.hour, from: event.startDate) == hour &&
            weekDays.contains { calendar.isDate(event.startDate, inSameDayAs: $0) }
        }
    }
    
    private func eventsForMonth(_ month: Int) -> [CalendarEvent] {
        let calendar = Calendar.current
        return events.filter { event in
            calendar.component(.month, from: event.startDate) == month
        }
    }
    
    private func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
    
    private func formatDate(_ date: Date, format: String = "MMM d, yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    private func formatDateHeader(_ date: Date) -> String {
        let formatter = DateFormatter()
        switch currentView {
        case .day:
            formatter.dateFormat = "EEEE, MMMM d, yyyy"
        case .week:
            formatter.dateFormat = "MMM d - d, yyyy"
        case .month:
            formatter.dateFormat = "MMMM yyyy"
        case .year:
            formatter.dateFormat = "yyyy"
        }
        return formatter.string(from: date)
    }
}

// MARK: - Supporting Views

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

struct HourSlotView: View {
    let hour: Int
    let events: [CalendarEvent]
    let onEventTap: (CalendarEvent) -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(formatHour(hour))
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(width: 40, alignment: .leading)
            
            VStack(spacing: 4) {
                ForEach(events) { event in
                    EventChipView(event: event) {
                        onEventTap(event)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 60)
    }
    
    private func formatHour(_ hour: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date()) ?? Date()
        return formatter.string(from: date)
    }
}

struct WeekHourRowView: View {
    let hour: Int
    let weekDays: [Date]
    let events: [CalendarEvent]
    let onEventTap: (CalendarEvent) -> Void
    
    var body: some View {
        HStack(spacing: 1) {
            Text(formatHour(hour))
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(width: 40, alignment: .leading)
            
            ForEach(weekDays, id: \.self) { date in
                VStack(spacing: 2) {
                    ForEach(eventsForDate(date)) { event in
                        EventChipView(event: event) {
                            onEventTap(event)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color(.systemGray6))
            }
        }
    }
    
    private func eventsForDate(_ date: Date) -> [CalendarEvent] {
        let calendar = Calendar.current
        return events.filter { calendar.isDate($0.startDate, inSameDayAs: date) }
    }
    
    private func formatHour(_ hour: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date()) ?? Date()
        return formatter.string(from: date)
    }
}

struct MonthDayView: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let events: [CalendarEvent]
    let onTap: () -> Void
    let onEventTap: (CalendarEvent) -> Void
    
    var body: some View {
        VStack(spacing: 2) {
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.caption)
                .fontWeight(isToday ? .bold : .regular)
                .foregroundColor(isToday ? .blue : (isSelected ? .white : .primary))
                .frame(width: 30, height: 30)
                .background(isToday ? Color.blue.opacity(0.2) : (isSelected ? Color.blue : Color.clear))
                .cornerRadius(15)
            
            VStack(spacing: 1) {
                ForEach(events.prefix(3)) { event in
                    EventChipView(event: event) {
                        onEventTap(event)
                    }
                }
            }
        }
        .frame(height: 80)
        .onTapGesture {
            onTap()
        }
    }
}

struct YearMonthView: View {
    let month: Int
    let year: Int
    let events: [CalendarEvent]
    let onDateTap: (Date) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(monthName(month))
                .font(.headline)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 2) {
                ForEach(monthDays, id: \.self) { date in
                    Text("\(Calendar.current.component(.day, from: date))")
                        .font(.caption2)
                        .foregroundColor(hasEvents(date) ? .blue : .primary)
                        .frame(width: 20, height: 20)
                        .background(hasEvents(date) ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                        .onTapGesture {
                            onDateTap(date)
                        }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private var monthDays: [Date] {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1)) ?? Date()
        let range = calendar.range(of: .day, in: .month, for: startOfMonth) ?? 1..<32
        
        return range.compactMap { day in
            calendar.date(from: DateComponents(year: year, month: month, day: day))
        }
    }
    
    private func hasEvents(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return events.contains { calendar.isDate($0.startDate, inSameDayAs: date) }
    }
    
    private func monthName(_ month: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let date = Calendar.current.date(from: DateComponents(month: month)) ?? Date()
        return formatter.string(from: date)
    }
}

struct EventChipView: View {
    let event: CalendarEvent
    let onTap: () -> Void
    
    var body: some View {
        Text(event.title)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(categoryColor(event.category))
            .cornerRadius(4)
            .lineLimit(1)
            .onTapGesture {
                onTap()
            }
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "Work": return .blue
        case "Personal": return .green
        case "Health": return .red
        case "Travel": return .orange
        case "Family": return .purple
        default: return .gray
        }
    }
}

struct EventRowView: View {
    let event: CalendarEvent
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                if !event.description.isEmpty {
                    Text(event.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                HStack {
                    Text(formatTime(event.startDate))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if !event.location.isEmpty {
                        Text("• \(event.location)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
            
            Text(event.category)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(categoryColor(event.category))
                .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .onTapGesture {
            onTap()
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "Work": return .blue
        case "Personal": return .green
        case "Health": return .red
        case "Travel": return .orange
        case "Family": return .purple
        default: return .gray
        }
    }
}

struct EventFormView: View {
    let event: CalendarEvent?
    let onSave: (CalendarEvent) -> Void
    let onDelete: (CalendarEvent) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date().addingTimeInterval(3600)
    @State private var category: String = "Work"
    @State private var isAllDay: Bool = false
    @State private var location: String = ""
    @State private var showDeleteAlert: Bool = false
    
    let categories = ["Work", "Personal", "Health", "Travel", "Family", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Event Details") {
                    TextField("Event Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Date & Time") {
                    Toggle("All Day", isOn: $isAllDay)
                    
                    DatePicker("Start", selection: $startDate, displayedComponents: isAllDay ? .date : [.date, .hourAndMinute])
                    DatePicker("End", selection: $endDate, displayedComponents: isAllDay ? .date : [.date, .hourAndMinute])
                }
                
                Section("Category") {
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Location") {
                    TextField("Location", text: $location)
                }
                
                if event != nil {
                    Section {
                        Button("Delete Event") {
                            showDeleteAlert = true
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(event == nil ? "New Event" : "Edit Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveEvent()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        .onAppear {
            if let event = event {
                title = event.title
                description = event.description
                startDate = event.startDate
                endDate = event.endDate
                category = event.category
                isAllDay = event.isAllDay
                location = event.location
            }
        }
        .alert("Delete Event", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let event = event {
                    onDelete(event)
                }
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this event? This action cannot be undone.")
        }
    }
    
    private func saveEvent() {
        let newEvent = CalendarEvent(
            id: event?.id ?? UUID(),
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate,
            category: category,
            isAllDay: isAllDay,
            location: location
        )
        onSave(newEvent)
        dismiss()
    }
}

// MARK: - Supporting Types

enum CalendarView: CaseIterable {
    case day, week, month, year
    
    var displayName: String {
        switch self {
        case .day: return "Day"
        case .week: return "Week"
        case .month: return "Month"
        case .year: return "Year"
        }
    }
}

struct CalendarEvent: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date
    let category: String
    let isAllDay: Bool
    let location: String
}

struct HourSlot {
    let hour: Int
}

struct CalendarApplication_Previews: PreviewProvider {
    static var previews: some View {
        CalendarApplication()
    }
}
