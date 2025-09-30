import Cocoa

class ColorOnlyErrorIndication: NSViewController {
    
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
        submitButton.title = "Create Account"
        submitButton.font = NSFont.boldSystemFont(ofSize: 16)
        submitButton.bezelStyle = .rounded
        submitButton.target = self
        submitButton.action = #selector(submitTapped)
        
        clearButton.title = "Cancel"
        clearButton.font = NSFont.boldSystemFont(ofSize: 16)
        clearButton.bezelStyle = .texturedRounded
        clearButton.target = self
        clearButton.action = #selector(clearTapped)
    }
    
    private func setupFormFields() {
        let fieldConfigs = [
            ("Full Name", "Enter your full name"),
            ("Email Address", "Enter your email"),
            ("Password", "Enter your password"),
            ("Confirm Password", "Confirm your password"),
            ("Phone Number", "Enter your phone number"),
            ("ZIP Code", "Enter your ZIP code")
        ]
        
        for (label, placeholder) in fieldConfigs {
            let fieldView = createFormField(label: label, placeholder: placeholder)
            formFields.append(FormField(label: label, textField: fieldView.textField))
            formStackView.addArrangedSubview(fieldView.containerView)
        }
    }
    
    private func createFormField(label: String, placeholder: String) -> (containerView: NSView, textField: NSTextField) {
        let containerView = NSView()
        
        let labelField = NSTextField()
        labelField.stringValue = label
        labelField.font = NSFont.boldSystemFont(ofSize: 16)
        labelField.isEditable = false
        labelField.isBordered = false
        labelField.backgroundColor = .clear
        
        let textField = NSTextField()
        textField.placeholderString = placeholder
        textField.font = NSFont.systemFont(ofSize: 16)
        textField.target = self
        textField.action = #selector(textFieldChanged)
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        textField.wantsLayer = true
        textField.layer?.borderWidth = 2
        textField.layer?.borderColor = NSColor.systemRed.cgColor
        textField.layer?.cornerRadius = 8
        
        containerView.addSubview(labelField)
        containerView.addSubview(textField)
        
        labelField.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            labelField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelField.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textField.topAnchor.constraint(equalTo: labelField.bottomAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return (containerView, textField)
    }
    
    @objc private func textFieldChanged(_ sender: NSTextField) {
        // Handle text field change
        // COLOR-ONLY ERROR INDICATION - No text error message, only red border
    }
    
    @objc private func submitTapped() {
        // Handle submit
        let alert = NSAlert()
        alert.messageText = "Form Submitted"
        alert.informativeText = "Your account has been created successfully!"
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
}

// MARK: - Storyboard Support
extension ColorOnlyErrorIndication {
    static func instantiate() -> ColorOnlyErrorIndication {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "ColorOnlyErrorIndication") as! ColorOnlyErrorIndication
    }
}
