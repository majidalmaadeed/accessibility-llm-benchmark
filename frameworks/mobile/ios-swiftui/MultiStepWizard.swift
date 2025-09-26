import SwiftUI

struct MultiStepWizard: View {
    @State private var currentStep: Int = 1
    @State private var formData = FormData()
    @State private var errors: [String: String] = [:]
    @State private var isSubmitting: Bool = false
    @State private var showSuccess: Bool = false
    
    let steps = [
        WizardStep(id: 1, title: "Personal Information", description: "Tell us about yourself", icon: "person"),
        WizardStep(id: 2, title: "Address Details", description: "Where should we send your items?", icon: "house"),
        WizardStep(id: 3, title: "Preferences", description: "Customize your experience", icon: "gear"),
        WizardStep(id: 4, title: "Payment", description: "Secure payment information", icon: "creditcard"),
        WizardStep(id: 5, title: "Review & Confirm", description: "Review your information", icon: "checkmark")
    ]
    
    let countries = [
        Country(value: "US", label: "United States"),
        Country(value: "CA", label: "Canada"),
        Country(value: "GB", label: "United Kingdom"),
        Country(value: "AU", label: "Australia"),
        Country(value: "DE", label: "Germany"),
        Country(value: "FR", label: "France")
    ]
    
    let states = [
        StateOption(value: "CA", label: "California"),
        StateOption(value: "NY", label: "New York"),
        StateOption(value: "TX", label: "Texas"),
        StateOption(value: "FL", label: "Florida"),
        StateOption(value: "IL", label: "Illinois"),
        StateOption(value: "PA", label: "Pennsylvania")
    ]
    
    let themes = [
        ThemeOption(value: "light", label: "Light"),
        ThemeOption(value: "dark", label: "Dark"),
        ThemeOption(value: "auto", label: "Auto")
    ]
    
