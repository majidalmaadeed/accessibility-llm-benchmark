import SwiftUI

struct MissingLanguageAttribute: View {
    @State private var selectedLanguage = "English"
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("🌐")
                    .font(.system(size: 80))
                
                // Welcome Text - Mixed English/French without lang attributes
                Text("Welcome to our app! Bienvenue dans notre application!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Please sign in to continue. Veuillez vous connecter pour continuer.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(32)
            
            // Language Selection
            VStack(alignment: .leading, spacing: 16) {
                Text("Select Language / Choisir la langue:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Picker("Language", selection: $selectedLanguage) {
                    Text("🇺🇸 English").tag("English")
                    Text("🇫🇷 Français").tag("Français")
                    Text("🇪🇸 Español").tag("Español")
                    Text("🇩🇪 Deutsch").tag("Deutsch")
                    Text("🇮🇹 Italiano").tag("Italiano")
                    Text("🇵🇹 Português").tag("Português")
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 200)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            
            Spacer()
            
            // Login Form
            VStack(spacing: 24) {
                Text("Login Form")
                    .font(.title2)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email / Courriel")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        TextField("Enter your email", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password / Mot de passe")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        SecureField("Enter your password", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                // Action Buttons
                HStack(spacing: 16) {
                    Button("Sign In / Se connecter") {
                        // Sign in action
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button("Forgot Password? / Mot de passe oublié?") {
                        // Forgot password action
                    }
                    .foregroundColor(.blue)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                }
            }
            .padding(48)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding()
        }
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    MissingLanguageAttribute()
}
