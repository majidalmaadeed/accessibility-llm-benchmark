import UIKit

class KeyboardTrapInWidgetViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var isDatePickerVisible = false
    private var datePickerView: UIView?
    private var currentTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Event Scheduler"
        
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
        
        // Event form
        let formView = createFormView()
        contentView.addSubview(formView)
        
        // Date picker widget (hidden by default)
        let datePickerWidget = createDatePickerWidget()
        contentView.addSubview(datePickerWidget)
        datePickerWidget.isHidden = true
        self.datePickerView = datePickerWidget
        
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
            
            datePickerWidget.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 20),
            datePickerWidget.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            datePickerWidget.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            submitView.topAnchor.constraint(equalTo: datePickerWidget.bottomAnchor, constant: 20),
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
        titleLabel.text = "Event Scheduler"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        titleLabel.text = "Schedule your events and meetings"
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
        titleLabel.text = "Event Details"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(stackView)
        
        // Event title field
        let titleField = createTextField(placeholder: "Event Title *")
        stackView.addArrangedSubview(createFieldContainer(label: "Event Title", field: titleField))
        
        // Event description field
        let descriptionField = createTextField(placeholder: "Event Description")
        stackView.addArrangedSubview(createFieldContainer(label: "Description", field: descriptionField))
        
        // Date field with custom picker
        let dateField = createTextField(placeholder: "Select Date *")
        dateField.addTarget(self, action: #selector(dateFieldTapped), for: .touchUpInside)
        stackView.addArrangedSubview(createFieldContainer(label: "Event Date", field: dateField))
        
        // Time field
        let timeField = createTextField(placeholder: "Select Time *")
        timeField.addTarget(self, action: #selector(timeFieldTapped), for: .touchUpInside)
        stackView.addArrangedSubview(createFieldContainer(label: "Event Time", field: timeField))
        
        // Location field
        let locationField = createTextField(placeholder: "Event Location")
        stackView.addArrangedSubview(createFieldContainer(label: "Location", field: locationField))
        
        NSLayoutConstraint.activate([
            formView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            
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
    
    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func createFieldContainer(label: String, field: UITextField) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelView = UILabel()
        labelView.text = label
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
    
    private func createDatePickerWidget() -> UIView {
        let widgetView = UIView()
        widgetView.backgroundColor = .systemBackground
        widgetView.layer.cornerRadius = 12
        widgetView.layer.shadowColor = UIColor.black.cgColor
        widgetView.layer.shadowOffset = CGSize(width: 0, height: 2)
        widgetView.layer.shadowRadius = 4
        widgetView.layer.shadowOpacity = 0.1
        widgetView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Select Date"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        widgetView.addSubview(titleLabel)
        
        // Custom date picker with keyboard trap
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        widgetView.addSubview(datePicker)
        
        // Action buttons
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 12
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        widgetView.addSubview(buttonStackView)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        cancelButton.layer.cornerRadius = 8
        cancelButton.addTarget(self, action: #selector(cancelDatePicker), for: .touchUpInside)
        buttonStackView.addArrangedSubview(cancelButton)
        
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.layer.cornerRadius = 8
        confirmButton.addTarget(self, action: #selector(confirmDatePicker), for: .touchUpInside)
        buttonStackView.addArrangedSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            widgetView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: widgetView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: widgetView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: widgetView.trailingAnchor, constant: -20),
            
            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: widgetView.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: widgetView.trailingAnchor, constant: -20),
            
            buttonStackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            buttonStackView.leadingAnchor.constraint(equalTo: widgetView.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: widgetView.trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: widgetView.bottomAnchor, constant: -20),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return widgetView
    }
    
    private func createSubmitView() -> UIView {
        let submitView = UIView()
        submitView.backgroundColor = .systemBackground
        submitView.translatesAutoresizingMaskIntoConstraints = false
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Create Event", for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 25
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitView.addSubview(submitButton)
        
        let infoLabel = UILabel()
        infoLabel.text = "All fields marked with * are required"
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.textColor = .secondaryLabel
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        submitView.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            submitView.heightAnchor.constraint(equalToConstant: 100),
            
            submitButton.centerXAnchor.constraint(equalTo: submitView.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: submitView.topAnchor, constant: 20),
            submitButton.widthAnchor.constraint(equalToConstant: 150),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            infoLabel.centerXAnchor.constraint(equalTo: submitView.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(greaterThanOrEqualTo: submitView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(lessThanOrEqualTo: submitView.trailingAnchor, constant: -20),
            infoLabel.bottomAnchor.constraint(lessThanOrEqualTo: submitView.bottomAnchor, constant: -20)
        ])
        
        return submitView
    }
    
    // MARK: - Date Picker Methods
    @objc private func dateFieldTapped() {
        showDatePicker()
    }
    
    @objc private func timeFieldTapped() {
        showTimePicker()
    }
    
    private func showDatePicker() {
        isDatePickerVisible = true
        datePickerView?.isHidden = false
        
        // Create overlay to trap focus
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlay.tag = 999
        overlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlay)
        
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Move date picker to front
        view.bringSubviewToFront(datePickerView!)
        
        // Animate in
        datePickerView?.alpha = 0
        datePickerView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3) {
            self.datePickerView?.alpha = 1
            self.datePickerView?.transform = .identity
        }
    }
    
    private func showTimePicker() {
        // Similar to date picker but for time
        showDatePicker()
    }
    
    @objc private func cancelDatePicker() {
        hideDatePicker()
    }
    
    @objc private func confirmDatePicker() {
        // Set the selected date to the text field
        if let datePicker = datePickerView?.subviews.first(where: { $0 is UIDatePicker }) as? UIDatePicker {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            // Find the date field and set its value
            // This is a simplified example
        }
        hideDatePicker()
    }
    
    private func hideDatePicker() {
        isDatePickerVisible = false
        
        // Remove overlay
        if let overlay = view.viewWithTag(999) {
            overlay.removeFromSuperview()
        }
        
        // Animate out
        UIView.animate(withDuration: 0.3, animations: {
            self.datePickerView?.alpha = 0
            self.datePickerView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.datePickerView?.isHidden = true
            self.datePickerView?.alpha = 1
            self.datePickerView?.transform = .identity
        }
    }
    
    // MARK: - Actions
    @objc private func submitTapped() {
        let alert = UIAlertController(
            title: "Event Created",
            message: "Your event has been scheduled successfully!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Keyboard Handling
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Ensure date picker is hidden when leaving the view
        if isDatePickerVisible {
            hideDatePicker()
        }
    }
}
