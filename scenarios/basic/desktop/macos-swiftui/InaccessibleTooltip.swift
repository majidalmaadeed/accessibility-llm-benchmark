import SwiftUI

struct InaccessibleTooltip: View {
    @State private var showTooltip = false
    @State private var showHelp = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("Form Validation")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Please fill out the form below")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white)
            
            // Form Content
            ScrollView {
                VStack(spacing: 24) {
                    // Personal Information Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Personal Information")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            // Name Field
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Full Name")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
                                    Button("?") {
                                        showHelp.toggle()
                                    }
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .onHover { hovering in
                                        showTooltip = hovering
                                    }
                                    
                                    if showTooltip {
                                        Text("Enter your full legal name")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.black)
                                            .cornerRadius(4)
                                            .offset(x: 0, y: -30)
                                    }
                                }
                                
                                TextField("Enter your full name", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            // Email Field
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Email Address")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
                                    Button("?") {
                                        showHelp.toggle()
                                    }
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .onHover { hovering in
                                        showTooltip = hovering
                                    }
                                    
                                    if showTooltip {
                                        Text("Enter a valid email address")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.black)
                                            .cornerRadius(4)
                                            .offset(x: 0, y: -30)
                                    }
                                }
                                
                                TextField("Enter your email", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            // Phone Field
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Phone Number")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
                                    Button("?") {
                                        showHelp.toggle()
                                    }
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .onHover { hovering in
                                        showTooltip = hovering
                                    }
                                    
                                    if showTooltip {
                                        Text("Include country code if international")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.black)
                                            .cornerRadius(4)
                                            .offset(x: 0, y: -30)
                                    }
                                }
                                
                                TextField("Enter your phone number", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Address Information Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Address Information")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            // Street Address Field
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Street Address")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
                                    Button("?") {
                                        showHelp.toggle()
                                    }
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .onHover { hovering in
                                        showTooltip = hovering
                                    }
                                    
                                    if showTooltip {
                                        Text("Include apartment or suite number")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.black)
                                            .cornerRadius(4)
                                            .offset(x: 0, y: -30)
                                    }
                                }
                                
                                TextField("Enter your street address", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            // City Field
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("City")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
                                    Button("?") {
                                        showHelp.toggle()
                                    }
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .onHover { hovering in
                                        showTooltip = hovering
                                    }
                                    
                                    if showTooltip {
                                        Text("Enter the city name")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.black)
                                            .cornerRadius(4)
                                            .offset(x: 0, y: -30)
                                    }
                                }
                                
                                TextField("Enter your city", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            // ZIP Code Field
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("ZIP Code")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
                                    Button("?") {
                                        showHelp.toggle()
                                    }
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .onHover { hovering in
                                        showTooltip = hovering
                                    }
                                    
                                    if showTooltip {
                                        Text("Enter 5-digit ZIP code")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.black)
                                            .cornerRadius(4)
                                            .offset(x: 0, y: -30)
                                    }
                                }
                                
                                TextField("Enter your ZIP code", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button("Submit Form") {
                            // Submit action
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                        
                        Button("Clear Form") {
                            // Clear action
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
    InaccessibleTooltip()
}
