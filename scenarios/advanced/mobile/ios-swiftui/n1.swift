import SwiftUI

struct CalendarApplication: View {
    @State private var currentDate = Date()
    @State private var selectedDate = Date()
    @State private var viewMode: ViewMode = .month
    @State private var events: [Event] = []
    @State private var isLoading = false
    @State private var showEventModal = false
    @State private var showEventDetails = false
    @State private var selectedEvent: Event?
    @State private var newEvent = Event()
    
    enum ViewMode: String, CaseIterable {
        case month = "month"
        case week = "week"
        case day = "day"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                headerView
                
                // View Mode Selector
                viewModeSelector
                
                // Navigation
                navigationView
                
                // Calendar Content
                calendarContentView
                
                Spacer()
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Today") {
                        onTodayClicked()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showEventModal = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showEventModal) {
                EventModalView(event: $newEvent, isPresented: $showEventModal) {
                    saveEvent()
                }
            }
            .sheet(isPresented: $showEventDetails) {
                if let event = selectedEvent {
                    EventDetailsView(event: event, isPresented: $showEventDetails) {
                        deleteEvent(event)
                    }
                }
            }
            .onAppear {
                loadEvents()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Calendar")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
    
    private var viewModeSelector: some View {
        Picker("View Mode", selection: $viewMode) {
            ForEach(ViewMode.allCases, id: \.self) { mode in
                Text(mode.rawValue.uppercased()).tag(mode)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
    
    private var navigationView: some View {
        HStack {
            Button(action: onPreviousClicked) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            Text(currentDateText)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: onNextClicked) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
    
    private var calendarContentView: some View {
        Group {
            switch viewMode {
            case .month:
                monthView
            case .week:
                weekView
            case .day:
                dayView
            }
        }
        .padding()
    }
    
    private var monthView: some View {
        VStack(spacing: 0) {
            // Week days header
            HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
            }
            .background(Color(.systemGray6))
            
            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 1) {
                ForEach(calendarDays, id: \.date) { day in
                    DayCellView(day: day) {
                        onDayClicked(day)
                    }
                }
            }
            .background(Color(.systemBackground))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
    
    private var weekView: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(weekDaysData, id: \.date) { day in
                    WeekDayCellView(day: day) {
                        onDayClicked(day)
                    }
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
    
    private var dayView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(currentDate.day)")
                        .font(.system(size: 48, weight: .bold))
                    Text(currentDate.monthName)
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text("\(currentDate.year)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
            
            if dayEvents.isEmpty {
                VStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    Text("No events for this day")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(dayEvents, id: \.id) { event in
                            EventCardView(event: event) {
                                selectedEvent = event
                                showEventDetails = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Computed Properties
    
    private var currentDateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: currentDate)
    }
    
    private var weekDays: [String] {
        ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    }
    
    private var calendarDays: [CalendarDay] {
        let year = currentDate.year
        let month = currentDate.month
        let firstDay = Calendar.current.date(from: DateComponents(year: year, month: month, day: 1))!
        let lastDay = Calendar.current.date(byAdding: .month, value: 1, to: firstDay)!.addingTimeInterval(-1)
        let startingDayOfWeek = Calendar.current.component(.weekday, from: firstDay) - 1
        
        var days: [CalendarDay] = []
        
        // Add empty cells for days before the first day of the month
        for _ in 0..<startingDayOfWeek {
            days.append(CalendarDay(date: Date(), dayNumber: 0, isEmpty: true))
        }
        
        // Add days of the month
        for day in 1...lastDay.day {
            let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
            let dayEvents = getEventsForDate(date)
            let isToday = Calendar.current.isDateInToday(date)
            let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
            
            days.append(CalendarDay(
                date: date,
                dayNumber: day,
                isToday: isToday,
                isSelected: isSelected,
                isEmpty: false,
                hasEvents: !dayEvents.isEmpty,
                events: dayEvents
            ))
        }
        
        return days
    }
    
    private var weekDaysData: [CalendarDay] {
        let startOfWeek = Calendar.current.dateInterval(of: .weekOfYear, for: currentDate)!.start
        var days: [CalendarDay] = []
        
        for i in 0..<7 {
            let date = Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!
            let dayEvents = getEventsForDate(date)
            let isToday = Calendar.current.isDateInToday(date)
            let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
            
            days.append(CalendarDay(
                date: date,
                dayNumber: date.day,
                isToday: isToday,
                isSelected: isSelected,
                isEmpty: false,
                hasEvents: !dayEvents.isEmpty,
                events: dayEvents
            ))
        }
        
        return days
    }
    
    private var dayEvents: [Event] {
        getEventsForDate(currentDate)
    }
    
    // MARK: - Helper Methods
    
    private func loadEvents() {
        isLoading = true
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            events = generateSampleEvents()
            isLoading = false
        }
    }
    
    private func generateSampleEvents() -> [Event] {
        [
            Event(
                id: "1",
                title: "Team Meeting",
                description: "Weekly team standup",
                startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 15, hour: 10, minute: 0))!,
                endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 15, hour: 11, minute: 0))!,
                category: "work",
                isAllDay: false,
                location: "Conference Room A",
                attendees: ["john@example.com", "jane@example.com"],
                recurring: "weekly",
                reminders: ["15min", "1hour"]
            ),
            Event(
                id: "2",
                title: "Doctor Appointment",
                description: "Annual checkup",
                startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 16, hour: 14, minute: 30))!,
                endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 16, hour: 15, minute: 30))!,
                category: "appointment",
                isAllDay: false,
                location: "Medical Center",
                attendees: [],
                recurring: "none",
                reminders: ["1day", "2hours"]
            ),
            Event(
                id: "3",
                title: "Project Deadline",
                description: "Submit final report",
                startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 20, hour: 17, minute: 0))!,
                endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 20, hour: 17, minute: 0))!,
                category: "work",
                isAllDay: true,
                location: "",
                attendees: [],
                recurring: "none",
                reminders: ["1week", "1day"]
            )
        ]
    }
    
    private func getEventsForDate(_ date: Date) -> [Event] {
        events.filter { event in
            Calendar.current.isDate(event.startTime, inSameDayAs: date)
        }
    }
    
    private func getCategoryColor(_ category: String) -> Color {
        switch category {
        case "personal": return .green
        case "work": return .blue
        case "meeting": return .orange
        case "appointment": return .purple
        case "reminder": return .red
        default: return .blue
        }
    }
    
    // MARK: - Actions
    
    private func onTodayClicked() {
        currentDate = Date()
        selectedDate = Date()
    }
    
    private func onPreviousClicked() {
        switch viewMode {
        case .month:
            currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
        case .week:
            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!
        case .day:
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        }
    }
    
    private func onNextClicked() {
        switch viewMode {
        case .month:
            currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
        case .week:
            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
        case .day:
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
    }
    
    private func onDayClicked(_ day: CalendarDay) {
        guard !day.isEmpty else { return }
        
        selectedDate = day.date
        
        if !day.events.isEmpty {
            selectedEvent = day.events.first
            showEventDetails = true
        } else {
            newEvent = Event()
            newEvent.startTime = day.date
            newEvent.endTime = Calendar.current.date(byAdding: .hour, value: 1, to: day.date)!
            showEventModal = true
        }
    }
    
    private func saveEvent() {
        events.append(newEvent)
        newEvent = Event()
    }
    
    private func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }
}

