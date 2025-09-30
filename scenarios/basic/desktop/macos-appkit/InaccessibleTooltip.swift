import Cocoa

class InaccessibleTooltip: NSViewController {
    
    @IBOutlet weak var formStackView: NSStackView!
    @IBOutlet weak var submitButton: NSButton!
    @IBOutlet weak var clearButton: NSButton!
    
    private var formFields: [FormField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Form Fields
        setupFormFields()
        
        // Action Buttons
        submitButton.title = "Submit Form"
        submitButton.font = NSFont.boldSystemFont(ofSize: 16)
        submitButton.bezelStyle = .rounded
        submitButton.target = self
        submitButton.action = #selector(submitTapped)
        
        clearButton.title = "Clear Form"
        clearButton.font = NSFont.boldSystemFont(ofSize: 16)
        clearButton.bezelStyle = .texturedRounded
        clearButton.target = self
        clearButton.action = #selector(clearTapped)
    }
    
    private func setupFormFields() {
        let fieldConfigs = [
            ("Full Name", "Enter your full name", "Enter your full legal name"),
            ("Email Address", "Enter your email", "Enter a valid email address"),
            ("Phone Number", "Enter your phone number", "Include country code if international"),
            ("Street Address", "Enter your street address", "Include apartment or suite number"),
            ("City", "Enter your city", "Enter the city name"),
            ("ZIP Code", "Enter your ZIP code", "Enter 5-digit ZIP code")
        ]
        
        for (label, placeholder, tooltip) in fieldConfigs {
            let fieldView = createFormField(label: label, placeholder: placeholder, tooltip: tooltip)
            formFields.append(FormField(label: label, textField: fieldView.textField, helpButton: fieldView.helpButton))
            formStackView.addArrangedSubview(fieldView.containerView)
        }
    }
    
    private func createFormField(label: String, placeholder: String, tooltip: String) -> (containerView: NSView, textField: NSTextField, helpButton: NSButton) {
        let containerView = NSView()
        
        let labelField = NSTextField()
        labelField.stringValue = label
        labelField.font = NSFont.boldSystemFont(ofSize: 16)
        labelField.isEditable = false
        labelField.isBordered = false
        labelField.backgroundColor = .clear
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        let helpButton = NSButton()
        helpButton.title = "?"
        helpButton.font = NSFont.boldSystemFont(ofSize: 16)
        helpButton.wantsLayer = true
        helpButton.layer?.backgroundColor = NSColor.systemBlue.cgColor
        helpButton.layer?.cornerRadius = 10
        helpButton.contentTintColor = .white
        helpButton.target = self
        helpButton.action = #selector(helpButtonTapped)
        helpButton.toolTip = tooltip // INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        
        let textField = NSTextField()
        textField.placeholderString = placeholder
        textField.font = NSFont.systemFont(ofSize: 16)
        textField.target = self
        textField.action = #selector(textFieldChanged)
        
        containerView.addSubview(labelField)
        containerView.addSubview(helpButton)
        containerView.addSubview(textField)
        
        labelField.translatesAutoresizingMaskIntoConstraints = false
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            labelField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelField.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            helpButton.leadingAnchor.constraint(equalTo: labelField.trailingAnchor, constant: 8),
            helpButton.centerYAnchor.constraint(equalTo: labelField.centerYAnchor),
            helpButton.widthAnchor.constraint(equalToConstant: 20),
            helpButton.heightAnchor.constraint(equalToConstant: 20),
            
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textField.topAnchor.constraint(equalTo: labelField.bottomAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return (containerView, textField, helpButton)
    }
    
    @objc private func helpButtonTapped(_ sender: NSButton) {
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        // This method is called when the help button is clicked, but the tooltip is not accessible via keyboard
        let alert = NSAlert()
        alert.messageText = "Help"
        alert.informativeText = "This help information should be accessible via keyboard navigation, but currently it's only available through mouse hover."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func textFieldChanged(_ sender: NSTextField) {
        // Handle text field change
    }
    
    @objc private func submitTapped() {
        // Handle submit
        let alert = NSAlert()
        alert.messageText = "Form Submitted"
        alert.informativeText = "Your form has been submitted successfully!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func clearTapped() {
        // Handle clear
        for field in formFields {
            field.textField.stringValue = ""
        }
    }
}

// MARK: - Form Field Model
struct FormField {
    let label: String
    let textField: NSTextField
    let helpButton: NSButton
}

// MARK: - Storyboard Support
extension InaccessibleTooltip {
    static func instantiate() -> InaccessibleTooltip {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "InaccessibleTooltip") as! InaccessibleTooltip
    }
}
