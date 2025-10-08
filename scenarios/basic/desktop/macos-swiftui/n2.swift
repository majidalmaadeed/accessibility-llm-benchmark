import SwiftUI

struct ColorOnlyErrorIndication: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var phone = ""
    @State private var zipCode = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("User Registration")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Create your account")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white)
            
            // Registration Form
            ScrollView {
                VStack(spacing: 24) {
                    // Personal Information Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Personal Information")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            // Email Field - COLOR-ONLY ERROR INDICATION
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email Address")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                TextField("Enter your email", text: $email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.red, lineWidth: 2) // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                                    )
                                
                                // COLOR-ONLY ERROR INDICATION - No text error message, only red border
                            }
                            
                            // Password Field - COLOR-ONLY ERROR INDICATION
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                SecureField("Enter your password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.red, lineWidth: 2) // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                                    )
                                
                                // COLOR-ONLY ERROR INDICATION - No text error message, only red border
                            }
                            
                            // Confirm Password Field - COLOR-ONLY ERROR INDICATION
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Confirm Password")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                SecureField("Confirm your password", text: $confirmPassword)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.red, lineWidth: 2) // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                                    )
                                
                                // COLOR-ONLY ERROR INDICATION - No text error message, only red border
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Contact Information Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Contact Information")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            // Phone Field - COLOR-ONLY ERROR INDICATION
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Phone Number")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                TextField("Enter your phone number", text: $phone)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.red, lineWidth: 2) // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                                    )
                                
                                // COLOR-ONLY ERROR INDICATION - No text error message, only red border
                            }
                            
                            // ZIP Code Field - COLOR-ONLY ERROR INDICATION
                            VStack(alignment: .leading, spacing: 8) {
                                Text("ZIP Code")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                TextField("Enter your ZIP code", text: $zipCode)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.red, lineWidth: 2) // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                                    )
                                
                                // COLOR-ONLY ERROR INDICATION - No text error message, only red border
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Terms and Conditions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Terms and Conditions")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Toggle("", isOn: .constant(false))
                                Text("I agree to the Terms of Service")
                                    .font(.subheadline)
                            }
                            
                            HStack {
                                Toggle("", isOn: .constant(false))
                                Text("I agree to the Privacy Policy")
                                    .font(.subheadline)
                            }
                            
                            HStack {
                                Toggle("", isOn: .constant(false))
                                Text("I want to receive marketing emails")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button("Create Account") {
                            // Create account action
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                        
                        Button("Cancel") {
                            // Cancel action
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ColorOnlyErrorIndication()
}
