import UIKit

class InsufficientButtonSpacingViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Action Center"
        
        // Scroll view setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Header
        let headerView = createHeaderView()
        contentView.addSubview(headerView)
        
        // Quick actions section
        let quickActionsView = createQuickActionsView()
        contentView.addSubview(quickActionsView)
        
        // Document actions section
        let documentActionsView = createDocumentActionsView()
        contentView.addSubview(documentActionsView)
        
        // Settings actions section
        let settingsActionsView = createSettingsActionsView()
        contentView.addSubview(settingsActionsView)
        
        // Emergency actions section
        let emergencyActionsView = createEmergencyActionsView()
        contentView.addSubview(emergencyActionsView)
        
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
            
            quickActionsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            quickActionsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            quickActionsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            documentActionsView.topAnchor.constraint(equalTo: quickActionsView.bottomAnchor, constant: 20),
            documentActionsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            documentActionsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            settingsActionsView.topAnchor.constraint(equalTo: documentActionsView.bottomAnchor, constant: 20),
            settingsActionsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            settingsActionsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            emergencyActionsView.topAnchor.constraint(equalTo: settingsActionsView.bottomAnchor, constant: 20),
            emergencyActionsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emergencyActionsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emergencyActionsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Action Center"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Quick access to common actions and functions"
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
    
    private func createQuickActionsView() -> UIView {
        let actionsView = UIView()
        actionsView.backgroundColor = .systemBackground
        actionsView.layer.cornerRadius = 12
        actionsView.layer.shadowColor = UIColor.black.cgColor
        actionsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        actionsView.layer.shadowRadius = 4
        actionsView.layer.shadowOpacity = 0.1
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Quick Actions"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionsView.addSubview(titleLabel)
        
        // Buttons with insufficient spacing (2px instead of minimum 44px)
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2 // Insufficient spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.addSubview(stackView)
        
        let newButton = createActionButton(title: "New", icon: "plus", action: #selector(newTapped))
        let openButton = createActionButton(title: "Open", icon: "folder", action: #selector(openTapped))
        let saveButton = createActionButton(title: "Save", icon: "square.and.arrow.down", action: #selector(saveTapped))
        let printButton = createActionButton(title: "Print", icon: "printer", action: #selector(printTapped))
        
        stackView.addArrangedSubview(newButton)
        stackView.addArrangedSubview(openButton)
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(printButton)
        
        NSLayoutConstraint.activate([
            actionsView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: actionsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: actionsView.bottomAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return actionsView
    }
    
    private func createDocumentActionsView() -> UIView {
        let actionsView = UIView()
        actionsView.backgroundColor = .systemBackground
        actionsView.layer.cornerRadius = 12
        actionsView.layer.shadowColor = UIColor.black.cgColor
        actionsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        actionsView.layer.shadowRadius = 4
        actionsView.layer.shadowOpacity = 0.1
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Document Actions"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionsView.addSubview(titleLabel)
        
        // Vertical stack with insufficient spacing
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2 // Insufficient spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.addSubview(stackView)
        
        let editButton = createActionButton(title: "Edit Document", icon: "pencil", action: #selector(editTapped))
        let shareButton = createActionButton(title: "Share Document", icon: "square.and.arrow.up", action: #selector(shareTapped))
        let duplicateButton = createActionButton(title: "Duplicate", icon: "doc.on.doc", action: #selector(duplicateTapped))
        let deleteButton = createActionButton(title: "Delete", icon: "trash", action: #selector(deleteTapped))
        
        stackView.addArrangedSubview(editButton)
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(duplicateButton)
        stackView.addArrangedSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            actionsView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: actionsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: actionsView.bottomAnchor, constant: -20)
        ])
        
        return actionsView
    }
    
    private func createSettingsActionsView() -> UIView {
        let actionsView = UIView()
        actionsView.backgroundColor = .systemBackground
        actionsView.layer.cornerRadius = 12
        actionsView.layer.shadowColor = UIColor.black.cgColor
        actionsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        actionsView.layer.shadowRadius = 4
        actionsView.layer.shadowOpacity = 0.1
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Settings & Preferences"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionsView.addSubview(titleLabel)
        
        // Grid layout with insufficient spacing
        let gridStackView = UIStackView()
        gridStackView.axis = .vertical
        gridStackView.spacing = 2 // Insufficient spacing
        gridStackView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.addSubview(gridStackView)
        
        let row1StackView = UIStackView()
        row1StackView.axis = .horizontal
        row1StackView.distribution = .fillEqually
        row1StackView.spacing = 2 // Insufficient spacing
        row1StackView.translatesAutoresizingMaskIntoConstraints = false
        
        let row2StackView = UIStackView()
        row2StackView.axis = .horizontal
        row2StackView.distribution = .fillEqually
        row2StackView.spacing = 2 // Insufficient spacing
        row2StackView.translatesAutoresizingMaskIntoConstraints = false
        
        let preferencesButton = createActionButton(title: "Preferences", icon: "gear", action: #selector(preferencesTapped))
        let accountButton = createActionButton(title: "Account", icon: "person", action: #selector(accountTapped))
        let securityButton = createActionButton(title: "Security", icon: "lock", action: #selector(securityTapped))
        let privacyButton = createActionButton(title: "Privacy", icon: "hand.raised", action: #selector(privacyTapped))
        
        row1StackView.addArrangedSubview(preferencesButton)
        row1StackView.addArrangedSubview(accountButton)
        row2StackView.addArrangedSubview(securityButton)
        row2StackView.addArrangedSubview(privacyButton)
        
        gridStackView.addArrangedSubview(row1StackView)
        gridStackView.addArrangedSubview(row2StackView)
        
        NSLayoutConstraint.activate([
            actionsView.heightAnchor.constraint(equalToConstant: 160),
            
            titleLabel.topAnchor.constraint(equalTo: actionsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor, constant: -20),
            
            gridStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            gridStackView.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor, constant: 20),
            gridStackView.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor, constant: -20),
            gridStackView.bottomAnchor.constraint(equalTo: actionsView.bottomAnchor, constant: -20),
            
            row1StackView.heightAnchor.constraint(equalToConstant: 50),
            row2StackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return actionsView
    }
    
    private func createEmergencyActionsView() -> UIView {
        let actionsView = UIView()
        actionsView.backgroundColor = .systemRed.withAlphaComponent(0.1)
        actionsView.layer.cornerRadius = 12
        actionsView.layer.borderWidth = 2
        actionsView.layer.borderColor = UIColor.systemRed.cgColor
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Emergency Actions"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .systemRed
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionsView.addSubview(titleLabel)
        
        // Emergency buttons with insufficient spacing
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2 // Insufficient spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.addSubview(stackView)
        
        let emergencyButton = createEmergencyButton(title: "Emergency", icon: "exclamationmark.triangle", action: #selector(emergencyTapped))
        let lockButton = createEmergencyButton(title: "Lock", icon: "lock.fill", action: #selector(lockTapped))
        let logoutButton = createEmergencyButton(title: "Logout", icon: "power", action: #selector(logoutTapped))
        let reportButton = createEmergencyButton(title: "Report", icon: "flag", action: #selector(reportTapped))
        
        stackView.addArrangedSubview(emergencyButton)
        stackView.addArrangedSubview(lockButton)
        stackView.addArrangedSubview(logoutButton)
        stackView.addArrangedSubview(reportButton)
        
        NSLayoutConstraint.activate([
            actionsView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: actionsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: actionsView.bottomAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return actionsView
    }
    
    private func createActionButton(title: String, icon: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(stackView)
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: button.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: button.trailingAnchor, constant: -8),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return button
    }
    
    private func createEmergencyButton(title: String, icon: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(stackView)
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: button.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: button.trailingAnchor, constant: -8),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return button
    }
    
    // MARK: - Actions
    @objc private func newTapped() {
        showAlert(title: "New", message: "Creating new item...")
    }
    
    @objc private func openTapped() {
        showAlert(title: "Open", message: "Opening file...")
    }
    
    @objc private func saveTapped() {
        showAlert(title: "Save", message: "Saving document...")
    }
    
    @objc private func printTapped() {
        showAlert(title: "Print", message: "Opening print dialog...")
    }
    
    @objc private func editTapped() {
        showAlert(title: "Edit", message: "Opening editor...")
    }
    
    @objc private func shareTapped() {
        showAlert(title: "Share", message: "Opening share dialog...")
    }
    
    @objc private func duplicateTapped() {
        showAlert(title: "Duplicate", message: "Duplicating item...")
    }
    
    @objc private func deleteTapped() {
        showAlert(title: "Delete", message: "Deleting item...")
    }
    
    @objc private func preferencesTapped() {
        showAlert(title: "Preferences", message: "Opening preferences...")
    }
    
    @objc private func accountTapped() {
        showAlert(title: "Account", message: "Opening account settings...")
    }
    
    @objc private func securityTapped() {
        showAlert(title: "Security", message: "Opening security settings...")
    }
    
    @objc private func privacyTapped() {
        showAlert(title: "Privacy", message: "Opening privacy settings...")
    }
    
    @objc private func emergencyTapped() {
        showAlert(title: "Emergency", message: "Emergency action triggered!")
    }
    
    @objc private func lockTapped() {
        showAlert(title: "Lock", message: "Locking device...")
    }
    
    @objc private func logoutTapped() {
        showAlert(title: "Logout", message: "Logging out...")
    }
    
    @objc private func reportTapped() {
        showAlert(title: "Report", message: "Opening report dialog...")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
