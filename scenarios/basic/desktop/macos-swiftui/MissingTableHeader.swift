import SwiftUI

struct MissingTableHeader: View {
    @State private var searchText = ""
    @State private var sortOption = "Name"
    
    var body: some View {
        VStack(spacing: 0) {
            // Search and Filter Bar
            VStack(spacing: 16) {
                HStack {
                    TextField("Search employees...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    
                    Button("Search") {
                        // Search action
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                Picker("Sort by", selection: $sortOption) {
                    Text("Sort by Name").tag("Name")
                    Text("Sort by Department").tag("Department")
                    Text("Sort by Position").tag("Position")
                    Text("Sort by Salary").tag("Salary")
                    Text("Sort by Start Date").tag("Start Date")
                    Text("Sort by Status").tag("Status")
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 200)
            }
            .padding()
            .background(Color.white)
            
            // Data Table - MISSING TABLE HEADER
            ScrollView {
                VStack(spacing: 0) {
                    // Employee 1
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 32, height: 32)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("John Smith")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Engineering • Senior Developer")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("$95,000 • 2022-01-15")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("john.smith@company.com • +1 (555) 123-4567")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("Active")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
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
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                    
                    // Employee 2
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 32, height: 32)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sarah Johnson")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Marketing • Marketing Manager")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("$78,000 • 2021-08-22")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("sarah.johnson@company.com • +1 (555) 234-5678")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("Active")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
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
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                    
                    // Employee 3
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 32, height: 32)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Mike Chen")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Sales • Sales Director")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("$120,000 • 2020-03-10")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("mike.chen@company.com • +1 (555) 345-6789")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("Active")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
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
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3)),
                        alignment: .bottom
                    )
                    
                    // Employee 4
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.pink)
                            .frame(width: 32, height: 32)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Emily Davis")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("HR • HR Specialist")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("$65,000 • 2023-02-01")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("emily.davis@company.com • +1 (555) 456-7890")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("Active")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
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
                        }
                    }
                    .padding()
                    .background(Color.white)
                }
            }
            
            // Summary Footer
            HStack {
                Text("Total Employees: 4")
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
    MissingTableHeader()
}
