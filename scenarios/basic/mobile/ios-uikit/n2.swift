import UIKit

class ColorOnlyErrorIndicationViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var formFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "User Registration"
        
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
        
        // Registration form
        let formView = createFormView()
        contentView.addSubview(formView)
        
        // Submit section
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
            
            formView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            formView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            submitView.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 20),
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
        titleLabel.text = "Create Account"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Please fill in all required fields"
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
    
    private func createFormView() -> UIView {
        let formView = UIView()
        formView.backgroundColor = .systemBackground
        formView.layer.cornerRadius = 12
        formView.layer.shadowColor = UIColor.black.cgColor
        formView.layer.shadowOffset = CGSize(width: 0, height: 2)
        formView.layer.shadowRadius = 4
        formView.layer.shadowOpacity = 0.1
        formView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Personal Information"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(stackView)
        
        // First Name field
        let firstNameField = createTextField(placeholder: "First Name *", isRequired: true)
        formFields.append(firstNameField)
        stackView.addArrangedSubview(createFieldContainer(label: "First Name", field: firstNameField, isRequired: true))
        
        // Last Name field
        let lastNameField = createTextField(placeholder: "Last Name *", isRequired: true)
        formFields.append(lastNameField)
        stackView.addArrangedSubview(createFieldContainer(label: "Last Name", field: lastNameField, isRequired: true))
        
        // Email field
        let emailField = createTextField(placeholder: "Email Address *", isRequired: true)
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        formFields.append(emailField)
        stackView.addArrangedSubview(createFieldContainer(label: "Email Address", field: emailField, isRequired: true))
        
        // Phone field
        let phoneField = createTextField(placeholder: "Phone Number", isRequired: false)
        phoneField.keyboardType = .phonePad
        formFields.append(phoneField)
        stackView.addArrangedSubview(createFieldContainer(label: "Phone Number", field: phoneField, isRequired: false))
        
        // Password field
        let passwordField = createTextField(placeholder: "Password *", isRequired: true)
        passwordField.isSecureTextEntry = true
        formFields.append(passwordField)
        stackView.addArrangedSubview(createFieldContainer(label: "Password", field: passwordField, isRequired: true))
        
        // Confirm Password field
        let confirmPasswordField = createTextField(placeholder: "Confirm Password *", isRequired: true)
        confirmPasswordField.isSecureTextEntry = true
        formFields.append(confirmPasswordField)
        stackView.addArrangedSubview(createFieldContainer(label: "Confirm Password", field: confirmPasswordField, isRequired: true))
        
        // Date of Birth field
        let dobField = createTextField(placeholder: "Date of Birth (MM/DD/YYYY)", isRequired: false)
        formFields.append(dobField)
        stackView.addArrangedSubview(createFieldContainer(label: "Date of Birth", field: dobField, isRequired: false))
        
        NSLayoutConstraint.activate([
            formView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500),
            
            titleLabel.topAnchor.constraint(equalTo: formView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: formView.bottomAnchor, constant: -20)
        ])
        
        return formView
    }
    
    private func createTextField(placeholder: String, isRequired: Bool) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }
    
    private func createFieldContainer(label: String, field: UITextField, isRequired: Bool) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelView = UILabel()
        labelView.text = label + (isRequired ? " *" : "")
        labelView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelView)
        
        containerView.addSubview(field)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 70),
            
            labelView.topAnchor.constraint(equalTo: containerView.topAnchor),
            labelView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            field.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 8),
            field.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            field.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            field.heightAnchor.constraint(equalToConstant: 44),
            field.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func createSubmitView() -> UIView {
        let submitView = UIView()
        submitView.backgroundColor = .systemBackground
        submitView.translatesAutoresizingMaskIntoConstraints = false
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Create Account", for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 25
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitView.addSubview(submitButton)
        
        let termsLabel = UILabel()
        termsLabel.text = "By creating an account, you agree to our Terms of Service and Privacy Policy"
        termsLabel.font = UIFont.systemFont(ofSize: 14)
        termsLabel.textColor = .secondaryLabel
        termsLabel.textAlignment = .center
        termsLabel.numberOfLines = 0
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        submitView.addSubview(termsLabel)
        
        NSLayoutConstraint.activate([
            submitView.heightAnchor.constraint(equalToConstant: 120),
            
            submitButton.centerXAnchor.constraint(equalTo: submitView.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: submitView.topAnchor, constant: 20),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            termsLabel.centerXAnchor.constraint(equalTo: submitView.centerXAnchor),
            termsLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 16),
            termsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: submitView.leadingAnchor, constant: 20),
            termsLabel.trailingAnchor.constraint(lessThanOrEqualTo: submitView.trailingAnchor, constant: -20),
            termsLabel.bottomAnchor.constraint(lessThanOrEqualTo: submitView.bottomAnchor, constant: -20)
        ])
        
        return submitView
    }
    
    // MARK: - Validation Methods
    private func validateForm() -> Bool {
        var isValid = true
        
        // Reset all field borders
        for field in formFields {
            field.layer.borderWidth = 0
        }
        
        // Validate required fields
        let requiredFields = [0, 1, 2, 4, 5] // First Name, Last Name, Email, Password, Confirm Password
        
        for index in requiredFields {
            let field = formFields[index]
            if field.text?.isEmpty ?? true {
                // Color-only error indication - no text or icon
                field.layer.borderWidth = 2
                field.layer.borderColor = UIColor.systemRed.cgColor
                isValid = false
            }
        }
        
        // Validate email format
        if let email = formFields[2].text, !email.isEmpty {
            if !isValidEmail(email) {
                formFields[2].layer.borderWidth = 2
                formFields[2].layer.borderColor = UIColor.systemRed.cgColor
                isValid = false
            }
        }
        
        // Validate password match
        if let password = formFields[4].text, let confirmPassword = formFields[5].text {
            if !password.isEmpty && !confirmPassword.isEmpty && password != confirmPassword {
                formFields[4].layer.borderWidth = 2
                formFields[4].layer.borderColor = UIColor.systemRed.cgColor
                formFields[5].layer.borderWidth = 2
                formFields[5].layer.borderColor = UIColor.systemRed.cgColor
                isValid = false
            }
        }
        
        // Validate password strength
        if let password = formFields[4].text, !password.isEmpty {
            if password.count < 8 {
                formFields[4].layer.borderWidth = 2
                formFields[4].layer.borderColor = UIColor.systemRed.cgColor
                isValid = false
            }
        }
        
        return isValid
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: - Actions
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // Remove error indication when user starts typing
        textField.layer.borderWidth = 0
    }
    
    @objc private func submitTapped() {
        if validateForm() {
            let alert = UIAlertController(
                title: "Success",
                message: "Account created successfully!",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(
                title: "Validation Error",
                message: "Please check the highlighted fields and try again.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
