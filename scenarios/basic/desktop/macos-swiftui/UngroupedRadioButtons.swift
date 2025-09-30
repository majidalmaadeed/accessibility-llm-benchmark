import SwiftUI

struct UngroupedRadioButtons: View {
    @State private var selectedContactMethod = "email"
    @State private var selectedNewsletter = "yes"
    @State private var selectedNotifications = "all"
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("Contact Preferences")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("How would you like us to contact you?")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white)
            
            // Contact Method Section - UNGROUPED RADIO BUTTONS
            VStack(alignment: .leading, spacing: 16) {
                Text("Preferred Contact Method")
                    .font(.headline)
                    .fontWeight(.bold)
                
                // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Button(action: {
                            selectedContactMethod = "email"
                        }) {
                            HStack {
                                Image(systemName: selectedContactMethod == "email" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedContactMethod == "email" ? .blue : .gray)
                                Text("Email")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            selectedContactMethod = "phone"
                        }) {
                            HStack {
                                Image(systemName: selectedContactMethod == "phone" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedContactMethod == "phone" ? .blue : .gray)
                                Text("Phone")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            selectedContactMethod = "sms"
                        }) {
                            HStack {
                                Image(systemName: selectedContactMethod == "sms" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedContactMethod == "sms" ? .blue : .gray)
                                Text("SMS")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            selectedContactMethod = "mail"
                        }) {
                            HStack {
                                Image(systemName: selectedContactMethod == "mail" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedContactMethod == "mail" ? .blue : .gray)
                                Text("Mail")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            
            // Newsletter Subscription Section - UNGROUPED RADIO BUTTONS
            VStack(alignment: .leading, spacing: 16) {
                Text("Newsletter Subscription")
                    .font(.headline)
                    .fontWeight(.bold)
                
                // UNGROUPED RADIO BUTTONS - Newsletter preference radio buttons without fieldset grouping
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Button(action: {
                            selectedNewsletter = "yes"
                        }) {
                            HStack {
                                Image(systemName: selectedNewsletter == "yes" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedNewsletter == "yes" ? .blue : .gray)
                                Text("Yes, send me newsletters")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            selectedNewsletter = "no"
                        }) {
                            HStack {
                                Image(systemName: selectedNewsletter == "no" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedNewsletter == "no" ? .blue : .gray)
                                Text("No, don't send newsletters")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            
            // Notification Preferences Section - UNGROUPED RADIO BUTTONS
            VStack(alignment: .leading, spacing: 16) {
                Text("Notification Preferences")
                    .font(.headline)
                    .fontWeight(.bold)
                
                // UNGROUPED RADIO BUTTONS - Notification preference radio buttons without fieldset grouping
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Button(action: {
                            selectedNotifications = "all"
                        }) {
                            HStack {
                                Image(systemName: selectedNotifications == "all" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedNotifications == "all" ? .blue : .gray)
                                Text("All notifications")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            selectedNotifications = "important"
                        }) {
                            HStack {
                                Image(systemName: selectedNotifications == "important" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedNotifications == "important" ? .blue : .gray)
                                Text("Important only")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            selectedNotifications = "none"
                        }) {
                            HStack {
                                Image(systemName: selectedNotifications == "none" ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedNotifications == "none" ? .blue : .gray)
                                Text("No notifications")
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            
            // Action Buttons
            HStack(spacing: 16) {
                Button("Save Preferences") {
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
                    selectedContactMethod = "email"
                    selectedNewsletter = "yes"
                    selectedNotifications = "all"
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

#Preview {
    UngroupedRadioButtons()
}
