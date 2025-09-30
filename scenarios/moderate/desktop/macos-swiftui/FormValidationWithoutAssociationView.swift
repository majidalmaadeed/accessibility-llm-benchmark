import SwiftUI
struct FormValidationWithoutAssociationView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var usernameError = ""
    @State private var passwordError = ""
    @State private var genericError = ""
    @State private var isSubmitting = false
    @State private var showUsernameError = false
    @State private var showPasswordError = false
    @State private var showGenericError = false
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Main Content Card
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    Text("Login Form")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    // Description
                    Text("Please enter your credentials to access your account.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    // Login Form
                    VStack(alignment: .leading, spacing: 20) {
                        // Username Field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Username:")
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            TextField("Enter username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: username) { _ in
                                    clearFieldError(field: "username")
                                }
                            if showUsernameError {
                                Text(usernameError)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                        }
                        // Password Field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Password:")
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            SecureField("Enter password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: password) { _ in
                                    clearFieldError(field: "password")
                                }
                            if showPasswordError {
                                Text(passwordError)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                        }
                        // Generic Error Message - NOT ASSOCIATED WITH SPECIFIC FIELDS
                        if showGenericError {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text(genericError)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red.opacity(0.3), lineWidth: 1)
                            )
                        }
                        // Login Button
                        Button(action: onLoginClicked) {
                            HStack {
                                if isSubmitting {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                }
                                Text(isSubmitting ? "Logging in..." : "Login")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .disabled(isSubmitting)
                    }
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                VStack(alignment: .leading, spacing: 15) {
                        Text("• Generic error: Generic error message doesn't specify which fields have issues")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    Text("How to Fix:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Use specific error messages for each field")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor).opacity(0.5))
                .cornerRadius(8)
            }
            .padding()
        }
        .onAppear {
        }
    }
    }
    private func onLoginClicked() {
        guard !isSubmitting else { return }
        clearAllErrors()
        let hasErrors = validateForm()
        if hasErrors {
            // Show generic error message - NOT ASSOCIATED WITH SPECIFIC FIELDS
            showGenericError = true
            genericError = "Please fill in all required fields."
            return
        }
        // Simulate login process
        isSubmitting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSubmitting = false
            // Show success message
        }
    }
    private func validateForm() -> Bool {
        var hasErrors = false
        // Validate username
        if username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showUsernameError = true
            usernameError = "Username is required"
            hasErrors = true
        } else if username.count < 3 {
            showUsernameError = true
            usernameError = "Username must be at least 3 characters"
            hasErrors = true
        }
        // Validate password
        if password.isEmpty {
            showPasswordError = true
            passwordError = "Password is required"
            hasErrors = true
        } else if password.count < 8 {
            showPasswordError = true
            passwordError = "Password must be at least 8 characters"
            hasErrors = true
        }
        return hasErrors
    }
    private func clearAllErrors() {
        showUsernameError = false
        showPasswordError = false
        showGenericError = false
        usernameError = ""
        passwordError = ""
        genericError = ""
    }
    private func clearFieldError(field: String) {
        switch field.lowercased() {
        case "username":
            showUsernameError = false
        case "password":
            showPasswordError = false
        default:
            break
        }
    }
}
#Preview {
    FormValidationWithoutAssociationView()
        .frame(width: 600, height: 700)
}
