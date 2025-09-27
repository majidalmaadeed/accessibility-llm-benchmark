import SwiftUI

struct CalendarApplication: View {
    @State private var currentDate = Date()
    @State private var selectedDate = Date()
    @State private var events: [Event] = []
    @State private var currentViewMode = "Month"
    @State private var showingCreateEvent = false
    @State private var showingEventDetails = false
    @State private var selectedEvent: Event?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            // Date Label
            dateLabelView
            
            // Calendar Content
            calendarContentView
            
            // Status Bar
            statusBarView
        }
        .onAppear {
            loadSampleEvents()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Calendar")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            HStack(spacing: 12) {
                Button("◀") {
                    previousButtonTapped()
                }
                .buttonStyle(HeaderButtonStyle())
                
                Button("▶") {
                    nextButtonTapped()
                }
                .buttonStyle(HeaderButtonStyle())
            }
            
            HStack(spacing: 12) {
                Picker("View Mode", selection: $currentViewMode) {
                    Text("Month").tag("Month")
                    Text("Week").tag("Week")
                    Text("Day").tag("Day")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 140)
                
                Button("+ New Event") {
                    showingCreateEvent = true
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
        .padding(20)
        .background(Color.accentColor)
    }
    
    private var dateLabelView: some View {
        Text(currentDate, style: .date)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.vertical, 16)
    }
    
    @ViewBuilder
    private var calendarContentView: some View {
        switch currentViewMode {
        case "Month":
            monthView
        case "Week":
            weekView
        case "Day":
            dayView
        default:
            monthView
        }
    }
    
    private var monthView: some View {
        VStack(spacing: 12) {
            // Day Headers
            HStack {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 24)
            
            // Calendar Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 4) {
                ForEach(calendarDays, id: \.self) { date in
                    DayButton(
                        date: date,
                        isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                        isToday: Calendar.current.isDate(date, inSameDayAs: Date()),
                        events: getEventsForDate(date)
                    ) {
                        selectedDate = date
                        let dayEvents = getEventsForDate(date)
                        if let firstEvent = dayEvents.first {
                            selectedEvent = firstEvent
                            showingEventDetails = true
                        } else {
                            showingCreateEvent = true
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var weekView: some View {
        HStack(spacing: 2) {
            ForEach(weekDays, id: \.self) { date in
                VStack(spacing: 8) {
                    Text(Calendar.current.component(.weekday, from: date), format: .dateTime.weekday(.abbreviated))
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(Calendar.current.component(.day, from: date), format: .number)
                        .font(.title2)
                    
                    ScrollView {
                        LazyVStack(spacing: 4) {
                            ForEach(getEventsForDate(date), id: \.id) { event in
                                EventCard(event: event)
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(Color(.controlBackgroundColor))
                .cornerRadius(8)
            }
        }
        .padding(24)
    }
    
    private var dayView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(selectedDate, style: .date)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 24)
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(getEventsForDate(selectedDate), id: \.id) { event in
                        EventDetailCard(event: event)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
    private var statusBarView: some View {
        HStack {
            Text("Ready")
            
            Spacer()
            
            Text("\(events.count) events")
                .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.controlBackgroundColor))
    }
    
    // MARK: - Computed Properties
    private var calendarDays: [Date] {
        let calendar = Calendar.current
        let firstDayOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        let startDate = calendar.dateInterval(of: .weekOfYear, for: firstDayOfMonth)?.start ?? firstDayOfMonth
        
        return (0..<42).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: startDate)
        }
    }
    
    private var weekDays: [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
        
        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
        }
    }
    
    // MARK: - Methods
    private func loadSampleEvents() {
        events = [
            Event(
                id: "1",
                title: "Team Meeting",
                description: "Weekly team standup",
                startTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())?.addingTimeInterval(10 * 3600) ?? Date(),
                endTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())?.addingTimeInterval(11 * 3600) ?? Date(),
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
                startTime: Calendar.current.date(byAdding: .day, value: 2, to: Date())?.addingTimeInterval(14.5 * 3600) ?? Date(),
                endTime: Calendar.current.date(byAdding: .day, value: 2, to: Date())?.addingTimeInterval(15.5 * 3600) ?? Date(),
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
                startTime: Calendar.current.date(byAdding: .day, value: 5, to: Date())?.addingTimeInterval(17 * 3600) ?? Date(),
                endTime: Calendar.current.date(byAdding: .day, value: 5, to: Date())?.addingTimeInterval(18 * 3600) ?? Date(),
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
        let calendar = Calendar.current
        return events.filter { calendar.isDate($0.startTime, inSameDayAs: date) }
    }
    
    private func previousButtonTapped() {
        let calendar = Calendar.current
        switch currentViewMode {
        case "Month":
            currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
        case "Week":
            currentDate = calendar.date(byAdding: .weekOfYear, value: -1, to: currentDate) ?? currentDate
        case "Day":
            currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
        default:
            break
        }
    }
    
    private func nextButtonTapped() {
        let calendar = Calendar.current
        switch currentViewMode {
        case "Month":
            currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
        case "Week":
            currentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate) ?? currentDate
        case "Day":
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        default:
            break
        }
    }
}

// MARK: - Supporting Views
struct DayButton: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let events: [Event]
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(Calendar.current.component(.day, from: date), format: .number)
                    .font(.headline)
                    .foregroundColor(textColor)
                
                if !events.isEmpty {
                    HStack(spacing: 2) {
                        ForEach(events.prefix(3), id: \.id) { event in
                            Circle()
                                .fill(categoryColor(event.category))
                                .frame(width: 6, height: 6)
                        }
                    }
                }
            }
            .frame(width: 40, height: 40)
            .background(backgroundColor)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var backgroundColor: Color {
        if isToday {
            return .blue
        } else if isSelected {
            return .yellow
        } else {
            return .clear
        }
    }
    
    private var textColor: Color {
        if isToday {
            return .white
        } else if isSelected {
            return .black
        } else if Calendar.current.component(.month, from: date) != Calendar.current.component(.month, from: Date()) {
            return .secondary
        } else {
            return .primary
        }
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "work": return .blue
        case "personal": return .green
        case "appointment": return .purple
        case "meeting": return .orange
        default: return .blue
        }
    }
}

