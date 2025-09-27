import Cocoa

class CalendarApplication: NSViewController {
    
    // MARK: - Properties
    private var currentDate = Date()
    private var selectedDate = Date()
    private var events: [Event] = []
    private var currentViewMode = "Month"
    
    // MARK: - UI Elements
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var previousButton: NSButton!
    @IBOutlet weak var nextButton: NSButton!
    @IBOutlet weak var viewModeComboBox: NSComboBox!
    @IBOutlet weak var createEventButton: NSButton!
    @IBOutlet weak var calendarGridView: NSGridView!
    @IBOutlet weak var weekView: NSStackView!
    @IBOutlet weak var dayView: NSStackView!
    @IBOutlet weak var dayEventsTableView: NSTableView!
    @IBOutlet weak var statusLabel: NSTextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSampleEvents()
        updateCalendar()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Configure date label
        dateLabel.font = NSFont.systemFont(ofSize: 20, weight: .semibold)
        dateLabel.alignment = .center
        
        // Configure buttons
        previousButton.title = "◀"
        previousButton.font = NSFont.systemFont(ofSize: 16)
        previousButton.target = self
        previousButton.action = #selector(previousButtonTapped)
        
        nextButton.title = "▶"
        nextButton.font = NSFont.systemFont(ofSize: 16)
        nextButton.target = self
        nextButton.action = #selector(nextButtonTapped)
        
        createEventButton.title = "+ New Event"
        createEventButton.target = self
        createEventButton.action = #selector(createEventButtonTapped)
        
        // Configure combo box
        viewModeComboBox.addItems(withObjectValues: ["Month", "Week", "Day"])
        viewModeComboBox.selectItem(at: 0)
        viewModeComboBox.target = self
        viewModeComboBox.action = #selector(viewModeChanged)
        
        // Configure table view
        dayEventsTableView.dataSource = self
        dayEventsTableView.delegate = self
        dayEventsTableView.target = self
        dayEventsTableView.doubleAction = #selector(eventDoubleClicked)
        
