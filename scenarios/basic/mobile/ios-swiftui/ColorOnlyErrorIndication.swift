import SwiftUI

struct ColorOnlyErrorIndication: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var birthDate = Date()
    @State private var selectedCountry = "United States"
    @State private var agreeToTerms = false
    @State private var subscribeToNewsletter = false
    @State private var isLoading = false
    @State private var showSuccessAlert = false
    @State private var validationErrors: Set<String> = []
    
    let countries = ["United States", "Canada", "United Kingdom", "Germany", "France", "Japan", "Australia"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Create Account")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Join our community and start your journey")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        // Name Fields
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("First Name")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                TextField("First name", text: $firstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(validationErrors.contains("firstName") ? Color.red : Color.clear, lineWidth: 2)
                                    )
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Last Name")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                TextField("Last name", text: $lastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(validationErrors.contains("lastName") ? Color.red : Color.clear, lineWidth: 2)
                                    )
                            }
                        }
                        
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email Address")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("your.email@example.com", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(validationErrors.contains("email") ? Color.red : Color.clear, lineWidth: 2)
                                )
                        }
                        
                        // Phone Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Phone Number")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("(555) 123-4567", text: $phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.phonePad)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(validationErrors.contains("phone") ? Color.red : Color.clear, lineWidth: 2)
                                )
                        }
                        
                        // Password Fields
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            SecureField("Create a password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(validationErrors.contains("password") ? Color.red : Color.clear, lineWidth: 2)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Confirm Password")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            SecureField("Confirm your password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(validationErrors.contains("confirmPassword") ? Color.red : Color.clear, lineWidth: 2)
                                )
                        }
                        
                        // Birth Date
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Date of Birth")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            DatePicker("", selection: $birthDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(validationErrors.contains("birthDate") ? Color.red : Color.clear, lineWidth: 1)
                                )
                        }
                        
                        // Country Selection
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Country")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Picker("Country", selection: $selectedCountry) {
                                ForEach(countries, id: \.self) { country in
                                    Text(country).tag(country)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(validationErrors.contains("country") ? Color.red : Color.clear, lineWidth: 2)
                            )
                        }
                        
                        // Terms and Newsletter
                        VStack(spacing: 12) {
                            HStack {
                                Button(action: {
                                    agreeToTerms.toggle()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: agreeToTerms ? "checkmark.square.fill" : "square")
                                            .foregroundColor(agreeToTerms ? .blue : (validationErrors.contains("terms") ? .red : .gray))
                                        
                                        VStack(alignment: .leading) {
                                            Text("I agree to the Terms of Service and Privacy Policy")
                                                .font(.subheadline)
                                                .foregroundColor(validationErrors.contains("terms") ? .red : .primary)
                                            
                                            Text("Required")
                                                .font(.caption)
                                                .foregroundColor(validationErrors.contains("terms") ? .red : .secondary)
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                            
                            HStack {
                                Button(action: {
                                    subscribeToNewsletter.toggle()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: subscribeToNewsletter ? "checkmark.square.fill" : "square")
                                            .foregroundColor(subscribeToNewsletter ? .blue : .gray)
                                        
                                        Text("Subscribe to our newsletter for updates and offers")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    // Create Account Button
                    Button(action: {
                        validateAndSubmit()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Create Account")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(isLoading)
                    
                    // Sign In Link
                    HStack {
                        Text("Already have an account?")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            // Navigate to sign in
                        }) {
                            Text("Sign In")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Success", isPresented: $showSuccessAlert) {
                Button("OK") {
                    // Navigate to main app
                }
            } message: {
                Text("Your account has been created successfully!")
            }
        }
    }
    
    private func validateAndSubmit() {
        validationErrors.removeAll()
        
        // Validate first name
        if firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validationErrors.insert("firstName")
        }
        
        // Validate last name
        if lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validationErrors.insert("lastName")
        }
        
        // Validate email
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !isValidEmail(email) {
            validationErrors.insert("email")
        }
        
        // Validate phone
        if phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validationErrors.insert("phone")
        }
        
        // Validate password
        if password.count < 8 {
            validationErrors.insert("password")
        }
        
        // Validate confirm password
        if confirmPassword != password {
            validationErrors.insert("confirmPassword")
        }
        
        // Validate birth date (must be at least 13 years old)
        let calendar = Calendar.current
        let thirteenYearsAgo = calendar.date(byAdding: .year, value: -13, to: Date()) ?? Date()
        if birthDate > thirteenYearsAgo {
            validationErrors.insert("birthDate")
        }
        
        // Validate terms agreement
        if !agreeToTerms {
            validationErrors.insert("terms")
        }
        
        // If no errors, proceed with registration
        if validationErrors.isEmpty {
            isLoading = true
            
            // Simulate registration process
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
                showSuccessAlert = true
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct ColorOnlyErrorIndication_Previews: PreviewProvider {
    static var previews: some View {
        ColorOnlyErrorIndication()
    }
}