// MARK: - Supporting Views

struct DayCellView: View {
    let day: CalendarDay
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text("\(day.dayNumber)")
                    .font(.system(size: 16, weight: day.isToday ? .bold : .regular))
                    .foregroundColor(day.isSelected ? .white : (day.isToday ? .blue : .primary))
                
                if day.hasEvents {
                    HStack(spacing: 2) {
                        ForEach(Array(day.events.prefix(3).enumerated()), id: \.offset) { index, event in
                            Circle()
                                .fill(getCategoryColor(event.category))
                                .frame(width: 6, height: 6)
                        }
                        if day.events.count > 3 {
                            Text("+\(day.events.count - 3)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(day.isSelected ? Color.blue : (day.isToday ? Color.blue.opacity(0.1) : Color.clear))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func getCategoryColor(_ category: String) -> Color {
        switch category {
        case "personal": return .green
        case "work": return .blue
        case "meeting": return .orange
        case "appointment": return .purple
        case "reminder": return .red
        default: return .blue
        }
    }
}

struct WeekDayCellView: View {
    let day: CalendarDay
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(day.date.weekdayName)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Text("\(day.dayNumber)")
                    .font(.system(size: 16, weight: day.isToday ? .bold : .regular))
                    .foregroundColor(day.isSelected ? .white : (day.isToday ? .blue : .primary))
                
                if day.hasEvents {
                    HStack(spacing: 2) {
                        ForEach(Array(day.events.prefix(2).enumerated()), id: \.offset) { index, event in
                            Circle()
                                .fill(getCategoryColor(event.category))
                                .frame(width: 4, height: 4)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(day.isSelected ? Color.blue : (day.isToday ? Color.blue.opacity(0.1) : Color.clear))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func getCategoryColor(_ category: String) -> Color {
        switch category {
        case "personal": return .green
        case "work": return .blue
        case "meeting": return .orange
        case "appointment": return .purple
        case "reminder": return .red
        default: return .blue
        }
    }
}

struct EventCardView: View {
    let event: Event
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Rectangle()
                    .fill(getCategoryColor(event.category))
                    .frame(width: 4)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(event.isAllDay ? "All Day" : "\(event.startTime, formatter: timeFormatter) - \(event.endTime, formatter: timeFormatter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if !event.location.isEmpty {
                        Text(event.location)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func getCategoryColor(_ category: String) -> Color {
        switch category {
        case "personal": return .green
        case "work": return .blue
        case "meeting": return .orange
        case "appointment": return .purple
        case "reminder": return .red
        default: return .blue
        }
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}

// MARK: - Data Models

struct CalendarDay {
    let date: Date
    let dayNumber: Int
    let isToday: Bool
    let isSelected: Bool
    let isEmpty: Bool
    let hasEvents: Bool
    let events: [Event]
}

struct Event: Identifiable {
    let id: String
    var title: String
    var description: String
    var startTime: Date
    var endTime: Date
    var category: String
    var isAllDay: Bool
    var location: String
    var attendees: [String]
    var recurring: String
    var reminders: [String]
    
    init(id: String = UUID().uuidString, title: String = "", description: String = "", startTime: Date = Date(), endTime: Date = Date(), category: String = "personal", isAllDay: Bool = false, location: String = "", attendees: [String] = [], recurring: String = "none", reminders: [String] = []) {
        self.id = id
        self.title = title
        self.description = description
        self.startTime = startTime
        self.endTime = endTime
        self.category = category
        self.isAllDay = isAllDay
        self.location = location
        self.attendees = attendees
        self.recurring = recurring
        self.reminders = reminders
    }
}

// MARK: - Event Modal Views

struct EventModalView: View {
    @Binding var event: Event
    @Binding var isPresented: Bool
    let onSave: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Event Details") {
                    TextField("Title", text: $event.title)
                    TextField("Description", text: $event.description, axis: .vertical)
                }
                
                Section("Time") {
                    DatePicker("Start Time", selection: $event.startTime)
                    DatePicker("End Time", selection: $event.endTime)
                    Toggle("All Day", isOn: $event.isAllDay)
                }
                
                Section("Category") {
                    Picker("Category", selection: $event.category) {
                        Text("Personal").tag("personal")
                        Text("Work").tag("work")
                        Text("Meeting").tag("meeting")
                        Text("Appointment").tag("appointment")
                        Text("Reminder").tag("reminder")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section("Location") {
                    TextField("Location", text: $event.location)
                }
            }
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave()
                        isPresented = false
                    }
                    .disabled(event.title.isEmpty)
                }
            }
        }
    }
}

struct EventDetailsView: View {
    let event: Event
    @Binding var isPresented: Bool
    let onDelete: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text(event.title)
                        .font(.headline)
                    Text(event.isAllDay ? "All Day" : "\(event.startTime, formatter: timeFormatter) - \(event.endTime, formatter: timeFormatter)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if !event.description.isEmpty {
                    Section("Description") {
                        Text(event.description)
                    }
                }
                
                if !event.location.isEmpty {
                    Section("Location") {
                        Text(event.location)
                    }
                }
                
                if !event.attendees.isEmpty {
                    Section("Attendees") {
                        ForEach(event.attendees, id: \.self) { attendee in
                            Text(attendee)
                        }
                    }
                }
            }
            .navigationTitle("Event Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Delete") {
                        onDelete()
                        isPresented = false
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}

// MARK: - Date Extensions

extension Date {
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    
    var weekdayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
}

#Preview {
    CalendarApplication()
}