import Cocoa

class KeyboardTrapInWidget: NSViewController {
    
    @IBOutlet weak var eventTitleField: NSTextField!
    @IBOutlet weak var eventDescriptionTextView: NSTextView!
    @IBOutlet weak var eventDateButton: NSButton!
    @IBOutlet weak var eventTimeButton: NSButton!
    @IBOutlet weak var eventLocationField: NSTextField!
    @IBOutlet weak var attendeesField: NSTextField!
    @IBOutlet weak var createEventButton: NSButton!
    @IBOutlet weak var saveDraftButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    
    @IBOutlet weak var datePickerView: NSView!
    @IBOutlet weak var datePicker: NSDatePicker!
    @IBOutlet weak var dateCancelButton: NSButton!
    @IBOutlet weak var dateDoneButton: NSButton!
    
    @IBOutlet weak var timePickerView: NSView!
    @IBOutlet weak var timePicker: NSDatePicker!
    @IBOutlet weak var timeCancelButton: NSButton!
    @IBOutlet weak var timeDoneButton: NSButton!
    
    private var selectedDate = Date()
    private var selectedTime = Date()
    private var isDatePickerOpen = false
    private var isTimePickerOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Event Form
        eventTitleField.placeholderString = "Enter event title"
        eventTitleField.font = NSFont.systemFont(ofSize: 16)
        
        eventDescriptionTextView.string = ""
        eventDescriptionTextView.font = NSFont.systemFont(ofSize: 14)
        
        // Date Selection - KEYBOARD TRAP IN WIDGET
        eventDateButton.title = "📅 \(DateFormatter.shortDate.string(from: selectedDate))"
        eventDateButton.font = NSFont.systemFont(ofSize: 16)
        eventDateButton.target = self
        eventDateButton.action = #selector(dateButtonTapped)
        
        // Time Selection - KEYBOARD TRAP IN WIDGET
        eventTimeButton.title = "🕐 \(DateFormatter.shortTime.string(from: selectedTime))"
        eventTimeButton.font = NSFont.systemFont(ofSize: 16)
        eventTimeButton.target = self
        eventTimeButton.action = #selector(timeButtonTapped)
        
        eventLocationField.placeholderString = "Enter event location"
        eventLocationField.font = NSFont.systemFont(ofSize: 16)
        
        attendeesField.placeholderString = "Enter attendee emails"
        attendeesField.font = NSFont.systemFont(ofSize: 16)
        
        // Action Buttons
        createEventButton.title = "Create Event"
        createEventButton.font = NSFont.boldSystemFont(ofSize: 16)
        createEventButton.bezelStyle = .rounded
        createEventButton.target = self
        createEventButton.action = #selector(createEventTapped)
        
        saveDraftButton.title = "Save Draft"
        saveDraftButton.font = NSFont.boldSystemFont(ofSize: 16)
        saveDraftButton.bezelStyle = .texturedRounded
        saveDraftButton.target = self
        saveDraftButton.action = #selector(saveDraftTapped)
        
        cancelButton.title = "Cancel"
        cancelButton.font = NSFont.boldSystemFont(ofSize: 16)
        cancelButton.bezelStyle = .texturedRounded
        cancelButton.target = self
        cancelButton.action = #selector(cancelTapped)
        
        // Date Picker - KEYBOARD TRAP IN WIDGET
        setupDatePicker()
        