    let languages = [
        LanguageOption(value: "en", label: "English"),
        LanguageOption(value: "es", label: "Spanish"),
        LanguageOption(value: "fr", label: "French"),
        LanguageOption(value: "de", label: "German")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                headerView
                progressView
                stepsView
                contentView
                actionsView
            }
            .navigationTitle("Multi-Step Registration")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert("Registration Complete!", isPresented: $showSuccess) {
            Button("Start New Registration") {
                resetForm()
            }
        } message: {
            Text("Thank you for completing the registration process. You will receive a confirmation email shortly.")
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("Multi-Step Registration")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Complete your registration in a few simple steps")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
    
    private var progressView: some View {
        VStack(spacing: 8) {
            ProgressView(value: progressPercentage)
                .progressViewStyle(LinearProgressViewStyle())
                .scaleEffect(x: 1, y: 2, anchor: .center)
            
            Text("Step \(currentStep) of \(steps.count) (\(Int(progressPercentage * 100))% complete)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
    
    private var stepsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(steps, id: \.id) { step in
                    stepIndicator(step)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    private func stepIndicator(_ step: WizardStep) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(stepColor(step.id))
                    .frame(width: 40, height: 40)
                
                if isStepCompleted(step.id) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                } else {
                    Image(systemName: step.icon)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }
            
            VStack(spacing: 2) {
                Text(step.title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(step.id == currentStep ? .primary : .secondary)
                
                Text(step.description)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 80)
        .onTapGesture {
            if isStepAccessible(step.id) {
                goToStep(step.id)
            }
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 20) {
                switch currentStep {
                case 1:
                    personalInfoView
                case 2:
                    addressInfoView
                case 3:
                    preferencesView
                case 4:
                    paymentInfoView
                case 5:
                    reviewView
                default:
                    EmptyView()
                }
            }
            .padding()
        }
    }
    
    private var personalInfoView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Personal Information")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Please provide your basic personal details")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("First Name *")
                        .font(.headline)
                    
                    TextField("Enter your first name", text: $formData.personalInfo.firstName)
                        .textFieldStyle(.roundedBorder)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["firstName"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if let error = errors["firstName"] {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Last Name *")
                        .font(.headline)
                    
                    TextField("Enter your last name", text: $formData.personalInfo.lastName)
                        .textFieldStyle(.roundedBorder)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["lastName"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if let error = errors["lastName"] {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email Address *")
                        .font(.headline)
                    
                    TextField("Enter your email address", text: $formData.personalInfo.email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["email"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if let error = errors["email"] {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number *")
                        .font(.headline)
                    
                    TextField("Enter your phone number", text: $formData.personalInfo.phone)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.phonePad)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["phone"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if let error = errors["phone"] {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date of Birth *")
                        .font(.headline)
                    
                    DatePicker("", selection: $formData.personalInfo.dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["dateOfBirth"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if let error = errors["dateOfBirth"] {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    private var addressInfoView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Address Information")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Where should we send your items?")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Street Address *")
                        .font(.headline)
                    
                    TextField("Enter your street address", text: $formData.addressInfo.street)
                        .textFieldStyle(.roundedBorder)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["street"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if let error = errors["street"] {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("City *")
                            .font(.headline)
                        
                        TextField("Enter your city", text: $formData.addressInfo.city)
                            .textFieldStyle(.roundedBorder)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(errors["city"] != nil ? Color.red : Color.clear, lineWidth: 1)
                            )
                        
                        if let error = errors["city"] {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("State *")
                            .font(.headline)
                        
                        Picker("State", selection: $formData.addressInfo.state) {
                            Text("Select a state").tag("")
                            ForEach(states, id: \.value) { state in
                                Text(state.label).tag(state.value)
                            }
                        }
                        .pickerStyle(.menu)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["state"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                        
                        if let error = errors["state"] {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ZIP Code *")
                            .font(.headline)
                        
                        TextField("Enter your ZIP code", text: $formData.addressInfo.zipCode)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(errors["zipCode"] != nil ? Color.red : Color.clear, lineWidth: 1)
                            )
                        
                        if let error = errors["zipCode"] {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Country")
                            .font(.headline)
                        
                        Picker("Country", selection: $formData.addressInfo.country) {
                            ForEach(countries, id: \.value) { country in
                                Text(country.label).tag(country.value)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
            }
        }
    }
    
    private var preferencesView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Preferences")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Customize your experience")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Toggle("Subscribe to our newsletter", isOn: $formData.preferences.newsletter)
                        .toggleStyle(SwitchToggleStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Toggle("Receive email notifications", isOn: $formData.preferences.notifications)
                        .toggleStyle(SwitchToggleStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Theme Preference")
                        .font(.headline)
                    
                    Picker("Theme", selection: $formData.preferences.theme) {
                        ForEach(themes, id: \.value) { theme in
                            Text(theme.label).tag(theme.value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Language")
                        .font(.headline)
                    
                    Picker("Language", selection: $formData.preferences.language) {
                        ForEach(languages, id: \.value) { language in
                            Text(language.label).tag(language.value)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
        }
    }
    
    private var paymentInfoView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Payment Information")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Secure payment details")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Card Number *")
                        .font(.headline)
                    
                    TextField("1234 5678 9012 3456", text: $formData.paymentInfo.cardNumber)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["cardNumber"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if let error = errors["cardNumber"] {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Expiry Date *")
                            .font(.headline)
                        
                        TextField("MM/YY", text: $formData.paymentInfo.expiryDate)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(errors["expiryDate"] != nil ? Color.red : Color.clear, lineWidth: 1)
                            )
                        
                        if let error = errors["expiryDate"] {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("CVV *")
                            .font(.headline)
                        
                        TextField("123", text: $formData.paymentInfo.cvv)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(errors["cvv"] != nil ? Color.red : Color.clear, lineWidth: 1)
                            )
                        
                        if let error = errors["cvv"] {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cardholder Name *")
                        .font(.headline)
                    
                    TextField("Enter cardholder name", text: $formData.paymentInfo.cardholderName)
                        .textFieldStyle(.roundedBorder)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(errors["cardholderName"] != nil ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if let error = errors["cardholderName"] {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    private var reviewView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Review & Confirm")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Please review your information before submitting")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 16) {
                reviewSection("Personal Information") {
                    VStack(alignment: .leading, spacing: 8) {
                        reviewRow("Name", value: "\(formData.personalInfo.firstName) \(formData.personalInfo.lastName)")
                        reviewRow("Email", value: formData.personalInfo.email)
                        reviewRow("Phone", value: formData.personalInfo.phone)
                    }
                }
                
                reviewSection("Address") {
                    VStack(alignment: .leading, spacing: 8) {
                        reviewRow("Address", value: "\(formData.addressInfo.street), \(formData.addressInfo.city), \(formData.addressInfo.state) \(formData.addressInfo.zipCode)")
                    }
                }
                
                reviewSection("Preferences") {
                    VStack(alignment: .leading, spacing: 8) {
                        reviewRow("Newsletter", value: formData.preferences.newsletter ? "Yes" : "No")
                        reviewRow("Theme", value: formData.preferences.theme)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Terms & Conditions")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Button(action: { formData.review.termsAccepted.toggle() }) {
                                Image(systemName: formData.review.termsAccepted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(formData.review.termsAccepted ? .blue : .gray)
                            }
                            .buttonStyle(.plain)
                            
                            Text("I accept the Terms and Conditions *")
                                .font(.subheadline)
                        }
                        
                        if let error = errors["termsAccepted"] {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                        HStack {
                            Button(action: { formData.review.privacyAccepted.toggle() }) {
                                Image(systemName: formData.review.privacyAccepted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(formData.review.privacyAccepted ? .blue : .gray)
                            }
                            .buttonStyle(.plain)
                            
                            Text("I accept the Privacy Policy *")
                                .font(.subheadline)
                        }
                        
                        if let error = errors["privacyAccepted"] {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                        HStack {
                            Button(action: { formData.review.marketingAccepted.toggle() }) {
                                Image(systemName: formData.review.marketingAccepted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(formData.review.marketingAccepted ? .blue : .gray)
                            }
                            .buttonStyle(.plain)
                            
                            Text("I would like to receive marketing communications")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
    
    private func reviewSection<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            content()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private func reviewRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
    
    private var actionsView: some View {
        HStack(spacing: 16) {
            if currentStep > 1 {
                Button("← Previous") {
                    previousStep()
                }
                .buttonStyle(.bordered)
            }
            
            Spacer()
            
            if currentStep < steps.count {
                Button("Next →") {
                    nextStep()
                }
                .buttonStyle(.borderedProminent)
            } else {
                Button(isSubmitting ? "Submitting..." : "Submit Registration") {
                    submitForm()
                }
                .buttonStyle(.borderedProminent)
                .disabled(isSubmitting)
            }
        }
        .padding()
    }
    
    // MARK: - Computed Properties
    
    private var progressPercentage: Double {
        Double(currentStep) / Double(steps.count)
    }
    
    // MARK: - Methods
    
    private func nextStep() {
        if validateCurrentStep() {
            if currentStep < steps.count {
                currentStep += 1
            }
        }
    }
    
    private func previousStep() {
        if currentStep > 1 {
            currentStep -= 1
        }
    }
    
    private func goToStep(_ stepNumber: Int) {
        if stepNumber >= 1 && stepNumber <= steps.count {
            currentStep = stepNumber
            validateCurrentStep()
        }
    }
    
    private func validateCurrentStep() -> Bool {
        errors.removeAll()
        var isValid = true
        
        switch currentStep {
        case 1:
            if formData.personalInfo.firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["firstName"] = "First name is required"
                isValid = false
            }
            if formData.personalInfo.lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["lastName"] = "Last name is required"
                isValid = false
            }
            if formData.personalInfo.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["email"] = "Email is required"
                isValid = false
            } else if !isValidEmail(formData.personalInfo.email) {
                errors["email"] = "Please enter a valid email address"
                isValid = false
            }
            if formData.personalInfo.phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["phone"] = "Phone number is required"
                isValid = false
            }
            
        case 2:
            if formData.addressInfo.street.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["street"] = "Street address is required"
                isValid = false
            }
            if formData.addressInfo.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["city"] = "City is required"
                isValid = false
            }
            if formData.addressInfo.state.isEmpty {
                errors["state"] = "State is required"
                isValid = false
            }
            if formData.addressInfo.zipCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["zipCode"] = "ZIP code is required"
                isValid = false
            }
            
        case 3:
            // Preferences are optional, no validation needed
            break
            
        case 4:
            if formData.paymentInfo.cardNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["cardNumber"] = "Card number is required"
                isValid = false
            } else if !isValidCardNumber(formData.paymentInfo.cardNumber) {
                errors["cardNumber"] = "Please enter a valid card number"
                isValid = false
            }
            if formData.paymentInfo.expiryDate.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["expiryDate"] = "Expiry date is required"
                isValid = false
            } else if !isValidExpiryDate(formData.paymentInfo.expiryDate) {
                errors["expiryDate"] = "Please enter a valid expiry date (MM/YY)"
                isValid = false
            }
            if formData.paymentInfo.cvv.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["cvv"] = "CVV is required"
                isValid = false
            } else if !isValidCVV(formData.paymentInfo.cvv) {
                errors["cvv"] = "Please enter a valid CVV"
                isValid = false
            }
            if formData.paymentInfo.cardholderName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errors["cardholderName"] = "Cardholder name is required"
                isValid = false
            }
            
        case 5:
            if !formData.review.termsAccepted {
                errors["termsAccepted"] = "You must accept the terms and conditions"
                isValid = false
            }
            if !formData.review.privacyAccepted {
                errors["privacyAccepted"] = "You must accept the privacy policy"
                isValid = false
            }
            
        default:
            break
        }
        
        return isValid
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidCardNumber(_ cardNumber: String) -> Bool {
        let cleaned = cardNumber.replacingOccurrences(of: " ", with: "")
        return cleaned.count >= 13 && cleaned.count <= 19 && cleaned.allSatisfy { $0.isNumber }
    }
    
    private func isValidExpiryDate(_ expiryDate: String) -> Bool {
        let regex = "^(0[1-9]|1[0-2])/\\d{2}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: expiryDate)
    }
    
    private func isValidCVV(_ cvv: String) -> Bool {
        return cvv.count == 3 || cvv.count == 4
    }
    
    private func submitForm() {
        if !validateCurrentStep() {
            return
        }
        
        isSubmitting = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("Form submitted:", formData)
            isSubmitting = false
            showSuccess = true
        }
    }
    
    private func resetForm() {
        formData = FormData()
        currentStep = 1
        errors.removeAll()
        showSuccess = false
    }
    
    private func isStepCompleted(_ stepNumber: Int) -> Bool {
        return stepNumber < currentStep
    }
    
    private func isStepAccessible(_ stepNumber: Int) -> Bool {
        return stepNumber <= currentStep
    }
    
    private func stepColor(_ stepNumber: Int) -> Color {
        if isStepCompleted(stepNumber) {
            return .green
        } else if stepNumber == currentStep {
            return .blue
        } else {
            return .gray
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

struct Country {
    let value: String
    let label: String
}

struct StateOption {
    let value: String
    let label: String
}

struct ThemeOption {
    let value: String
    let label: String
}

struct LanguageOption {
    let value: String
    let label: String
}

// MARK: - Preview

struct MultiStepWizard_Previews: PreviewProvider {
    static var previews: some View {
        MultiStepWizard()
    }
}
