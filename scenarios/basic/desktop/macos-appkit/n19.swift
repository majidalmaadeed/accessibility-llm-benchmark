import Cocoa

class UngroupedRadioButtons: NSViewController {
    
    @IBOutlet weak var contactMethodStackView: NSStackView!
    @IBOutlet weak var newsletterStackView: NSStackView!
    @IBOutlet weak var notificationsStackView: NSStackView!
    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    
    private var contactMethodButtons: [NSButton] = []
    private var newsletterButtons: [NSButton] = []
    private var notificationButtons: [NSButton] = []
    
    private var selectedContactMethod = "email"
    private var selectedNewsletter = "yes"
    private var selectedNotifications = "all"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Contact Method Section - UNGROUPED RADIO BUTTONS
        setupContactMethodSection()
        
        // Newsletter Subscription Section - UNGROUPED RADIO BUTTONS
        setupNewsletterSection()
        
        // Notification Preferences Section - UNGROUPED RADIO BUTTONS
        setupNotificationsSection()
        
        // Action Buttons
        saveButton.title = "Save Preferences"
        saveButton.font = NSFont.boldSystemFont(ofSize: 16)
        saveButton.bezelStyle = .rounded
        saveButton.target = self
        saveButton.action = #selector(saveTapped)
        
        resetButton.title = "Reset to Defaults"
        resetButton.font = NSFont.boldSystemFont(ofSize: 16)
        resetButton.bezelStyle = .texturedRounded
        resetButton.target = self
        resetButton.action = #selector(resetTapped)
    }
    
    private func setupContactMethodSection() {
        let contactMethods = [
            ("email", "Email"),
            ("phone", "Phone"),
            ("sms", "SMS"),
            ("mail", "Mail")
        ]
        
        for (value, title) in contactMethods {
            let button = NSButton()
            button.setButtonType(.radio)
            button.title = title
            button.target = self
            button.action = #selector(contactMethodChanged)
            button.tag = contactMethods.firstIndex(where: { $0.0 == value }) ?? 0
            
            if value == selectedContactMethod {
                button.state = .on
            }
            
            contactMethodButtons.append(button)
            contactMethodStackView.addArrangedSubview(button)
        }
    }
    
    private func setupNewsletterSection() {
        let newsletterOptions = [
            ("yes", "Yes, send me newsletters"),
            ("no", "No, don't send newsletters")
        ]
        
        for (value, title) in newsletterOptions {
            let button = NSButton()
            button.setButtonType(.radio)
            button.title = title
            button.target = self
            button.action = #selector(newsletterChanged)
            button.tag = newsletterOptions.firstIndex(where: { $0.0 == value }) ?? 0
            
            if value == selectedNewsletter {
                button.state = .on
            }
            
            newsletterButtons.append(button)
            newsletterStackView.addArrangedSubview(button)
        }
    }
    
    private func setupNotificationsSection() {
        let notificationOptions = [
            ("all", "All notifications"),
            ("important", "Important only"),
            ("none", "No notifications")
        ]
        
        for (value, title) in notificationOptions {
            let button = NSButton()
            button.setButtonType(.radio)
            button.title = title
            button.target = self
            button.action = #selector(notificationsChanged)
            button.tag = notificationOptions.firstIndex(where: { $0.0 == value }) ?? 0
            
            if value == selectedNotifications {
                button.state = .on
            }
            
            notificationButtons.append(button)
            notificationsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func contactMethodChanged(_ sender: NSButton) {
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        for (index, button) in contactMethodButtons.enumerated() {
            button.state = (button == sender) ? .on : .off
            if button.state == .on {
                let contactMethods = ["email", "phone", "sms", "mail"]
                selectedContactMethod = contactMethods[index]
            }
        }
    }
    
    @objc private func newsletterChanged(_ sender: NSButton) {
        // UNGROUPED RADIO BUTTONS - Newsletter preference radio buttons without fieldset grouping
        for (index, button) in newsletterButtons.enumerated() {
            button.state = (button == sender) ? .on : .off
            if button.state == .on {
                let newsletterOptions = ["yes", "no"]
                selectedNewsletter = newsletterOptions[index]
            }
        }
    }
    
    @objc private func notificationsChanged(_ sender: NSButton) {
        // UNGROUPED RADIO BUTTONS - Notification preference radio buttons without fieldset grouping
        for (index, button) in notificationButtons.enumerated() {
            button.state = (button == sender) ? .on : .off
            if button.state == .on {
                let notificationOptions = ["all", "important", "none"]
                selectedNotifications = notificationOptions[index]
            }
        }
    }
    
    @objc private func saveTapped() {
        // Handle save
        let alert = NSAlert()
        alert.messageText = "Preferences Saved"
        alert.informativeText = """
        Contact Method: \(selectedContactMethod)
        Newsletter: \(selectedNewsletter)
        Notifications: \(selectedNotifications)
        """
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func resetTapped() {
        // Handle reset
        selectedContactMethod = "email"
        selectedNewsletter = "yes"
        selectedNotifications = "all"
        
        // Reset contact method buttons
        for (index, button) in contactMethodButtons.enumerated() {
            button.state = (index == 0) ? .on : .off
        }
        
        // Reset newsletter buttons
        for (index, button) in newsletterButtons.enumerated() {
            button.state = (index == 0) ? .on : .off
        }
        
        // Reset notification buttons
        for (index, button) in notificationButtons.enumerated() {
            button.state = (index == 0) ? .on : .off
        }
    }
}

// MARK: - Storyboard Support
extension UngroupedRadioButtons {
    static func instantiate() -> UngroupedRadioButtons {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "UngroupedRadioButtons") as! UngroupedRadioButtons
    }
}
