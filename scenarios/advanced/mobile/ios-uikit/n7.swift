import UIKit

class MultiStepWizardViewController: UIViewController {
    
    // MARK: - Properties
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var progressView: UIProgressView!
    private var stepIndicatorView: UIView!
    private var formContainerView: UIView!
    private var navigationView: UIView!
    
    private var currentStep: Int = 1
    private var formData = FormData()
    private var errors: [String: String] = [:]
    private var isSubmitting: Bool = false
    
    let steps = [
        WizardStep(id: 1, title: "Personal Information", description: "Tell us about yourself", icon: "person"),
        WizardStep(id: 2, title: "Address Details", description: "Where should we send your items?", icon: "house"),
        WizardStep(id: 3, title: "Preferences", description: "Customize your experience", icon: "gear"),
        WizardStep(id: 4, title: "Payment", description: "Secure payment information", icon: "creditcard"),
        WizardStep(id: 5, title: "Review & Confirm", description: "Review your information", icon: "checkmark")
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateStepDisplay()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Multi-Step Registration"
        
        setupScrollView()
        setupProgressView()
        setupStepIndicator()
        setupFormContainer()
        setupNavigation()
        setupConstraints()
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    private func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .systemBlue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(progressView)
    }
    
    private func setupStepIndicator() {
        stepIndicatorView = UIView()
        stepIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stepIndicatorView)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, step) in steps.enumerated() {
            let stepView = createStepView(step: step, index: index)
            stackView.addArrangedSubview(stepView)
        }
        
        stepIndicatorView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: stepIndicatorView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: stepIndicatorView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: stepIndicatorView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: stepIndicatorView.bottomAnchor)
        ])
    }
    
    private func createStepView(step: WizardStep, index: Int) -> UIView {
        let containerView = UIView()
        
        let circleView = UIView()
        circleView.backgroundColor = index < currentStep ? .systemGreen : (index == currentStep - 1 ? .systemBlue : .systemGray4)
        circleView.layer.cornerRadius = 20
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconLabel = UILabel()
        iconLabel.text = step.icon
        iconLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        iconLabel.textColor = .white
        iconLabel.textAlignment = .center
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = step.title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = step.description
        descLabel.font = UIFont.systemFont(ofSize: 10)
        descLabel.textColor = .secondaryLabel
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 2
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(circleView)
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: containerView.topAnchor),
            circleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 40),
            circleView.heightAnchor.constraint(equalToConstant: 40),
            
            iconLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func setupFormContainer() {
        formContainerView = UIView()
        formContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(formContainerView)
    }
    
    private func setupNavigation() {
        navigationView = UIView()
        navigationView.backgroundColor = .systemGray6
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationView)
        
        let previousButton = UIButton(type: .system)
        previousButton.setTitle("← Previous", for: .normal)
        previousButton.addTarget(self, action: #selector(previousStep), for: .touchUpInside)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next →", for: .normal)
        nextButton.backgroundColor = .systemBlue
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView.addSubview(previousButton)
        navigationView.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 16),
            previousButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            previousButton.widthAnchor.constraint(equalToConstant: 100),
            previousButton.heightAnchor.constraint(equalToConstant: 44),
            
            nextButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -16),
            nextButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: navigationView.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            progressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stepIndicatorView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 16),
            stepIndicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stepIndicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stepIndicatorView.heightAnchor.constraint(equalToConstant: 100),
            
            formContainerView.topAnchor.constraint(equalTo: stepIndicatorView.bottomAnchor, constant: 16),
            formContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            formContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            formContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    // MARK: - Step Management
    
    private func updateStepDisplay() {
        progressView.progress = Float(currentStep) / Float(steps.count)
        updateStepIndicator()
        updateFormContent()
        updateNavigationButtons()
    }
    
    private func updateStepIndicator() {
        stepIndicatorView.subviews.forEach { $0.removeFromSuperview() }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, step) in steps.enumerated() {
            let stepView = createStepView(step: step, index: index)
            stackView.addArrangedSubview(stepView)
        }
        
        stepIndicatorView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: stepIndicatorView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: stepIndicatorView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: stepIndicatorView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: stepIndicatorView.bottomAnchor)
        ])
    }
    
    private func updateFormContent() {
        formContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        let formView = createFormView(for: currentStep)
        formView.translatesAutoresizingMaskIntoConstraints = false
        formContainerView.addSubview(formView)
        
        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: formContainerView.topAnchor),
            formView.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor),
            formView.bottomAnchor.constraint(equalTo: formContainerView.bottomAnchor)
        ])
    }
    
    private func createFormView(for step: Int) -> UIView {
        let containerView = UIView()
        
        switch step {
        case 1:
            return createPersonalInfoForm()
        case 2:
            return createAddressInfoForm()
        case 3:
            return createPreferencesForm()
        case 4:
            return createPaymentInfoForm()
        case 5:
            return createReviewForm()
        default:
            return containerView
        }
    }
    
    private func createPersonalInfoForm() -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = "Personal Information"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = "Please provide your basic personal details"
        descLabel.font = UIFont.systemFont(ofSize: 16)
        descLabel.textColor = .secondaryLabel
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let firstNameField = createTextField(placeholder: "First Name *", text: formData.personalInfo.firstName)
        let lastNameField = createTextField(placeholder: "Last Name *", text: formData.personalInfo.lastName)
        let emailField = createTextField(placeholder: "Email Address *", text: formData.personalInfo.email)
        let phoneField = createTextField(placeholder: "Phone Number *", text: formData.personalInfo.phone)
        
        [titleLabel, descLabel, firstNameField, lastNameField, emailField, phoneField].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            firstNameField.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 24),
            firstNameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            firstNameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            firstNameField.heightAnchor.constraint(equalToConstant: 44),
            
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 16),
            lastNameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            lastNameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            lastNameField.heightAnchor.constraint(equalToConstant: 44),
            
            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 16),
            emailField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 44),
            
            phoneField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            phoneField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            phoneField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            phoneField.heightAnchor.constraint(equalToConstant: 44),
            phoneField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func createAddressInfoForm() -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = "Address Information"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = "Where should we send your items?"
        descLabel.font = UIFont.systemFont(ofSize: 16)
        descLabel.textColor = .secondaryLabel
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let streetField = createTextField(placeholder: "Street Address *", text: formData.addressInfo.street)
        let cityField = createTextField(placeholder: "City *", text: formData.addressInfo.city)
        let stateField = createTextField(placeholder: "State *", text: formData.addressInfo.state)
        let zipField = createTextField(placeholder: "ZIP Code *", text: formData.addressInfo.zipCode)
        
        [titleLabel, descLabel, streetField, cityField, stateField, zipField].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            streetField.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 24),
            streetField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            streetField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            streetField.heightAnchor.constraint(equalToConstant: 44),
            
            cityField.topAnchor.constraint(equalTo: streetField.bottomAnchor, constant: 16),
            cityField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cityField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cityField.heightAnchor.constraint(equalToConstant: 44),
            
            stateField.topAnchor.constraint(equalTo: cityField.bottomAnchor, constant: 16),
            stateField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stateField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stateField.heightAnchor.constraint(equalToConstant: 44),
            
            zipField.topAnchor.constraint(equalTo: stateField.bottomAnchor, constant: 16),
            zipField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            zipField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            zipField.heightAnchor.constraint(equalToConstant: 44),
            zipField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func createPreferencesForm() -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = "Preferences"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = "Customize your experience"
        descLabel.font = UIFont.systemFont(ofSize: 16)
        descLabel.textColor = .secondaryLabel
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let newsletterSwitch = UISwitch()
        newsletterSwitch.isOn = formData.preferences.newsletter
        newsletterSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        let newsletterLabel = UILabel()
        newsletterLabel.text = "Subscribe to our newsletter"
        newsletterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, descLabel, newsletterSwitch, newsletterLabel].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            newsletterSwitch.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 24),
            newsletterSwitch.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            newsletterLabel.centerYAnchor.constraint(equalTo: newsletterSwitch.centerYAnchor),
            newsletterLabel.leadingAnchor.constraint(equalTo: newsletterSwitch.trailingAnchor, constant: 16),
            newsletterLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            newsletterLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func createPaymentInfoForm() -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = "Payment Information"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = "Secure payment details"
        descLabel.font = UIFont.systemFont(ofSize: 16)
        descLabel.textColor = .secondaryLabel
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let cardField = createTextField(placeholder: "Card Number *", text: formData.paymentInfo.cardNumber)
        let expiryField = createTextField(placeholder: "Expiry Date (MM/YY) *", text: formData.paymentInfo.expiryDate)
        let cvvField = createTextField(placeholder: "CVV *", text: formData.paymentInfo.cvv)
        let nameField = createTextField(placeholder: "Cardholder Name *", text: formData.paymentInfo.cardholderName)
        
        [titleLabel, descLabel, cardField, expiryField, cvvField, nameField].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            cardField.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 24),
            cardField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cardField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cardField.heightAnchor.constraint(equalToConstant: 44),
            
            expiryField.topAnchor.constraint(equalTo: cardField.bottomAnchor, constant: 16),
            expiryField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            expiryField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            expiryField.heightAnchor.constraint(equalToConstant: 44),
            
            cvvField.topAnchor.constraint(equalTo: expiryField.bottomAnchor, constant: 16),
            cvvField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cvvField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cvvField.heightAnchor.constraint(equalToConstant: 44),
            
            nameField.topAnchor.constraint(equalTo: cvvField.bottomAnchor, constant: 16),
            nameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 44),
            nameField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func createReviewForm() -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = "Review & Confirm"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = "Please review your information before submitting"
        descLabel.font = UIFont.systemFont(ofSize: 16)
        descLabel.textColor = .secondaryLabel
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let reviewLabel = UILabel()
        reviewLabel.text = "Personal Info: \(formData.personalInfo.firstName) \(formData.personalInfo.lastName)\nEmail: \(formData.personalInfo.email)\nAddress: \(formData.addressInfo.street), \(formData.addressInfo.city)"
        reviewLabel.numberOfLines = 0
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, descLabel, reviewLabel].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            reviewLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 24),
            reviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            reviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            reviewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func createTextField(placeholder: String, text: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.text = text
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func updateNavigationButtons() {
        // Update button states based on current step
    }
    
    // MARK: - Actions
    
    @objc private func previousStep() {
        if currentStep > 1 {
            currentStep -= 1
            updateStepDisplay()
        }
    }
    
    @objc private func nextStep() {
        if validateCurrentStep() {
            if currentStep < steps.count {
                currentStep += 1
                updateStepDisplay()
            } else {
                submitForm()
            }
        }
    }
    
    private func validateCurrentStep() -> Bool {
        errors.removeAll()
        var isValid = true
        
        switch currentStep {
        case 1:
            if formData.personalInfo.firstName.isEmpty {
                errors["firstName"] = "First name is required"
                isValid = false
            }
            if formData.personalInfo.lastName.isEmpty {
                errors["lastName"] = "Last name is required"
                isValid = false
            }
            if formData.personalInfo.email.isEmpty {
                errors["email"] = "Email is required"
                isValid = false
            }
        case 2:
            if formData.addressInfo.street.isEmpty {
                errors["street"] = "Street address is required"
                isValid = false
            }
            if formData.addressInfo.city.isEmpty {
                errors["city"] = "City is required"
                isValid = false
            }
        case 3:
            // Preferences are optional
            break
        case 4:
            if formData.paymentInfo.cardNumber.isEmpty {
                errors["cardNumber"] = "Card number is required"
                isValid = false
            }
        case 5:
            // Review step
            break
        default:
            break
        }
        
        return isValid
    }
    
    private func submitForm() {
        isSubmitting = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("Form submitted:", self.formData)
            self.isSubmitting = false
            
            let alert = UIAlertController(title: "Registration Complete!", message: "Thank you for completing the registration process.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - Supporting Types

struct FormData {
    var personalInfo = PersonalInfo()
    var addressInfo = AddressInfo()
    var preferences = Preferences()
    var paymentInfo = PaymentInfo()
    var review = Review()
}

struct PersonalInfo {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phone: String = ""
    var dateOfBirth: Date = Date()
}

struct AddressInfo {
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    var country: String = "US"
}

struct Preferences {
    var newsletter: Bool = false
    var notifications: Bool = true
    var theme: String = "light"
    var language: String = "en"
}

struct PaymentInfo {
    var cardNumber: String = ""
    var expiryDate: String = ""
    var cvv: String = ""
    var cardholderName: String = ""
}

struct Review {
    var termsAccepted: Bool = false
    var privacyAccepted: Bool = false
    var marketingAccepted: Bool = false
}

struct WizardStep {
    let id: Int
    let title: String
    let description: String
    let icon: String
}
