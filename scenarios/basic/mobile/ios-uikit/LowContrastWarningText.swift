import UIKit

class LowContrastWarningTextViewController: UIViewController {
    
    private var sessionTimer: Timer?
    private var timeRemaining = 300 // 5 minutes in seconds
    private var isSessionActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startSessionTimer()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Secure Dashboard"
        
        // Main content
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Header
        let headerLabel = UILabel()
        headerLabel.text = "Welcome to Your Dashboard"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 28)
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerLabel)
        
        // Session timeout warning with low contrast
        let warningContainer = UIView()
        warningContainer.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
        warningContainer.layer.cornerRadius = 12
        warningContainer.layer.borderWidth = 1
        warningContainer.layer.borderColor = UIColor.systemYellow.cgColor
        warningContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(warningContainer)
        
        let warningIcon = UILabel()
        warningIcon.text = "⚠️"
        warningIcon.font = UIFont.systemFont(ofSize: 24)
        warningIcon.translatesAutoresizingMaskIntoConstraints = false
        warningContainer.addSubview(warningIcon)
        
        let warningLabel = UILabel()
        warningLabel.text = "Your session will expire in 5 minutes due to inactivity. Please save your work and refresh the page to continue."
        warningLabel.font = UIFont.systemFont(ofSize: 16)
        warningLabel.numberOfLines = 0
        warningLabel.textColor = UIColor.systemYellow.withAlphaComponent(0.7) // Low contrast
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningContainer.addSubview(warningLabel)
        
        let timeRemainingLabel = UILabel()
        timeRemainingLabel.text = "Time remaining: 5:00"
        timeRemainingLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .medium)
        timeRemainingLabel.textColor = UIColor.systemYellow.withAlphaComponent(0.6) // Low contrast
        timeRemainingLabel.textAlignment = .center
        timeRemainingLabel.translatesAutoresizingMaskIntoConstraints = false
        warningContainer.addSubview(timeRemainingLabel)
        
        // Action buttons
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 12
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        warningContainer.addSubview(buttonStackView)
        
        let extendButton = UIButton(type: .system)
        extendButton.setTitle("Extend Session", for: .normal)
        extendButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        extendButton.backgroundColor = UIColor.systemBlue
        extendButton.setTitleColor(.white, for: .normal)
        extendButton.layer.cornerRadius = 8
        extendButton.addTarget(self, action: #selector(extendSessionTapped), for: .touchUpInside)
        buttonStackView.addArrangedSubview(extendButton)
        
        let refreshButton = UIButton(type: .system)
        refreshButton.setTitle("Refresh Now", for: .normal)
        refreshButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        refreshButton.backgroundColor = UIColor.systemGreen
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.layer.cornerRadius = 8
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        buttonStackView.addArrangedSubview(refreshButton)
        
        // Dashboard content
        let dashboardLabel = UILabel()
        dashboardLabel.text = "Dashboard Content"
        dashboardLabel.font = UIFont.boldSystemFont(ofSize: 24)
        dashboardLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dashboardLabel)
        
        // Sample dashboard items
        let dashboardStackView = UIStackView()
        dashboardStackView.axis = .vertical
        dashboardStackView.spacing = 16
        dashboardStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dashboardStackView)
        
        for i in 1...5 {
            let itemView = createDashboardItem(title: "Dashboard Item \(i)", subtitle: "This is a sample dashboard item with some content")
            dashboardStackView.addArrangedSubview(itemView)
        }
        
        // Additional warning with even lower contrast
        let additionalWarningLabel = UILabel()
        additionalWarningLabel.text = "Important: Please note that your session timeout settings can be configured in your account preferences. For security reasons, sessions automatically expire after 30 minutes of inactivity."
        additionalWarningLabel.font = UIFont.systemFont(ofSize: 14)
        additionalWarningLabel.numberOfLines = 0
        additionalWarningLabel.textColor = UIColor.systemGray.withAlphaComponent(0.5) // Very low contrast
        additionalWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(additionalWarningLabel)
        
        // Store references for updates
        self.timeRemainingLabel = timeRemainingLabel
        
        // Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            warningContainer.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            warningContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            warningContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            warningIcon.topAnchor.constraint(equalTo: warningContainer.topAnchor, constant: 16),
            warningIcon.leadingAnchor.constraint(equalTo: warningContainer.leadingAnchor, constant: 16),
            
            warningLabel.topAnchor.constraint(equalTo: warningContainer.topAnchor, constant: 16),
            warningLabel.leadingAnchor.constraint(equalTo: warningIcon.trailingAnchor, constant: 12),
            warningLabel.trailingAnchor.constraint(equalTo: warningContainer.trailingAnchor, constant: -16),
            
            timeRemainingLabel.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 12),
            timeRemainingLabel.leadingAnchor.constraint(equalTo: warningContainer.leadingAnchor, constant: 16),
            timeRemainingLabel.trailingAnchor.constraint(equalTo: warningContainer.trailingAnchor, constant: -16),
            
            buttonStackView.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 16),
            buttonStackView.leadingAnchor.constraint(equalTo: warningContainer.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: warningContainer.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: warningContainer.bottomAnchor, constant: -16),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44),
            
            dashboardLabel.topAnchor.constraint(equalTo: warningContainer.bottomAnchor, constant: 30),
            dashboardLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dashboardLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dashboardStackView.topAnchor.constraint(equalTo: dashboardLabel.bottomAnchor, constant: 16),
            dashboardStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dashboardStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            additionalWarningLabel.topAnchor.constraint(equalTo: dashboardStackView.bottomAnchor, constant: 30),
            additionalWarningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            additionalWarningLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            additionalWarningLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createDashboardItem(title: String, subtitle: String) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.systemGray6
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subtitleLabel)
        
        let chevronImageView = UIImageView()
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = .systemGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        return containerView
    }
    
    private func startSessionTimer() {
        sessionTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func updateTimer() {
        guard isSessionActive else { return }
        
        timeRemaining -= 1
        
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        timeRemainingLabel?.text = String(format: "Time remaining: %d:%02d", minutes, seconds)
        
        if timeRemaining <= 0 {
            sessionExpired()
        } else if timeRemaining <= 60 {
            // Change to red color for last minute
            timeRemainingLabel?.textColor = UIColor.systemRed.withAlphaComponent(0.6) // Still low contrast
        }
    }
    
    private func sessionExpired() {
        isSessionActive = false
        sessionTimer?.invalidate()
        sessionTimer = nil
        
        let alert = UIAlertController(
            title: "Session Expired",
            message: "Your session has expired due to inactivity. Please log in again to continue.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            // Navigate to login screen
            self.navigationController?.popToRootViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    @objc private func extendSessionTapped() {
        timeRemaining = 300 // Reset to 5 minutes
        isSessionActive = true
        timeRemainingLabel?.textColor = UIColor.systemYellow.withAlphaComponent(0.6) // Reset to low contrast
        
        let alert = UIAlertController(
            title: "Session Extended",
            message: "Your session has been extended by 5 minutes.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func refreshTapped() {
        timeRemaining = 300 // Reset to 5 minutes
        isSessionActive = true
        timeRemainingLabel?.textColor = UIColor.systemYellow.withAlphaComponent(0.6) // Reset to low contrast
        
        let alert = UIAlertController(
            title: "Page Refreshed",
            message: "The page has been refreshed and your session has been reset.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    deinit {
        sessionTimer?.invalidate()
    }
    
    private var timeRemainingLabel: UILabel?
}
