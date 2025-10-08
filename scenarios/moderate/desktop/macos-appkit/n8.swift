import Cocoa
class ToastNotificationIssuesViewController: NSViewController {
    // MARK: - UI Elements
    @IBOutlet weak var showSuccessButton: NSButton!
    @IBOutlet weak var showErrorButton: NSButton!
    @IBOutlet weak var showWarningButton: NSButton!
    @IBOutlet weak var showInfoButton: NSButton!
    @IBOutlet weak var clearAllButton: NSButton!
    @IBOutlet weak var toastContainer: NSStackView!
    // MARK: - State
    private var notifications: [ToastNotification] = []
    private var notificationCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        // Configure buttons
        showSuccessButton.title = "Show Success Notification"
        showSuccessButton.target = self
        showSuccessButton.action = #selector(showSuccessClicked)
        showSuccessButton.bezelStyle = .rounded
        showSuccessButton.contentTintColor = .systemGreen
        showErrorButton.title = "Show Error Notification"
        showErrorButton.target = self
        showErrorButton.action = #selector(showErrorClicked)
        showErrorButton.bezelStyle = .rounded
        showErrorButton.contentTintColor = .systemRed
        showWarningButton.title = "Show Warning Notification"
        showWarningButton.target = self
        showWarningButton.action = #selector(showWarningClicked)
        showWarningButton.bezelStyle = .rounded
        showWarningButton.contentTintColor = .systemOrange
        showInfoButton.title = "Show Info Notification"
        showInfoButton.target = self
        showInfoButton.action = #selector(showInfoClicked)
        showInfoButton.bezelStyle = .rounded
        showInfoButton.contentTintColor = .systemBlue
        clearAllButton.title = "Clear All Notifications"
        clearAllButton.target = self
        clearAllButton.action = #selector(clearAllClicked)
        clearAllButton.bezelStyle = .rounded
        // Configure toast container
        toastContainer.orientation = .vertical
        toastContainer.spacing = 10
        toastContainer.alignment = .leading
    }
        // Basic setup only
    }
    @objc private func showSuccessClicked() {
        showToast(type: .success, message: "Operation completed successfully!")
    }
    @objc private func showErrorClicked() {
        showToast(type: .error, message: "An error occurred while processing your request.")
    }
    @objc private func showWarningClicked() {
        showToast(type: .warning, message: "Please review your input before proceeding.")
    }
    @objc private func showInfoClicked() {
        showToast(type: .info, message: "New updates are available for download.")
    }
    @objc private func clearAllClicked() {
        clearAllNotifications()
    }
    private func showToast(type: ToastType, message: String) {
        notificationCount += 1
        let notification = ToastNotification(
            id: notificationCount,
            type: type,
            message: message
        )
        notifications.insert(notification, at: 0)
        // Create toast view
        let toastView = createToastView(for: notification)
        toastContainer.insertArrangedSubview(toastView, at: 0)
        // Should implement auto-hide functionality with configurable duration
        // Basic auto-hide (5 seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.removeToast(notification)
        }
    }
    private func createToastView(for notification: ToastNotification) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = notification.type.color.withAlphaComponent(0.1).cgColor
        containerView.layer?.cornerRadius = 8
        containerView.layer?.borderWidth = 1
        containerView.layer?.borderColor = notification.type.color.withAlphaComponent(0.3).cgColor
        let stackView = NSStackView()
        stackView.orientation = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        // Icon
        // Message
        let dismissButton = NSButton()
        dismissButton.title = "×"
        dismissButton.bezelStyle = .rounded
        dismissButton.isBordered = false
        dismissButton.font = NSFont.systemFont(ofSize: 16, weight: .bold)
        dismissButton.target = self
        dismissButton.action = #selector(dismissToast(_:))
        dismissButton.tag = notification.id
        dismissButton.setContentHuggingPriority(.required, for: .horizontal)
        stackView.addArrangedSubview(dismissButton)
        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
        ])
        // Basic setup only
        return containerView
    }
    @objc private func dismissToast(_ sender: NSButton) {
        let notificationId = sender.tag
        if let notification = notifications.first(where: { $0.id == notificationId }) {
            removeToast(notification)
        }
    }
    private func removeToast(_ notification: ToastNotification) {
        notifications.removeAll { $0.id == notification.id }
        // Remove from UI
        for arrangedSubview in toastContainer.arrangedSubviews {
                toastContainer.removeArrangedSubview(arrangedSubview)
                arrangedSubview.removeFromSuperview()
                break
            }
        }
    }
    private func clearAllNotifications() {
        notifications.removeAll()
        notificationCount = 0
        // Remove all toast views
        for arrangedSubview in toastContainer.arrangedSubviews {
            toastContainer.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
    }
    // Should implement methods to:
    // 4. Provide programmatic access to notification content
}
enum ToastType: String {
    case success, error, warning, info
    var color: NSColor {
        switch self {
        case .success: return .systemGreen
        case .error: return .systemRed
        case .warning: return .systemOrange
        case .info: return .systemBlue
        }
    }
    var icon: String {
        switch self {
        case .success: return "✓"
        case .error: return "✗"
        case .warning: return "⚠"
        case .info: return "ℹ"
        }
    }
}
struct ToastNotification {
    let id: Int
    let type: ToastType
    let message: String
}
/*
 • Missing dismiss button: No way to close notifications programmatically
 • No auto-hide timer: Notifications don't disappear automatically
 
 • Implement auto-hide timer with configurable duration
 */
