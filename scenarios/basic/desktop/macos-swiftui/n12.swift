import SwiftUI

struct MissingPageTitle: View {
    @State private var selectedTab = "general"
    
    var body: some View {
        VStack(spacing: 0) {ngs page without descriptive title element
            // Tab Navigation
            HStack(spacing: 0) {
                Button("General") {
                    selectedTab = "general"
                }
                .font(.headline)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == "general" ? .blue : .clear),
                    alignment: .bottom
                )
                
                Button("Privacy") {
                    selectedTab = "privacy"
                }
                .font(.headline)
                .foregroundColor(selectedTab == "privacy" ? .blue : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == "privacy" ? .blue : .clear),
                    alignment: .bottom
                )
                
                Button("Security") {
                    selectedTab = "security"
                }
                .font(.headline)
                .foregroundColor(selectedTab == "security" ? .blue : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == "security" ? .blue : .clear),
                    alignment: .bottom
                )
                
                Button("Notifications") {
                    selectedTab = "notifications"
                }
                .font(.headline)
                .foregroundColor(selectedTab == "notifications" ? .blue : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == "notifications" ? .blue : .clear),
                    alignment: .bottom
                )
            }
            .background(Color.white)
            
            // Settings Content
            ScrollView {
                VStack(spacing: 24) {
                    // General Settings
                    VStack(alignment: .leading, spacing: 16) {
                        Text("General Settings")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Language")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Picker("Language", selection: .constant("English")) {
                                    Text("English").tag("English")
                                    Text("Spanish").tag("Spanish")
                                    Text("French").tag("French")
                                    Text("German").tag("German")
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: 150)
                            }
                            
                            HStack {
                                Text("Theme")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Picker("Theme", selection: .constant("System")) {
                                    Text("System").tag("System")
                                    Text("Light").tag("Light")
                                    Text("Dark").tag("Dark")
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: 150)
                            }
                            
                            HStack {
                                Text("Auto-save")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(true))
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Privacy Settings
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Privacy Settings")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Data Collection")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(false))
                            }
                            
                            HStack {
                                Text("Analytics")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(true))
                            }
                            
                            HStack {
                                Text("Crash Reports")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(true))
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Security Settings
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Security Settings")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Two-Factor Authentication")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(true))
                            }
                            
                            HStack {
                                Text("Biometric Login")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(false))
                            }
                            
                            HStack {
                                Text("Session Timeout")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Picker("Timeout", selection: .constant("15 minutes")) {
                                    Text("5 minutes").tag("5 minutes")
                                    Text("15 minutes").tag("15 minutes")
                                    Text("30 minutes").tag("30 minutes")
                                    Text("1 hour").tag("1 hour")
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: 150)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Notification Settings
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Notification Settings")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Push Notifications")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(true))
                            }
                            
                            HStack {
                                Text("Email Notifications")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(false))
                            }
                            
                            HStack {
                                Text("SMS Notifications")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Toggle("", isOn: .constant(false))
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button("Save Changes") {
                            // Save action
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                        
                        Button("Reset to Defaults") {
                            // Reset action
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
    MissingPageTitle()
}
