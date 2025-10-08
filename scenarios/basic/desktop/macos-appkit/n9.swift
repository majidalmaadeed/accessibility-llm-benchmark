import Cocoa

class LowContrastWarningText: NSViewController {
    
    @IBOutlet weak var warningBanner: NSView!
    @IBOutlet weak var warningIcon: NSTextField!
    @IBOutlet weak var warningTitle: NSTextField!
    @IBOutlet weak var warningMessage: NSTextField!
    @IBOutlet weak var extendButton: NSButton!
    @IBOutlet weak var logoutButton: NSButton!
    @IBOutlet weak var flashCountLabel: NSTextField!
    
    @IBOutlet weak var dashboardTitle: NSTextField!
    @IBOutlet weak var dashboardSubtitle: NSTextField!
    @IBOutlet weak var timeRemainingLabel: NSTextField!
    
    @IBOutlet weak var quickActionsStackView: NSStackView!
    @IBOutlet weak var recentActivityStackView: NSStackView!
    
    private var flashCount = 0
    private var flashTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startFlashAnimation()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Warning Banner - LOW CONTRAST WARNING TEXT
        warningBanner.wantsLayer = true
        warningBanner.layer?.backgroundColor = NSColor.systemRed.cgColor
        
        // LOW CONTRAST WARNING TEXT - Session timeout warning with insufficient color contrast
        warningIcon.stringValue = "⚠️"
        warningIcon.font = NSFont.systemFont(ofSize: 24)
        warningIcon.textColor = NSColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1.0) // #757575
        
        warningTitle.stringValue = "Session Timeout Warning"
        warningTitle.font = NSFont.boldSystemFont(ofSize: 16)
        warningTitle.textColor = NSColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1.0) // #757575
        
        warningMessage.stringValue = "Your session will expire in 5 minutes. Please save your work and extend your session to continue."
        warningMessage.font = NSFont.systemFont(ofSize: 14)
        warningMessage.textColor = NSColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1.0) // #BDBDBD
        
        // Action Buttons - LOW CONTRAST
        extendButton.title = "Extend"
        extendButton.bezelStyle = .rounded
        extendButton.target = self
        extendButton.action = #selector(extendSession)
        extendButton.font = NSFont.systemFont(ofSize: 14)
        extendButton.contentTintColor = NSColor(red: 0.56, green: 0.79, blue: 0.98, alpha: 1.0) // #90CAF9
        
        logoutButton.title = "Logout"
        logoutButton.bezelStyle = .rounded
        logoutButton.target = self
        logoutButton.action = #selector(logout)
        logoutButton.font = NSFont.systemFont(ofSize: 14)
        logoutButton.contentTintColor = NSColor(red: 0.94, green: 0.6, blue: 0.6, alpha: 1.0) // #EF9A9A
        
        flashCountLabel.stringValue = "Flashes: 0"
        flashCountLabel.font = NSFont.systemFont(ofSize: 12)
        flashCountLabel.textColor = .white
        flashCountLabel.backgroundColor = NSColor.black.withAlphaComponent(0.2)
        flashCountLabel.wantsLayer = true
        flashCountLabel.layer?.cornerRadius = 6
        
        // Dashboard Content
        dashboardTitle.stringValue = "Welcome back!"
        dashboardTitle.font = NSFont.systemFont(ofSize: 24, weight: .bold)
        
        dashboardSubtitle.stringValue = "Your session is active and secure"
        dashboardSubtitle.font = NSFont.systemFont(ofSize: 18)
        dashboardSubtitle.textColor = .secondaryLabelColor
        
        timeRemainingLabel.stringValue = "⏰ 5 minutes remaining"
        timeRemainingLabel.font = NSFont.systemFont(ofSize: 14)
        timeRemainingLabel.textColor = .secondaryLabelColor
        
        setupQuickActions()
        setupRecentActivity()
    }
    
    private func setupQuickActions() {
        let actions = [
            ("📊", "View Reports", "Learn new skills"),
            ("👥", "Manage Users", "User management"),
            ("⚙️", "Settings", "App configuration"),
            ("❓", "Help & Support", "Get assistance")
        ]
        
        for (icon, title, subtitle) in actions {
            let actionView = createActionView(icon: icon, title: title, subtitle: subtitle)
            quickActionsStackView.addArrangedSubview(actionView)
        }
    }
    
    private func setupRecentActivity() {
        let activities = [
            ("🟢", "User logged in", "2 minutes ago"),
            ("📊", "Report generated", "15 minutes ago"),
            ("⚙️", "Settings updated", "1 hour ago")
        ]
        
        for (icon, title, time) in activities {
            let activityView = createActivityView(icon: icon, title: title, time: time)
            recentActivityStackView.addArrangedSubview(activityView)
        }
    }
    
    private func createActionView(icon: String, title: String, subtitle: String) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        containerView.layer?.cornerRadius = 8
        containerView.layer?.shadowOpacity = 0.2
        containerView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        containerView.layer?.shadowRadius = 4
        
        let iconLabel = NSTextField()
        iconLabel.stringValue = icon
        iconLabel.font = NSFont.systemFont(ofSize: 32)
        iconLabel.isEditable = false
        iconLabel.isBordered = false
        iconLabel.backgroundColor = .clear
        
        let titleLabel = NSTextField()
        titleLabel.stringValue = title
        titleLabel.font = NSFont.boldSystemFont(ofSize: 16)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = .clear
        
        let subtitleLabel = NSTextField()
        subtitleLabel.stringValue = subtitle
        subtitleLabel.font = NSFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .secondaryLabelColor
        subtitleLabel.isEditable = false
        subtitleLabel.isBordered = false
        subtitleLabel.backgroundColor = .clear
        
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            iconLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 8),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    private func createActivityView(icon: String, title: String, time: String) -> NSView {
        let containerView = NSView()
        
        let iconLabel = NSTextField()
        iconLabel.stringValue = icon
        iconLabel.font = NSFont.systemFont(ofSize: 16)
        iconLabel.isEditable = false
        iconLabel.isBordered = false
        iconLabel.backgroundColor = .clear
        
        let titleLabel = NSTextField()
        titleLabel.stringValue = title
        titleLabel.font = NSFont.boldSystemFont(ofSize: 14)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = .clear
        
        let timeLabel = NSTextField()
        timeLabel.stringValue = time
        timeLabel.font = NSFont.systemFont(ofSize: 12)
        timeLabel.textColor = .secondaryLabelColor
        timeLabel.isEditable = false
        timeLabel.isBordered = false
        timeLabel.backgroundColor = .clear
        
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            iconLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconLabel.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            timeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor)
        ])
        
        return containerView
    }
    
    private func startFlashAnimation() {
        flashTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.flashCount += 1
            self.flashCountLabel.stringValue = "Flashes: \(self.flashCount)"
            
            // Toggle between red and orange
            let currentColor = self.warningBanner.layer?.backgroundColor
            let newColor = currentColor == NSColor.systemRed.cgColor ? NSColor.systemOrange.cgColor : NSColor.systemRed.cgColor
            self.warningBanner.layer?.backgroundColor = newColor
        }
    }
    
    @objc private func extendSession() {
        // Handle extend session
        flashTimer?.invalidate()
        warningBanner.isHidden = true
    }
    
    @objc private func logout() {
        // Handle logout
        flashTimer?.invalidate()
        // Navigate to login screen
    }
    
    deinit {
        flashTimer?.invalidate()
    }
}

// MARK: - Storyboard Support
extension LowContrastWarningText {
    static func instantiate() -> LowContrastWarningText {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "LowContrastWarningText") as! LowContrastWarningText
    }
}
