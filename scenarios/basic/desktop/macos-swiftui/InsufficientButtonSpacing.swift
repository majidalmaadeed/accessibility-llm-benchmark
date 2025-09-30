import SwiftUI

struct InsufficientButtonSpacing: View {
    @State private var isEditing = false
    @State private var isDeleting = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("Document Editor")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Edit and manage your documents")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white)
            
            // Action Buttons - INSUFFICIENT BUTTON SPACING
            HStack(spacing: 2) { // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                Button("Save") {
                    // Save action
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(8)
                
                Button("Edit") {
                    isEditing.toggle()
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.green)
                .cornerRadius(8)
                
                Button("Delete") {
                    isDeleting.toggle()
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.red)
                .cornerRadius(8)
                
                Button("Share") {
                    // Share action
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.orange)
                .cornerRadius(8)
                
                Button("Print") {
                    // Print action
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.purple)
                .cornerRadius(8)
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            
            // Document Content
            ScrollView {
                VStack(spacing: 24) {
                    // Document Title
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Document Title")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        TextField("Enter document title", text: .constant("Sample Document"))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Document Content
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Document Content")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        TextEditor(text: .constant("This is a sample document content. You can edit this text when in edit mode. The document contains various sections and formatting options."))
                            .frame(minHeight: 200)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .disabled(!isEditing)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Formatting Options - INSUFFICIENT BUTTON SPACING
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Formatting Options")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 2) { // INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart
                            Button("B") {
                                // Bold action
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                            Button("I") {
                                // Italic action
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                            Button("U") {
                                // Underline action
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                            Button("A") {
                                // Align left action
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                            Button("A") {
                                // Align center action
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                            Button("A") {
                                // Align right action
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Quick Actions - INSUFFICIENT BUTTON SPACING
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Actions")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 2) { // INSUFFICIENT BUTTON SPACING - Quick action buttons placed 2px apart
                            Button("📄") {
                                // New document action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                            Button("📁") {
                                // Open folder action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                            Button("💾") {
                                // Save action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                            Button("🖨️") {
                                // Print action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                            Button("📤") {
                                // Export action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                            Button("🔍") {
                                // Search action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            .background(Color.gray)
                            .cornerRadius(8)
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
    InsufficientButtonSpacing()
}
