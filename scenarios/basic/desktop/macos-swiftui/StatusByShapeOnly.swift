import SwiftUI

struct StatusByShapeOnly: View {
    @State private var selectedStatus = "pending"
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("Document Management System")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Review and approve documents")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            
            // Filter Options
            HStack(spacing: 8) {
                Button("All") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Pending") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Approved") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Rejected") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            
            // Documents List
            ScrollView {
                VStack(spacing: 16) {
                    Text("Documents")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Document 1
                    HStack(spacing: 12) {
                        // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
                        if selectedStatus == "approved" {
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: 24, height: 24)
                        } else if selectedStatus == "rejected" {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 24, height: 24)
                        } else {
                            Circle()
                                .fill(Color.yellow)
                                .frame(width: 24, height: 24)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Project Proposal Q1 2024")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("Marketing Department • 2.5 MB • PDF")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("Last modified: 2024-01-15 14:30")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            Button("👁️") {
                                // View action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            
                            Button("✏️") {
                                // Edit action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            
                            Button("📤") {
                                // Download action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Document 2
                    HStack(spacing: 12) {
                        // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 24, height: 24)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Budget Report 2023")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("Finance Department • 1.8 MB • Excel")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("Last modified: 2024-01-12 09:15")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            Button("👁️") {
                                // View action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            
                            Button("✏️") {
                                // Edit action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            
                            Button("📤") {
                                // Download action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Document 3
                    HStack(spacing: 12) {
                        // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
                        Circle()
                            .fill(Color.red)
                            .frame(width: 24, height: 24)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Employee Handbook v2.1")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("HR Department • 3.2 MB • PDF")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("Last modified: 2024-01-10 16:45")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            Button("👁️") {
                                // View action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            
                            Button("✏️") {
                                // Edit action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            
                            Button("📤") {
                                // Download action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Document 4
                    HStack(spacing: 12) {
                        // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 24, height: 24)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Technical Specifications")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("Engineering Department • 4.1 MB • PDF")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("Last modified: 2024-01-08 11:20")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            Button("👁️") {
                                // View action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            
                            Button("✏️") {
                                // Edit action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                            
                            Button("📤") {
                                // Download action
                            }
                            .font(.headline)
                            .frame(width: 32, height: 32)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                .padding()
            }
            
            // Summary Footer
            HStack {
                Text("Total Documents: 4")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack {
                    Text("Sort by: Name")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("↓")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
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
    StatusByShapeOnly()
}