struct EventCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(event.title)
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(1)
            
            Text(event.startTime, style: .time)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(4)
        .background(categoryColor(event.category).opacity(0.2))
        .cornerRadius(4)
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "work": return .blue
        case "personal": return .green
        case "appointment": return .purple
        case "meeting": return .orange
        default: return .blue
        }
    }
}

struct EventDetailCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(event.title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(event.startTime, style: .time)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if !event.description.isEmpty {
                Text(event.description)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            if !event.location.isEmpty {
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.secondary)
                    Text(event.location)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                Text(event.category.capitalized)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(categoryColor(event.category).opacity(0.2))
                    .cornerRadius(4)
                
                Spacer()
                
                if event.isAllDay {
                    Text("All Day")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(16)
        .background(Color(.controlBackgroundColor))
        .cornerRadius(8)
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "work": return .blue
        case "personal": return .green
        case "appointment": return .purple
        case "meeting": return .orange
        default: return .blue
        }
    }
}

// MARK: - Button Styles
struct HeaderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(Color.white.opacity(0.2))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.2))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// MARK: - Event Model
struct Event: Identifiable {
    let id: String
    let title: String
    let description: String
    let startTime: Date
    let endTime: Date
    let category: String
    let isAllDay: Bool
    let location: String
    let attendees: [String]
    let recurring: String
    let reminders: [String]
}

// MARK: - Create Event View
struct CreateEventView: View {
    @Binding var isPresented: Bool
    @Binding var events: [Event]
    
    @State private var title = ""
    @State private var description = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(3600)
    @State private var category = "personal"
    @State private var location = ""
    @State private var isAllDay = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Event")
                .font(.title)
                .fontWeight(.bold)
            
            Form {
                TextField("Title", text: $title)
                
                TextField("Description", text: $description, axis: .vertical)
                    .lineLimit(3...6)
                
                DatePicker("Start Date", selection: $startDate)
                
                DatePicker("End Date", selection: $endDate)
                
                Picker("Category", selection: $category) {
                    Text("Personal").tag("personal")
                    Text("Work").tag("work")
                    Text("Meeting").tag("meeting")
                    Text("Appointment").tag("appointment")
                    Text("Reminder").tag("reminder")
                }
                
                TextField("Location", text: $location)
                
                Toggle("All Day", isOn: $isAllDay)
            }
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Button("Save") {
                    saveEvent()
                }
                .buttonStyle(.borderedProminent)
                .disabled(title.isEmpty)
            }
        }
        .padding(20)
        .frame(width: 400, height: 500)
    }
    
    private func saveEvent() {
        let newEvent = Event(
            id: UUID().uuidString,
            title: title,
            description: description,
            startTime: startDate,
            endTime: endDate,
            category: category,
            isAllDay: isAllDay,
            location: location,
            attendees: [],
            recurring: "none",
            reminders: []
        )
        
        events.append(newEvent)
        isPresented = false
    }
}

// MARK: - Event Details View
struct EventDetailsView: View {
    @Binding var isPresented: Bool
    let event: Event
    @Binding var events: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(event.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(event.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "clock")
                    Text(event.startTime, style: .date)
                    Text(event.startTime, style: .time)
                }
                
                if !event.isAllDay {
                    HStack {
                        Image(systemName: "clock.fill")
                        Text(event.endTime, style: .time)
                    }
                }
                
                if !event.location.isEmpty {
                    HStack {
                        Image(systemName: "location")
                        Text(event.location)
                    }
                }
                
                HStack {
                    Image(systemName: "tag")
                    Text(event.category.capitalized)
                }
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            Spacer()
            
            HStack {
                Button("Delete") {
                    deleteEvent()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Close") {
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(20)
        .frame(width: 400, height: 300)
    }
    
    private func deleteEvent() {
        events.removeAll { $0.id == event.id }
        isPresented = false
    }
}

// MARK: - Preview
struct CalendarApplication_Previews: PreviewProvider {
    static var previews: some View {
        CalendarApplication()
    }
}
