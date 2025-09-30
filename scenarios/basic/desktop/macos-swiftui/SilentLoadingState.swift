import SwiftUI

struct SilentLoadingState: View {
    @State private var isLoading = false
    @State private var loadingProgress = 0.0
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("Data Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("View and manage your data")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white)
            
            // Action Buttons
            HStack(spacing: 16) {
                Button("Refresh Data") {
                    startLoading()
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(8)
                
                Button("Export Data") {
                    startLoading()
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.green)
                .cornerRadius(8)
                
                Button("Generate Report") {
                    startLoading()
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.orange)
                .cornerRadius(8)
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            
            // SILENT LOADING STATE - Content spinner without screen reader announcement
            if isLoading {
                VStack(spacing: 16) {
                    // SILENT LOADING STATE - Content spinner without screen reader announcement
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                    
                    Text("Loading...")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    ProgressView(value: loadingProgress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .frame(width: 200)
                    
                    Text("\(Int(loadingProgress * 100))%")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(48)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
                .padding()
            }
            
            // Main Content
            ScrollView {
                VStack(spacing: 24) {
                    // Data Summary
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Data Summary")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                            VStack(spacing: 8) {
                                Text("📊")
                                    .font(.largeTitle)
                                Text("Total Records")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("1,234")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("✅")
                                    .font(.largeTitle)
                                Text("Completed")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("987")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("⏳")
                                    .font(.largeTitle)
                                Text("Pending")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("247")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
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
                                    Text("Data refreshed")
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
                                Text("📤")
                                    .font(.headline)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Data exported")
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
                    
                    // Data Table
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Data Records")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 0) {
                            // Table Header
                            HStack {
                                Text("ID")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(width: 60, alignment: .leading)
                                
                                Text("Name")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Status")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(width: 100, alignment: .leading)
                                
                                Text("Date")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(width: 120, alignment: .leading)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            
                            // Table Rows
                            ForEach(1...5, id: \.self) { index in
                                HStack {
                                    Text("\(index)")
                                        .font(.subheadline)
                                        .frame(width: 60, alignment: .leading)
                                    
                                    Text("Record \(index)")
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(index % 2 == 0 ? "Active" : "Pending")
                                        .font(.subheadline)
                                        .foregroundColor(index % 2 == 0 ? .green : .orange)
                                        .frame(width: 100, alignment: .leading)
                                    
                                    Text("2024-01-\(String(format: "%02d", index))")
                                        .font(.subheadline)
                                        .frame(width: 120, alignment: .leading)
                                }
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color.gray.opacity(0.3)),
                                    alignment: .bottom
                                )
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
    
    private func startLoading() {
        isLoading = true
        loadingProgress = 0.0
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            loadingProgress += 0.02
            if loadingProgress >= 1.0 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    SilentLoadingState()
}
