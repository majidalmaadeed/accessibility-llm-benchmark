import SwiftUI

struct LowContrastWarningText: View {
    var body: some View {
        VStack(spacing: 0) {
            // Warning Banner - LOW CONTRAST WARNING TEXT
            HStack(spacing: 12) {
                // Warning Icon - LOW CONTRAST
                Text("⚠️")
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Session Timeout Warning")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46)) // #757575
                    
                    Text("Your session will expire in 5 minutes. Please save your work and extend your session to continue.")
                        .font(.subheadline)
                        .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74)) // #BDBDBD
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    // Action Buttons - LOW CONTRAST
                    Button("Extend") {
                        // Extend session action
                    }
                    .foregroundColor(Color(red: 0.56, green: 0.79, blue: 0.98)) // #90CAF9
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    
                    Button("Logout") {
                        // Logout action
                    }
                    .foregroundColor(Color(red: 0.94, green: 0.6, blue: 0.6)) // #EF9A9A
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .background(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
            
            // Main Content
            ScrollView {
                VStack(spacing: 24) {
                    // Dashboard Header
                    VStack(spacing: 16) {
                        Text("Welcome back!")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Your session is active and secure")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Text("⏰")
                                .font(.title2)
                            Text("5 minutes remaining")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Actions")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                            VStack(spacing: 8) {
                                Text("📊")
                                    .font(.largeTitle)
                                Text("View Reports")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("👥")
                                    .font(.largeTitle)
                                Text("Manage Users")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("⚙️")
                                    .font(.largeTitle)
                                Text("Settings")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("❓")
                                    .font(.largeTitle)
                                Text("Help & Support")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                    }
                    
                    // Recent Activity
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Activity")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("🟢")
                                    .font(.headline)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("User logged in")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    Text("2 minutes ago")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            
                            HStack {
                                Text("📊")
                                    .font(.headline)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Report generated")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    Text("15 minutes ago")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            
                            HStack {
                                Text("⚙️")
                                    .font(.headline)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Settings updated")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    Text("1 hour ago")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                        }
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
    LowContrastWarningText()
}
