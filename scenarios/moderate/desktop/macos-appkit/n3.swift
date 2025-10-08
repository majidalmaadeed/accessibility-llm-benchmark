import Cocoa
class FormValidationWithoutAssociationViewController: NSViewController {
    // MARK: - UI Elements
    @IBOutlet weak var usernameField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var genericErrorPanel: NSView!
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    // MARK: - State
    private var isSubmitting = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        // Configure username field
        usernameField.placeholderString = "Enter username"
        usernameField.target = self
        usernameField.action = #selector(usernameChanged)
        // Configure password field
        passwordField.placeholderString = "Enter password"
        passwordField.target = self
        passwordField.action = #selector(passwordChanged)
        // Configure generic error panel
        genericErrorPanel.isHidden = true
        genericErrorPanel.wantsLayer = true
        genericErrorPanel.layer?.backgroundColor = NSColor.systemRed.withAlphaComponent(0.1).cgColor
        genericErrorPanel.layer?.cornerRadius = 8
        genericErrorPanel.layer?.borderWidth = 1
        genericErrorPanel.layer?.borderColor = NSColor.systemRed.withAlphaComponent(0.3).cgColor
        // Configure login button
        loginButton.title = "Login"
        loginButton.target = self
        loginButton.action = #selector(loginClicked)
        // Configure progress indicator
        progressIndicator.isHidden = true
        progressIndicator.style = .spinning
    }
        // Basic setup only
    }
    @objc private func usernameChanged() {
        clearFieldError(field: "username")
    }
    @objc private func passwordChanged() {
        clearFieldError(field: "password")
    }
    @objc private func loginClicked() {
        guard !isSubmitting else { return }
        clearAllErrors()
        let username = usernameField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.stringValue
        var hasErrors = false
        // Validate username
        if username.isEmpty {
            showFieldError(field: "username", message: "Username is required")
            hasErrors = true
        } else if username.count < 3 {
            showFieldError(field: "username", message: "Username must be at least 3 characters")
            hasErrors = true
        }
        // Validate password
        if password.isEmpty {
            showFieldError(field: "password", message: "Password is required")
            hasErrors = true
        } else if password.count < 8 {
            showFieldError(field: "password", message: "Password must be at least 8 characters")
            hasErrors = true
        }
        if hasErrors {
            // Show generic error message - NOT ASSOCIATED WITH SPECIFIC FIELDS
            showGenericError("Please fill in all required fields.")
            return
        }
        // Simulate login process
        isSubmitting = true
        loginButton.title = "Logging in..."
        loginButton.isEnabled = false
        progressIndicator.isHidden = false
        progressIndicator.startAnimation(nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isSubmitting = false
            self.loginButton.title = "Login"
            self.loginButton.isEnabled = true
            self.progressIndicator.isHidden = true
            self.progressIndicator.stopAnimation(nil)
            // Show success message
            let alert = NSAlert()
            alert.messageText = "Success"
            alert.informativeText = "Login successful!"
            alert.alertStyle = .informational
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    private func clearAllErrors() {
        genericErrorPanel.isHidden = true
        // Reset field borders
        usernameField.layer?.borderWidth = 0
        passwordField.layer?.borderWidth = 0
    }
    private func clearFieldError(field: String) {
        switch field.lowercased() {
        case "username":
            usernameField.layer?.borderWidth = 0
        case "password":
            passwordField.layer?.borderWidth = 0
        default:
            break
        }
    }
    private func showFieldError(field: String, message: String) {
        switch field.lowercased() {
        case "username":
            usernameField.layer?.borderWidth = 2
            usernameField.layer?.borderColor = NSColor.systemRed.cgColor
        case "password":
            passwordField.layer?.borderWidth = 2
            passwordField.layer?.borderColor = NSColor.systemRed.cgColor
        default:
            break
        }
    }
    private func showGenericError(_ message: String) {
        genericErrorPanel.isHidden = false
    }
}
/*
 • Generic error: Generic error message doesn't specify which fields have issues
 
 • Use specific error messages for each field
 */
