import SwiftUI

struct RightClickOnlyMenu: View {
    @State private var selectedItem = ""
    @State private var showContextMenu = false
    @State private var contextMenuPosition = CGPoint.zero
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("File Manager")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Manage your files and folders")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white)
            
            // Toolbar
            HStack(spacing: 16) {
                Button("📁") {
                    // New folder action
                }
                .font(.headline)
                .frame(width: 32, height: 32)
                .background(Color.gray)
                .cornerRadius(8)
                
                Button("📄") {
                    // New file action
                }
                .font(.headline)
                .frame(width: 32, height: 32)
                .background(Color.gray)
                .cornerRadius(8)
                
                Button("📤") {
                    // Upload action
                }
                .font(.headline)
                .frame(width: 32, height: 32)
                .background(Color.gray)
                .cornerRadius(8)
                
                Button("📥") {
                    // Download action
                }
                .font(.headline)
                .frame(width: 32, height: 32)
                .background(Color.gray)
                .cornerRadius(8)
                
                Spacer()
                
                Text("Selected: \(selectedItem)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            
            // File List
            ScrollView {
                VStack(spacing: 0) {
                    // File 1 - RIGHT-CLICK ONLY MENU
                    HStack(spacing: 12) {
                        Text("📄")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("document.pdf")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("2.5 MB • PDF • Modified 2 hours ago")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("📊")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(selectedItem == "document.pdf" ? Color.blue.opacity(0.1) : Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        selectedItem = "document.pdf"
                    }
                    .contextMenu {
                        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
                        Button("Open") {
                            // Open action
                        }
                        
                        Button("Edit") {
                            // Edit action
                        }
                        
                        Button("Copy") {
                            // Copy action
                        }
                        
                        Button("Move") {
                            // Move action
                        }
                        
                        Divider()
                        
                        Button("Delete", role: .destructive) {
                            // Delete action
                        }
                    }
                    
                    // File 2 - RIGHT-CLICK ONLY MENU
                    HStack(spacing: 12) {
                        Text("📁")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Projects")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Folder • 15 items • Modified 1 day ago")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("📊")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(selectedItem == "Projects" ? Color.blue.opacity(0.1) : Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        selectedItem = "Projects"
                    }
                    .contextMenu {
                        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
                        Button("Open") {
                            // Open action
                        }
                        
                        Button("Rename") {
                            // Rename action
                        }
                        
                        Button("Copy") {
                            // Copy action
                        }
                        
                        Button("Move") {
                            // Move action
                        }
                        
                        Divider()
                        
                        Button("Delete", role: .destructive) {
                            // Delete action
                        }
                    }
                    
                    // File 3 - RIGHT-CLICK ONLY MENU
                    HStack(spacing: 12) {
                        Text("🖼️")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("image.jpg")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("1.2 MB • JPEG • Modified 3 hours ago")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("📊")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(selectedItem == "image.jpg" ? Color.blue.opacity(0.1) : Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        selectedItem = "image.jpg"
                    }
                    .contextMenu {
                        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
                        Button("Open") {
                            // Open action
                        }
                        
                        Button("Edit") {
                            // Edit action
                        }
                        
                        Button("Copy") {
                            // Copy action
                        }
                        
                        Button("Move") {
                            // Move action
                        }
                        
                        Divider()
                        
                        Button("Delete", role: .destructive) {
                            // Delete action
                        }
                    }
                    
                    // File 4 - RIGHT-CLICK ONLY MENU
                    HStack(spacing: 12) {
                        Text("📊")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("spreadsheet.xlsx")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("850 KB • Excel • Modified 1 day ago")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("📊")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(selectedItem == "spreadsheet.xlsx" ? Color.blue.opacity(0.1) : Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        selectedItem = "spreadsheet.xlsx"
                    }
                    .contextMenu {
                        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
                        Button("Open") {
                            // Open action
                        }
                        
                        Button("Edit") {
                            // Edit action
                        }
                        
                        Button("Copy") {
                            // Copy action
                        }
                        
                        Button("Move") {
                            // Move action
                        }
                        
                        Divider()
                        
                        Button("Delete", role: .destructive) {
                            // Delete action
                        }
                    }
                    
                    // File 5 - RIGHT-CLICK ONLY MENU
                    HStack(spacing: 12) {
                        Text("🎵")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("audio.mp3")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("4.2 MB • MP3 • Modified 2 days ago")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("📊")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(selectedItem == "audio.mp3" ? Color.blue.opacity(0.1) : Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        selectedItem = "audio.mp3"
                    }
                    .contextMenu {
                        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
                        Button("Open") {
                            // Open action
                        }
                        
                        Button("Edit") {
                            // Edit action
                        }
                        
                        Button("Copy") {
                            // Copy action
                        }
                        
                        Button("Move") {
                            // Move action
                        }
                        
                        Divider()
                        
                        Button("Delete", role: .destructive) {
                            // Delete action
                        }
                    }
                }
            }
            
            // Status Bar
            HStack {
                Text("5 items")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Last modified: 2 hours ago")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3)),
                alignment: .top
            )
        }
    }
}

#Preview {
    RightClickOnlyMenu()
}
