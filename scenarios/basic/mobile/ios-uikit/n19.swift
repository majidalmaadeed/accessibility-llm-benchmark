import UIKit

class UngroupedRadioButtonsViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var selectedPreferences: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Contact Preferences"
        
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
        
        // Contact preferences form
        let preferencesView = createPreferencesView()
        contentView.addSubview(preferencesView)
        
        // Additional information
        let additionalInfoView = createAdditionalInfoView()
        contentView.addSubview(additionalInfoView)
        
        // Submit button
        let submitView = createSubmitView()
        contentView.addSubview(submitView)
        
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
            
            preferencesView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            preferencesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            preferencesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            additionalInfoView.topAnchor.constraint(equalTo: preferencesView.bottomAnchor, constant: 20),
            additionalInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            additionalInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            submitView.topAnchor.constraint(equalTo: additionalInfoView.bottomAnchor, constant: 20),
            submitView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            submitView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            submitView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Communication Preferences"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Please select how you would like to be contacted"
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
    
    private func createPreferencesView() -> UIView {
        let preferencesView = UIView()
        preferencesView.backgroundColor = .systemBackground
        preferencesView.layer.cornerRadius = 12
        preferencesView.layer.shadowColor = UIColor.black.cgColor
        preferencesView.layer.shadowOffset = CGSize(width: 0, height: 2)
        preferencesView.layer.shadowRadius = 4
        preferencesView.layer.shadowOpacity = 0.1
        preferencesView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Contact Methods"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Choose your preferred methods of communication. You can select multiple options."
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesView.addSubview(descriptionLabel)
        
        // Ungrouped radio buttons - each is independent
        let emailButton = createRadioButton(title: "Email", isSelected: selectedPreferences.contains("email"))
        emailButton.tag = 1
        emailButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        preferencesView.addSubview(emailButton)
        
        let phoneButton = createRadioButton(title: "Phone Call", isSelected: selectedPreferences.contains("phone"))
        phoneButton.tag = 2
        phoneButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        preferencesView.addSubview(phoneButton)
        
        let smsButton = createRadioButton(title: "SMS Text Message", isSelected: selectedPreferences.contains("sms"))
        smsButton.tag = 3
        smsButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        preferencesView.addSubview(smsButton)
        
        let mailButton = createRadioButton(title: "Physical Mail", isSelected: selectedPreferences.contains("mail"))
        mailButton.tag = 4
        mailButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        preferencesView.addSubview(mailButton)
        
        let pushButton = createRadioButton(title: "Push Notifications", isSelected: selectedPreferences.contains("push"))
        pushButton.tag = 5
        pushButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        preferencesView.addSubview(pushButton)
        
        let inAppButton = createRadioButton(title: "In-App Messages", isSelected: selectedPreferences.contains("inapp"))
        inAppButton.tag = 6
        inAppButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        preferencesView.addSubview(inAppButton)
        
        NSLayoutConstraint.activate([
            preferencesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            
            titleLabel.topAnchor.constraint(equalTo: preferencesView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: preferencesView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: preferencesView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: preferencesView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: preferencesView.trailingAnchor, constant: -20),
            
            emailButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            emailButton.leadingAnchor.constraint(equalTo: preferencesView.leadingAnchor, constant: 20),
            emailButton.trailingAnchor.constraint(equalTo: preferencesView.trailingAnchor, constant: -20),
            emailButton.heightAnchor.constraint(equalToConstant: 44),
            
            phoneButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 12),
            phoneButton.leadingAnchor.constraint(equalTo: preferencesView.leadingAnchor, constant: 20),
            phoneButton.trailingAnchor.constraint(equalTo: preferencesView.trailingAnchor, constant: -20),
            phoneButton.heightAnchor.constraint(equalToConstant: 44),
            
            smsButton.topAnchor.constraint(equalTo: phoneButton.bottomAnchor, constant: 12),
            smsButton.leadingAnchor.constraint(equalTo: preferencesView.leadingAnchor, constant: 20),
            smsButton.trailingAnchor.constraint(equalTo: preferencesView.trailingAnchor, constant: -20),
            smsButton.heightAnchor.constraint(equalToConstant: 44),
            
            mailButton.topAnchor.constraint(equalTo: smsButton.bottomAnchor, constant: 12),
            mailButton.leadingAnchor.constraint(equalTo: preferencesView.leadingAnchor, constant: 20),
            mailButton.trailingAnchor.constraint(equalTo: preferencesView.trailingAnchor, constant: -20),
            mailButton.heightAnchor.constraint(equalToConstant: 44),
            
            pushButton.topAnchor.constraint(equalTo: mailButton.bottomAnchor, constant: 12),
            pushButton.leadingAnchor.constraint(equalTo: preferencesView.leadingAnchor, constant: 20),
            pushButton.trailingAnchor.constraint(equalTo: preferencesView.trailingAnchor, constant: -20),
            pushButton.heightAnchor.constraint(equalToConstant: 44),
            
            inAppButton.topAnchor.constraint(equalTo: pushButton.bottomAnchor, constant: 12),
            inAppButton.leadingAnchor.constraint(equalTo: preferencesView.leadingAnchor, constant: 20),
            inAppButton.trailingAnchor.constraint(equalTo: preferencesView.trailingAnchor, constant: -20),
            inAppButton.heightAnchor.constraint(equalToConstant: 44),
            inAppButton.bottomAnchor.constraint(lessThanOrEqualTo: preferencesView.bottomAnchor, constant: -20)
        ])
        
        return preferencesView
    }
    
    private func createRadioButton(title: String, isSelected: Bool) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.systemGray4.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(stackView)
        
        let radioImageView = UIImageView()
        radioImageView.image = UIImage(systemName: isSelected ? "circle.fill" : "circle")
        radioImageView.tintColor = isSelected ? .systemBlue : .systemGray
        radioImageView.contentMode = .scaleAspectFit
        radioImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(radioImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = isSelected ? .systemBlue : .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(spacerView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            radioImageView.widthAnchor.constraint(equalToConstant: 20),
            radioImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return button
    }
    
    private func createAdditionalInfoView() -> UIView {
        let infoView = UIView()
        infoView.backgroundColor = .systemBackground
        infoView.layer.cornerRadius = 12
        infoView.layer.shadowColor = UIColor.black.cgColor
        infoView.layer.shadowOffset = CGSize(width: 0, height: 2)
        infoView.layer.shadowRadius = 4
        infoView.layer.shadowOpacity = 0.1
        infoView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Additional Information"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(titleLabel)
        
        let frequencyLabel = UILabel()
        frequencyLabel.text = "How often would you like to receive updates?"
        frequencyLabel.font = UIFont.systemFont(ofSize: 16)
        frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(frequencyLabel)
        
        // Frequency selection - also ungrouped radio buttons
        let dailyButton = createRadioButton(title: "Daily", isSelected: false)
        dailyButton.tag = 10
        dailyButton.addTarget(self, action: #selector(frequencyButtonTapped(_:)), for: .touchUpInside)
        infoView.addSubview(dailyButton)
        
        let weeklyButton = createRadioButton(title: "Weekly", isSelected: false)
        weeklyButton.tag = 11
        weeklyButton.addTarget(self, action: #selector(frequencyButtonTapped(_:)), for: .touchUpInside)
        infoView.addSubview(weeklyButton)
        
        let monthlyButton = createRadioButton(title: "Monthly", isSelected: false)
        monthlyButton.tag = 12
        monthlyButton.addTarget(self, action: #selector(frequencyButtonTapped(_:)), for: .touchUpInside)
        infoView.addSubview(monthlyButton)
        
        let neverButton = createRadioButton(title: "Never", isSelected: false)
        neverButton.tag = 13
        neverButton.addTarget(self, action: #selector(frequencyButtonTapped(_:)), for: .touchUpInside)
        infoView.addSubview(neverButton)
        
        let timeLabel = UILabel()
        timeLabel.text = "Preferred time for contact:"
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(timeLabel)
        
        let timeTextField = UITextField()
        timeTextField.placeholder = "e.g., 9:00 AM - 5:00 PM"
        timeTextField.font = UIFont.systemFont(ofSize: 16)
        timeTextField.borderStyle = .roundedRect
        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(timeTextField)
        
        NSLayoutConstraint.activate([
            infoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 350),
            
            titleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            
            frequencyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            frequencyLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            frequencyLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            
            dailyButton.topAnchor.constraint(equalTo: frequencyLabel.bottomAnchor, constant: 12),
            dailyButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            dailyButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            dailyButton.heightAnchor.constraint(equalToConstant: 44),
            
            weeklyButton.topAnchor.constraint(equalTo: dailyButton.bottomAnchor, constant: 8),
            weeklyButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            weeklyButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            weeklyButton.heightAnchor.constraint(equalToConstant: 44),
            
            monthlyButton.topAnchor.constraint(equalTo: weeklyButton.bottomAnchor, constant: 8),
            monthlyButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            monthlyButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            monthlyButton.heightAnchor.constraint(equalToConstant: 44),
            
            neverButton.topAnchor.constraint(equalTo: monthlyButton.bottomAnchor, constant: 8),
            neverButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            neverButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            neverButton.heightAnchor.constraint(equalToConstant: 44),
            
            timeLabel.topAnchor.constraint(equalTo: neverButton.bottomAnchor, constant: 20),
            timeLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            
            timeTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            timeTextField.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            timeTextField.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            timeTextField.heightAnchor.constraint(equalToConstant: 44),
            timeTextField.bottomAnchor.constraint(lessThanOrEqualTo: infoView.bottomAnchor, constant: -20)
        ])
        
        return infoView
    }
    
    private func createSubmitView() -> UIView {
        let submitView = UIView()
        submitView.backgroundColor = .systemBackground
        submitView.translatesAutoresizingMaskIntoConstraints = false
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Save Preferences", for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 25
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitView.addSubview(submitButton)
        
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset to Defaults", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        resetButton.setTitleColor(.systemBlue, for: .normal)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        submitView.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            submitView.heightAnchor.constraint(equalToConstant: 120),
            
            submitButton.centerXAnchor.constraint(equalTo: submitView.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: submitView.topAnchor, constant: 20),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            resetButton.centerXAnchor.constraint(equalTo: submitView.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 16),
            resetButton.widthAnchor.constraint(equalToConstant: 150),
            resetButton.heightAnchor.constraint(equalToConstant: 40),
            resetButton.bottomAnchor.constraint(lessThanOrEqualTo: submitView.bottomAnchor, constant: -20)
        ])
        
        return submitView
    }
    
    // MARK: - Actions
    @objc private func radioButtonTapped(_ sender: UIButton) {
        let preferences = ["email", "phone", "sms", "mail", "push", "inapp"]
        let selectedPreference = preferences[sender.tag - 1]
        
        if selectedPreferences.contains(selectedPreference) {
            selectedPreferences.remove(selectedPreference)
        } else {
            selectedPreferences.insert(selectedPreference)
        }
        
        updateRadioButton(sender, isSelected: selectedPreferences.contains(selectedPreference))
    }
    
    @objc private func frequencyButtonTapped(_ sender: UIButton) {
        // Reset all frequency buttons
        for i in 10...13 {
            if let button = view.viewWithTag(i) as? UIButton {
                updateRadioButton(button, isSelected: false)
            }
        }
        
        // Select the tapped button
        updateRadioButton(sender, isSelected: true)
    }
    
    private func updateRadioButton(_ button: UIButton, isSelected: Bool) {
        button.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.systemGray4.cgColor
        
        if let stackView = button.subviews.first as? UIStackView,
           let radioImageView = stackView.arrangedSubviews.first as? UIImageView,
           let titleLabel = stackView.arrangedSubviews[1] as? UILabel {
            radioImageView.image = UIImage(systemName: isSelected ? "circle.fill" : "circle")
            radioImageView.tintColor = isSelected ? .systemBlue : .systemGray
            titleLabel.textColor = isSelected ? .systemBlue : .label
        }
    }
    
    @objc private func submitTapped() {
        let alert = UIAlertController(
            title: "Preferences Saved",
            message: "Your communication preferences have been saved successfully.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func resetTapped() {
        // Reset all preferences
        selectedPreferences.removeAll()
        
        // Reset all radio buttons
        for i in 1...6 {
            if let button = view.viewWithTag(i) as? UIButton {
                updateRadioButton(button, isSelected: false)
            }
        }
        
        for i in 10...13 {
            if let button = view.viewWithTag(i) as? UIButton {
                updateRadioButton(button, isSelected: false)
            }
        }
        
        let alert = UIAlertController(
            title: "Reset Complete",
            message: "All preferences have been reset to default values.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