        // Setup calendar grid
        setupCalendarGrid()
        setupWeekView()
    }
    
    private func setupCalendarGrid() {
        calendarGridView.columnCount = 7
        calendarGridView.rowCount = 6
        
        // Add day headers
        let dayHeaders = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        for (index, day) in dayHeaders.enumerated() {
            let label = NSTextField(labelWithString: day)
            label.font = NSFont.systemFont(ofSize: 14, weight: .bold)
            label.alignment = .center
            calendarGridView.addSubview(label, at: 0, in: index)
        }
        
        // Add day buttons
        for row in 1..<7 {
            for col in 0..<7 {
                let button = NSButton()
                button.title = ""
                button.target = self
                button.action = #selector(dayButtonTapped(_:))
                button.tag = (row - 1) * 7 + col
                calendarGridView.addSubview(button, at: row, in: col)
            }
        }
    }
    
    private func setupWeekView() {
        weekView.orientation = .horizontal
        weekView.distribution = .fillEqually
        weekView.spacing = 2
        
        for i in 0..<7 {
            let dayView = NSStackView()
            dayView.orientation = .vertical
            dayView.alignment = .center
            dayView.spacing = 4
            
            let dayLabel = NSTextField(labelWithString: "")
            dayLabel.font = NSFont.systemFont(ofSize: 16, weight: .bold)
            dayLabel.alignment = .center
            dayLabel.tag = i
            
            let dayNumberLabel = NSTextField(labelWithString: "")
            dayNumberLabel.font = NSFont.systemFont(ofSize: 18)
            dayNumberLabel.alignment = .center
            dayNumberLabel.tag = i + 100
            
            let eventsList = NSTableView()
            eventsList.dataSource = self
            eventsList.delegate = self
            eventsList.tag = i + 200
            
            dayView.addArrangedSubview(dayLabel)
            dayView.addArrangedSubview(dayNumberLabel)
            dayView.addArrangedSubview(eventsList)
            
            weekView.addArrangedSubview(dayView)
        }
    }
    
    // MARK: - Data Loading
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
    
    // MARK: - Calendar Updates
    private func updateCalendar() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        dateLabel.stringValue = formatter.string(from: currentDate)
        
        switch currentViewMode {
        case "Month":
            updateMonthView()
        case "Week":
            updateWeekView()
        case "Day":
            updateDayView()
        default:
            break
        }
    }
    
    private func updateMonthView() {
        calendarGridView.isHidden = false
        weekView.isHidden = true
        dayView.isHidden = true
        
        let calendar = Calendar.current
        let firstDayOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        let startDate = calendar.dateInterval(of: .weekOfYear, for: firstDayOfMonth)?.start ?? firstDayOfMonth
        
        for row in 1..<7 {
            for col in 0..<7 {
                let dayIndex = (row - 1) * 7 + col
                let dayDate = calendar.date(byAdding: .day, value: dayIndex, to: startDate) ?? Date()
                let dayButton = calendarGridView.subviews[dayIndex + 7] as? NSButton
                
                let dayNumber = calendar.component(.day, from: dayDate)
                dayButton?.title = "\(dayNumber)"
                
                // Style the button
                if calendar.isDate(dayDate, inSameDayAs: Date()) {
                    dayButton?.layer?.backgroundColor = NSColor.systemBlue.cgColor
                    dayButton?.layer?.cornerRadius = 4
                } else if calendar.isDate(dayDate, inSameDayAs: selectedDate) {
                    dayButton?.layer?.backgroundColor = NSColor.systemYellow.cgColor
                    dayButton?.layer?.cornerRadius = 4
                } else {
                    dayButton?.layer?.backgroundColor = NSColor.clear.cgColor
                }
                
                // Add event indicators
                let dayEvents = getEventsForDate(dayDate)
                if !dayEvents.isEmpty {
                    dayButton?.title += " •"
                }
            }
        }
    }
    
    private func updateWeekView() {
        calendarGridView.isHidden = true
        weekView.isHidden = false
        dayView.isHidden = true
        
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
        
        for i in 0..<7 {
            let dayDate = calendar.date(byAdding: .day, value: i, to: startOfWeek) ?? Date()
            let dayView = weekView.arrangedSubviews[i] as? NSStackView
            
            let dayLabel = dayView?.arrangedSubviews[0] as? NSTextField
            let dayNumberLabel = dayView?.arrangedSubviews[1] as? NSTextField
            let eventsList = dayView?.arrangedSubviews[2] as? NSTableView
            
            let formatter = DateFormatter()
            formatter.dateFormat = "E"
            dayLabel?.stringValue = formatter.string(from: dayDate)
            
            dayNumberLabel?.stringValue = "\(calendar.component(.day, from: dayDate))"
            
            // Update events list
            let dayEvents = getEventsForDate(dayDate)
            eventsList?.reloadData()
        }
    }
    
    private func updateDayView() {
        calendarGridView.isHidden = true
        weekView.isHidden = true
        dayView.isHidden = false
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        dayDateLabel.stringValue = formatter.string(from: currentDate)
        
        dayEventsTableView.reloadData()
    }
    
    private func getEventsForDate(_ date: Date) -> [Event] {
        let calendar = Calendar.current
        return events.filter { calendar.isDate($0.startTime, inSameDayAs: date) }
    }
    
    // MARK: - Actions
    @objc private func previousButtonTapped() {
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
        updateCalendar()
    }
    
    @objc private func nextButtonTapped() {
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
        updateCalendar()
    }
    
    @objc private func viewModeChanged() {
        currentViewMode = viewModeComboBox.stringValue
        updateCalendar()
    }
    
    @objc private func createEventButtonTapped() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let createEventController = storyboard.instantiateController(withIdentifier: "CreateEventController") as? CreateEventController else { return }
        
        presentAsModalWindow(createEventController)
    }
    
    @objc private func dayButtonTapped(_ sender: NSButton) {
        let calendar = Calendar.current
        let firstDayOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        let startDate = calendar.dateInterval(of: .weekOfYear, for: firstDayOfMonth)?.start ?? firstDayOfMonth
        let dayDate = calendar.date(byAdding: .day, value: sender.tag, to: startDate) ?? Date()
        
        selectedDate = dayDate
        let dayEvents = getEventsForDate(dayDate)
        
        if !dayEvents.isEmpty {
            showEventDetails(dayEvents.first!)
        } else {
            createEventButtonTapped()
        }
        
        updateCalendar()
    }
    
    @objc private func eventDoubleClicked() {
        let selectedRow = dayEventsTableView.selectedRow
        if selectedRow >= 0 && selectedRow < getEventsForDate(currentDate).count {
            let event = getEventsForDate(currentDate)[selectedRow]
            showEventDetails(event)
        }
    }
    
    // MARK: - Event Details
    private func showEventDetails(_ event: Event) {
        let alert = NSAlert()
        alert.messageText = event.title
        alert.informativeText = """
        \(event.description)
        
        Time: \(DateFormatter.localizedString(from: event.startTime, dateStyle: .medium, timeStyle: .short))
        \(event.isAllDay ? "" : " - \(DateFormatter.localizedString(from: event.endTime, dateStyle: .none, timeStyle: .short))")
        \(event.location.isEmpty ? "" : "Location: \(event.location)")
        Category: \(event.category)
        Recurring: \(event.recurring)
        """
        alert.addButton(withTitle: "Close")
        alert.addButton(withTitle: "Delete")
        
        let response = alert.runModal()
        if response == .alertSecondButtonReturn {
            events.removeAll { $0.id == event.id }
            updateCalendar()
        }
    }
}

