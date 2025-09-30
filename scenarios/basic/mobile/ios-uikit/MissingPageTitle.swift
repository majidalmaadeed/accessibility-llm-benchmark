import UIKit

class MissingPageTitleViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        // Missing page title - no title set
        
        // Scroll view setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Header section
        let headerView = createHeaderView()
        contentView.addSubview(headerView)
        
        // Settings sections
        let generalSettingsView = createGeneralSettingsView()
        contentView.addSubview(generalSettingsView)
        
        let privacySettingsView = createPrivacySettingsView()
        contentView.addSubview(privacySettingsView)
        
        let notificationSettingsView = createNotificationSettingsView()
        contentView.addSubview(notificationSettingsView)
        
        let accountSettingsView = createAccountSettingsView()
        contentView.addSubview(accountSettingsView)
        
        // Footer
        let footerView = createFooterView()
        contentView.addSubview(footerView)
        
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
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            generalSettingsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            generalSettingsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            generalSettingsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            privacySettingsView.topAnchor.constraint(equalTo: generalSettingsView.bottomAnchor, constant: 20),
            privacySettingsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            privacySettingsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            notificationSettingsView.topAnchor.constraint(equalTo: privacySettingsView.bottomAnchor, constant: 20),
            notificationSettingsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            notificationSettingsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            accountSettingsView.topAnchor.constraint(equalTo: notificationSettingsView.bottomAnchor, constant: 20),
            accountSettingsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            accountSettingsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: accountSettingsView.bottomAnchor, constant: 20),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Configure your application preferences"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.9
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -15),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -20),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -20)
        ])
        
        return headerView
    }
    
    private func createGeneralSettingsView() -> UIView {
        let settingsView = UIView()
        settingsView.backgroundColor = .systemBackground
        settingsView.layer.cornerRadius = 12
        settingsView.layer.shadowColor = UIColor.black.cgColor
        settingsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        settingsView.layer.shadowRadius = 4
        settingsView.layer.shadowOpacity = 0.1
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "General Settings"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(stackView)
        
        let languageSetting = createSettingItem(title: "Language", value: "English", action: #selector(languageTapped))
        let themeSetting = createSettingItem(title: "Theme", value: "System", action: #selector(themeTapped))
        let fontSizeSetting = createSettingItem(title: "Font Size", value: "Medium", action: #selector(fontSizeTapped))
        let autoSaveSetting = createToggleSetting(title: "Auto Save", isOn: true, action: #selector(autoSaveToggled(_:)))
        
        stackView.addArrangedSubview(languageSetting)
        stackView.addArrangedSubview(themeSetting)
        stackView.addArrangedSubview(fontSizeSetting)
        stackView.addArrangedSubview(autoSaveSetting)
        
        NSLayoutConstraint.activate([
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20)
        ])
        
        return settingsView
    }
    
    private func createPrivacySettingsView() -> UIView {
        let settingsView = UIView()
        settingsView.backgroundColor = .systemBackground
        settingsView.layer.cornerRadius = 12
        settingsView.layer.shadowColor = UIColor.black.cgColor
        settingsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        settingsView.layer.shadowRadius = 4
        settingsView.layer.shadowOpacity = 0.1
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Privacy & Security"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(stackView)
        
        let dataCollectionSetting = createToggleSetting(title: "Data Collection", isOn: false, action: #selector(dataCollectionToggled(_:)))
        let analyticsSetting = createToggleSetting(title: "Analytics", isOn: true, action: #selector(analyticsToggled(_:)))
        let crashReportingSetting = createToggleSetting(title: "Crash Reporting", isOn: true, action: #selector(crashReportingToggled(_:)))
        let locationSetting = createToggleSetting(title: "Location Services", isOn: false, action: #selector(locationToggled(_:)))
        
        stackView.addArrangedSubview(dataCollectionSetting)
        stackView.addArrangedSubview(analyticsSetting)
        stackView.addArrangedSubview(crashReportingSetting)
        stackView.addArrangedSubview(locationSetting)
        
        NSLayoutConstraint.activate([
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20)
        ])
        
        return settingsView
    }
    
    private func createNotificationSettingsView() -> UIView {
        let settingsView = UIView()
        settingsView.backgroundColor = .systemBackground
        settingsView.layer.cornerRadius = 12
        settingsView.layer.shadowColor = UIColor.black.cgColor
        settingsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        settingsView.layer.shadowRadius = 4
        settingsView.layer.shadowOpacity = 0.1
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Notifications"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(stackView)
        
        let pushSetting = createToggleSetting(title: "Push Notifications", isOn: true, action: #selector(pushToggled(_:)))
        let emailSetting = createToggleSetting(title: "Email Notifications", isOn: false, action: #selector(emailToggled(_:)))
        let smsSetting = createToggleSetting(title: "SMS Notifications", isOn: false, action: #selector(smsToggled(_:)))
        let soundSetting = createToggleSetting(title: "Notification Sounds", isOn: true, action: #selector(soundToggled(_:)))
        
        stackView.addArrangedSubview(pushSetting)
        stackView.addArrangedSubview(emailSetting)
        stackView.addArrangedSubview(smsSetting)
        stackView.addArrangedSubview(soundSetting)
        
        NSLayoutConstraint.activate([
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20)
        ])
        
        return settingsView
    }
    
    private func createAccountSettingsView() -> UIView {
        let settingsView = UIView()
        settingsView.backgroundColor = .systemBackground
        settingsView.layer.cornerRadius = 12
        settingsView.layer.shadowColor = UIColor.black.cgColor
        settingsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        settingsView.layer.shadowRadius = 4
        settingsView.layer.shadowOpacity = 0.1
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Account"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(stackView)
        
        let profileSetting = createSettingItem(title: "Profile", value: "Edit Profile", action: #selector(profileTapped))
        let passwordSetting = createSettingItem(title: "Password", value: "Change Password", action: #selector(passwordTapped))
        let twoFactorSetting = createToggleSetting(title: "Two-Factor Authentication", isOn: false, action: #selector(twoFactorToggled(_:)))
        let deleteAccountSetting = createSettingItem(title: "Delete Account", value: "Permanent", action: #selector(deleteAccountTapped))
        
        stackView.addArrangedSubview(profileSetting)
        stackView.addArrangedSubview(passwordSetting)
        stackView.addArrangedSubview(twoFactorSetting)
        stackView.addArrangedSubview(deleteAccountSetting)
        
        NSLayoutConstraint.activate([
            settingsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20)
        ])
        
        return settingsView
    }
    
    private func createSettingItem(title: String, value: String, action: Selector) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = .systemGray6
        itemView.layer.cornerRadius = 8
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(titleLabel)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.textColor = .secondaryLabel
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(valueLabel)
        
        let chevronImageView = UIImageView()
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = .systemGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(chevronImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        itemView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            itemView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -8),
            
            valueLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            valueLabel.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        return itemView
    }
    
    private func createToggleSetting(title: String, isOn: Bool, action: Selector) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = .systemGray6
        itemView.layer.cornerRadius = 8
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(titleLabel)
        
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = isOn
        toggleSwitch.addTarget(self, action: action, for: .valueChanged)
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            itemView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: toggleSwitch.leadingAnchor, constant: -8),
            
            toggleSwitch.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -16),
            toggleSwitch.centerYAnchor.constraint(equalTo: itemView.centerYAnchor)
        ])
        
        return itemView
    }
    
    private func createFooterView() -> UIView {
        let footerView = UIView()
        footerView.backgroundColor = .systemGray6
        footerView.layer.cornerRadius = 12
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let versionLabel = UILabel()
        versionLabel.text = "Version 1.0.0"
        versionLabel.font = UIFont.systemFont(ofSize: 14)
        versionLabel.textColor = .secondaryLabel
        versionLabel.textAlignment = .center
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(versionLabel)
        
        let buildLabel = UILabel()
        buildLabel.text = "Build 2024.01.15"
        buildLabel.font = UIFont.systemFont(ofSize: 12)
        buildLabel.textColor = .tertiaryLabel
        buildLabel.textAlignment = .center
        buildLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(buildLabel)
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 80),
            
            versionLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            versionLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: -8),
            versionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: footerView.leadingAnchor, constant: 20),
            versionLabel.trailingAnchor.constraint(lessThanOrEqualTo: footerView.trailingAnchor, constant: -20),
            
            buildLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            buildLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 4),
            buildLabel.leadingAnchor.constraint(greaterThanOrEqualTo: footerView.leadingAnchor, constant: 20),
            buildLabel.trailingAnchor.constraint(lessThanOrEqualTo: footerView.trailingAnchor, constant: -20)
        ])
        
        return footerView
    }
    
    // MARK: - Actions
    @objc private func languageTapped() {
        showAlert(title: "Language", message: "Select your preferred language")
    }
    
    @objc private func themeTapped() {
        showAlert(title: "Theme", message: "Choose your app theme")
    }
    
    @objc private func fontSizeTapped() {
        showAlert(title: "Font Size", message: "Adjust text size")
    }
    
    @objc private func autoSaveToggled(_ sender: UISwitch) {
        showAlert(title: "Auto Save", message: sender.isOn ? "Auto save enabled" : "Auto save disabled")
    }
    
    @objc private func dataCollectionToggled(_ sender: UISwitch) {
        showAlert(title: "Data Collection", message: sender.isOn ? "Data collection enabled" : "Data collection disabled")
    }
    
    @objc private func analyticsToggled(_ sender: UISwitch) {
        showAlert(title: "Analytics", message: sender.isOn ? "Analytics enabled" : "Analytics disabled")
    }
    
    @objc private func crashReportingToggled(_ sender: UISwitch) {
        showAlert(title: "Crash Reporting", message: sender.isOn ? "Crash reporting enabled" : "Crash reporting disabled")
    }
    
    @objc private func locationToggled(_ sender: UISwitch) {
        showAlert(title: "Location Services", message: sender.isOn ? "Location services enabled" : "Location services disabled")
    }
    
    @objc private func pushToggled(_ sender: UISwitch) {
        showAlert(title: "Push Notifications", message: sender.isOn ? "Push notifications enabled" : "Push notifications disabled")
    }
    
    @objc private func emailToggled(_ sender: UISwitch) {
        showAlert(title: "Email Notifications", message: sender.isOn ? "Email notifications enabled" : "Email notifications disabled")
    }
    
    @objc private func smsToggled(_ sender: UISwitch) {
        showAlert(title: "SMS Notifications", message: sender.isOn ? "SMS notifications enabled" : "SMS notifications disabled")
    }
    
    @objc private func soundToggled(_ sender: UISwitch) {
        showAlert(title: "Notification Sounds", message: sender.isOn ? "Notification sounds enabled" : "Notification sounds disabled")
    }
    
    @objc private func profileTapped() {
        showAlert(title: "Profile", message: "Edit your profile information")
    }
    
    @objc private func passwordTapped() {
        showAlert(title: "Password", message: "Change your password")
    }
    
    @objc private func twoFactorToggled(_ sender: UISwitch) {
        showAlert(title: "Two-Factor Authentication", message: sender.isOn ? "Two-factor authentication enabled" : "Two-factor authentication disabled")
    }
    
    @objc private func deleteAccountTapped() {
        showAlert(title: "Delete Account", message: "This action cannot be undone")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