        // Time Picker - KEYBOARD TRAP IN WIDGET
        setupTimePicker()
    }
    
    private func setupDatePicker() {
        datePickerView.wantsLayer = true
        datePickerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        datePickerView.layer?.cornerRadius = 8
        datePickerView.layer?.shadowOpacity = 0.2
        datePickerView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        datePickerView.layer?.shadowRadius = 4
        datePickerView.isHidden = true
        
        // KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        datePicker.datePickerStyle = .clockAndCalendar
        datePicker.datePickerMode = .single
        datePicker.dateValue = selectedDate
        datePicker.target = self
        datePicker.action = #selector(datePickerChanged)
        
        dateCancelButton.title = "Cancel"
        dateCancelButton.font = NSFont.systemFont(ofSize: 14)
        dateCancelButton.bezelStyle = .rounded
        dateCancelButton.target = self
        dateCancelButton.action = #selector(dateCancelTapped)
        
        dateDoneButton.title = "Done"
        dateDoneButton.font = NSFont.boldSystemFont(ofSize: 14)
        dateDoneButton.bezelStyle = .rounded
        dateDoneButton.target = self
        dateDoneButton.action = #selector(dateDoneTapped)
    }
    
    private func setupTimePicker() {
        timePickerView.wantsLayer = true
        timePickerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        timePickerView.layer?.cornerRadius = 8
        timePickerView.layer?.shadowOpacity = 0.2
        timePickerView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        timePickerView.layer?.shadowRadius = 4
        timePickerView.isHidden = true
        
        // KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
        timePicker.datePickerStyle = .clockAndCalendar
        timePicker.datePickerMode = .single
        timePicker.dateValue = selectedTime
        timePicker.target = self
        timePicker.action = #selector(timePickerChanged)
        
        timeCancelButton.title = "Cancel"
        timeCancelButton.font = NSFont.systemFont(ofSize: 14)
        timeCancelButton.bezelStyle = .rounded
        timeCancelButton.target = self
        timeCancelButton.action = #selector(timeCancelTapped)
        
        timeDoneButton.title = "Done"
        timeDoneButton.font = NSFont.boldSystemFont(ofSize: 14)
        timeDoneButton.bezelStyle = .rounded
        timeDoneButton.target = self
        timeDoneButton.action = #selector(timeDoneTapped)
    }
    
    @objc private func dateButtonTapped() {
        // KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        isDatePickerOpen.toggle()
        datePickerView.isHidden = !isDatePickerOpen
        
        if isDatePickerOpen {
            // KEYBOARD TRAP IN WIDGET - Focus is trapped inside the date picker widget
            datePicker.becomeFirstResponder()
        }
    }
    
    @objc private func timeButtonTapped() {
        // KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
        isTimePickerOpen.toggle()
        timePickerView.isHidden = !isTimePickerOpen
        
        if isTimePickerOpen {
            // KEYBOARD TRAP IN WIDGET - Focus is trapped inside the time picker widget
            timePicker.becomeFirstResponder()
        }
    }
    
    @objc private func datePickerChanged() {
        selectedDate = datePicker.dateValue
        eventDateButton.title = "📅 \(DateFormatter.shortDate.string(from: selectedDate))"
    }
    
    @objc private func timePickerChanged() {
        selectedTime = timePicker.dateValue
        eventTimeButton.title = "🕐 \(DateFormatter.shortTime.string(from: selectedTime))"
    }
    
    @objc private func dateCancelTapped() {
        isDatePickerOpen = false
        datePickerView.isHidden = true
    }
    
    @objc private func dateDoneTapped() {
        isDatePickerOpen = false
        datePickerView.isHidden = true
    }
    
    @objc private func timeCancelTapped() {
        isTimePickerOpen = false
        timePickerView.isHidden = true
    }
    
    @objc private func timeDoneTapped() {
        isTimePickerOpen = false
        timePickerView.isHidden = true
    }
    
    @objc private func createEventTapped() {
        // Handle create event
        let alert = NSAlert()
        alert.messageText = "Event Created"
        alert.informativeText = "Your event has been created successfully!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func saveDraftTapped() {
        // Handle save draft
        let alert = NSAlert()
        alert.messageText = "Draft Saved"
        alert.informativeText = "Your event draft has been saved!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func cancelTapped() {
        // Handle cancel
        let alert = NSAlert()
        alert.messageText = "Cancel Event"
        alert.informativeText = "Are you sure you want to cancel creating this event?"
        alert.addButton(withTitle: "Cancel Event")
        alert.addButton(withTitle: "Continue Editing")
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            // Close the view or navigate back
        }
    }
}

// MARK: - Date Formatter Extension
extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}

// MARK: - Storyboard Support
extension KeyboardTrapInWidget {
    static func instantiate() -> KeyboardTrapInWidget {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "KeyboardTrapInWidget") as! KeyboardTrapInWidget
    }
}