// MARK: - NSTableViewDataSource
extension CalendarApplication: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == dayEventsTableView {
            return getEventsForDate(currentDate).count
        } else {
            // Week view events
            let dayIndex = (tableView.tag - 200)
            let calendar = Calendar.current
            let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
            let dayDate = calendar.date(byAdding: .day, value: dayIndex, to: startOfWeek) ?? Date()
            return getEventsForDate(dayDate).count
        }
    }
}

// MARK: - NSTableViewDelegate
extension CalendarApplication: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = NSTableCellView()
        let textField = NSTextField()
        textField.isBordered = false
        textField.backgroundColor = NSColor.clear
        textField.isEditable = false
        cell.textField = textField
        cell.addSubview(textField)
        
        if tableView == dayEventsTableView {
            let event = getEventsForDate(currentDate)[row]
            textField.stringValue = "\(event.title) - \(DateFormatter.localizedString(from: event.startTime, dateStyle: .none, timeStyle: .short))"
        } else {
            // Week view events
            let dayIndex = (tableView.tag - 200)
            let calendar = Calendar.current
            let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
            let dayDate = calendar.date(byAdding: .day, value: dayIndex, to: startOfWeek) ?? Date()
            let event = getEventsForDate(dayDate)[row]
            textField.stringValue = "\(event.title) - \(DateFormatter.localizedString(from: event.startTime, dateStyle: .none, timeStyle: .short))"
        }
        
        return cell
    }
}

// MARK: - Event Model
struct Event {
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

// MARK: - Create Event Controller
class CreateEventController: NSViewController {
    
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var descriptionTextField: NSTextField!
    @IBOutlet weak var startDatePicker: NSDatePicker!
    @IBOutlet weak var endDatePicker: NSDatePicker!
    @IBOutlet weak var categoryComboBox: NSComboBox!
    @IBOutlet weak var locationTextField: NSTextField!
    @IBOutlet weak var allDayCheckBox: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Set default values
        startDatePicker.dateValue = Date()
        endDatePicker.dateValue = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        
        // Setup category combo box
        categoryComboBox.addItems(withObjectValues: ["personal", "work", "meeting", "appointment", "reminder"])
        categoryComboBox.selectItem(at: 0)
    }
    
    @IBAction func saveButtonTapped(_ sender: NSButton) {
        guard !titleTextField.stringValue.isEmpty else { return }
        
        let newEvent = Event(
            id: UUID().uuidString,
            title: titleTextField.stringValue,
            description: descriptionTextField.stringValue,
            startTime: startDatePicker.dateValue,
            endTime: endDatePicker.dateValue,
            category: categoryComboBox.stringValue,
            isAllDay: allDayCheckBox.state == .on,
            location: locationTextField.stringValue,
            attendees: [],
            recurring: "none",
            reminders: []
        )
        
        // Post notification to update calendar
        NotificationCenter.default.post(name: NSNotification.Name("EventCreated"), object: newEvent)
        
        dismiss(self)
    }
    
    @IBAction func cancelButtonTapped(_ sender: NSButton) {
        dismiss(self)
    }
}
