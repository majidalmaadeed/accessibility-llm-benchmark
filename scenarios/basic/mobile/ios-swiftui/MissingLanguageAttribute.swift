import SwiftUI

struct MissingLanguageAttribute: View {
    @State private var selectedLanguage = "en"
    @State private var currentContent = "english"
    @State private var showLanguagePicker = false
    @State private var isLoggedIn = false
    @State private var username = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showForgotPassword = false
    @State private var showSignUp = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showError = false
    
    let languages = [
        ("en", "English", "🇺🇸"),
        ("es", "Español", "🇪🇸"),
        ("fr", "Français", "🇫🇷"),
        ("de", "Deutsch", "🇩🇪"),
        ("it", "Italiano", "🇮🇹"),
        ("pt", "Português", "🇵🇹"),
        ("ru", "Русский", "🇷🇺"),
        ("ja", "日本語", "🇯🇵"),
        ("ko", "한국어", "🇰🇷"),
        ("zh", "中文", "🇨🇳")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        VStack(spacing: 16) {
                            // Language Selector
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    showLanguagePicker = true
                                }) {
                                    HStack(spacing: 8) {
                                        Text(flagForLanguage(selectedLanguage))
                                            .font(.title2)
                                        
                                        Text(languageNameForCode(selectedLanguage))
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        
                                        Image(systemName: "chevron.down")
                                            .font(.caption)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                                }
                            }
                            .padding(.horizontal)
                            
                            // Logo and Title
                            VStack(spacing: 12) {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.blue)
                                
                                Text("Welcome")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                
                                Text("Sign in to your account")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        // Login Form
                        VStack(spacing: 20) {
                            VStack(spacing: 16) {
                                // Username Field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Username or Email")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    TextField("Enter your username or email", text: $username)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                }
                                
                                // Password Field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Password")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    SecureField("Enter your password", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                
                                // Remember Me and Forgot Password
                                HStack {
                                    Button(action: {
                                        rememberMe.toggle()
                                    }) {
                                        HStack(spacing: 8) {
                                            Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                                .foregroundColor(rememberMe ? .blue : .gray)
                                            
                                            Text("Remember me")
                                                .font(.subheadline)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        showForgotPassword = true
                                    }) {
                                        Text("Forgot Password?")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                            
                            // Login Button
                            Button(action: {
                                performLogin()
                            }) {
                                HStack {
                                    if isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .scaleEffect(0.8)
                                    } else {
                                        Text("Sign In")
                                            .fontWeight(.semibold)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
                            .disabled(isLoading || username.isEmpty || password.isEmpty)
                            
                            // Divider
                            HStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                                
                                Text("or")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 16)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                            
                            // Social Login Buttons
                            VStack(spacing: 12) {
                                Button(action: {
                                    // Google Sign In
                                }) {
                                    HStack {
                                        Image(systemName: "globe")
                                            .font(.title3)
                                        
                                        Text("Continue with Google")
                                            .fontWeight(.medium)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.primary)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                }
                                
                                Button(action: {
                                    // Apple Sign In
                                }) {
                                    HStack {
                                        Image(systemName: "applelogo")
                                            .font(.title3)
                                        
                                        Text("Continue with Apple")
                                            .fontWeight(.medium)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                }
                            }
                            
                            // Sign Up Link
                            HStack {
                                Text("Don't have an account?")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Button(action: {
                                    showSignUp = true
                                }) {
                                    Text("Sign Up")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Footer
                        VStack(spacing: 12) {
                            Text("By signing in, you agree to our")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            HStack(spacing: 4) {
                                Button("Terms of Service") {
                                    // Show terms
                                }
                                .font(.caption)
                                .foregroundColor(.blue)
                                
                                Text("and")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Button("Privacy Policy") {
                                    // Show privacy
                                }
                                .font(.caption)
                                .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Error", isPresented: $showError) {
                Button("OK") {
                    showError = false
                }
            } message: {
                Text(errorMessage)
            }
            .sheet(isPresented: $showLanguagePicker) {
                LanguagePickerView(selectedLanguage: $selectedLanguage)
            }
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordView()
            }
            .sheet(isPresented: $showSignUp) {
                SignUpView()
            }
        }
    }
    
    private func performLogin() {
        isLoading = true
        errorMessage = ""
        
        // Simulate login process
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            
            if username.isEmpty || password.isEmpty {
                errorMessage = "Please fill in all fields"
                showError = true
            } else if username == "test" && password == "password" {
                isLoggedIn = true
            } else {
                errorMessage = "Invalid username or password"
                showError = true
            }
        }
    }
    
    private func flagForLanguage(_ code: String) -> String {
        return languages.first { $0.0 == code }?.2 ?? "🇺🇸"
    }
    
    private func languageNameForCode(_ code: String) -> String {
        return languages.first { $0.0 == code }?.1 ?? "English"
    }
}

struct LanguagePickerView: View {
    @Binding var selectedLanguage: String
    @Environment(\.dismiss) private var dismiss
    
    let languages = [
        ("en", "English", "🇺🇸"),
        ("es", "Español", "🇪🇸"),
        ("fr", "Français", "🇫🇷"),
        ("de", "Deutsch", "🇩🇪"),
        ("it", "Italiano", "🇮🇹"),
        ("pt", "Português", "🇵🇹"),
        ("ru", "Русский", "🇷🇺"),
        ("ja", "日本語", "🇯🇵"),
        ("ko", "한국어", "🇰🇷"),
        ("zh", "中文", "🇨🇳")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(languages, id: \.0) { language in
                    HStack {
                        Text(language.2)
                            .font(.title2)
                        
                        Text(language.1)
                            .font(.headline)
                        
                        Spacer()
                        
                        if selectedLanguage == language.0 {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedLanguage = language.0
                        dismiss()
                    }
                }
            }
            .navigationTitle("Select Language")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ForgotPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var isLoading = false
    @State private var showSuccess = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Image(systemName: "lock.rotation")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Forgot Password?")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Enter your email address and we'll send you a link to reset your password.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email Address")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)
                
                Button(action: {
                    resetPassword()
                }) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        } else {
                            Text("Send Reset Link")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(isLoading || email.isEmpty)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Reset Password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Success", isPresented: $showSuccess) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Password reset link sent to your email")
            }
        }
    }
    
    private func resetPassword() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            showSuccess = true
        }
    }
}

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var agreeToTerms = false
    @State private var isLoading = false
    @State private var showSuccess = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Create Account")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Join us today and get started")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("First Name")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                TextField("First name", text: $firstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Last Name")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                TextField("Last name", text: $lastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email Address")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter your email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            SecureField("Create a password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Confirm Password")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            SecureField("Confirm your password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Button(action: {
                                agreeToTerms.toggle()
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: agreeToTerms ? "checkmark.square.fill" : "square")
                                        .foregroundColor(agreeToTerms ? .blue : .gray)
                                    
                                    Text("I agree to the Terms of Service and Privacy Policy")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    Button(action: {
                        createAccount()
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
                    .disabled(isLoading || !isFormValid)
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Success", isPresented: $showSuccess) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Account created successfully!")
            }
        }
    }
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && agreeToTerms
    }
    
    private func createAccount() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            showSuccess = true
        }
    }
}

struct MissingLanguageAttribute_Previews: PreviewProvider {
    static var previews: some View {
        MissingLanguageAttribute()
    }
}

