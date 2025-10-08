import SwiftUI

struct LowContrastWarningText: View {
    @State private var sessionTimeout = 300 // 5 minutes in seconds
    @State private var timeRemaining = 300
    @State private var isSessionActive = true
    @State private var showWarning = false
    @State private var warningMessage = ""
    @State private var warningType: WarningType = .sessionTimeout
    @State private var isLoggedIn = true
    @State private var userActivity = Date()
    @State private var lastAction = "Page loaded"
    
    enum WarningType {
        case sessionTimeout
        case securityAlert
        case maintenanceNotice
        case systemError
        case dataLoss
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Text("Secure Dashboard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Welcome back, User")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // Session Status
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: isSessionActive ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                            .foregroundColor(isSessionActive ? .green : .orange)
                        
                        Text(isSessionActive ? "Session Active" : "Session Warning")
                            .font(.headline)
                            .foregroundColor(isSessionActive ? .green : .orange)
                    }
                    
                    if isSessionActive {
                        Text("Time remaining: \(formatTime(timeRemaining))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Warning Messages
                if showWarning {
                    VStack(spacing: 8) {
                        HStack {
                            Image(systemName: warningIcon)
                                .foregroundColor(warningColor)
                            
                            Text(warningTitle)
                                .font(.headline)
                                .foregroundColor(warningColor)
                        }
                        
                        Text(warningMessage)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(warningColor)
                    }
                    .padding()
                    .background(warningBackgroundColor)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(warningColor, lineWidth: 1)
                    )
                }
                
                // Main Content
                ScrollView {
                    VStack(spacing: 16) {
                        // Quick Actions
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            QuickActionCard(
                                title: "View Reports",
                                icon: "chart.bar.fill",
                                color: .blue
                            ) {
                                lastAction = "View Reports"
                                userActivity = Date()
                            }
                            
                            QuickActionCard(
                                title: "Manage Users",
                                icon: "person.2.fill",
                                color: .green
                            ) {
                                lastAction = "Manage Users"
                                userActivity = Date()
                            }
                            
                            QuickActionCard(
                                title: "Settings",
                                icon: "gear.fill",
                                color: .orange
                            ) {
                                lastAction = "Settings"
                                userActivity = Date()
                            }
                            
                            QuickActionCard(
                                title: "Help & Support",
                                icon: "questionmark.circle.fill",
                                color: .purple
                            ) {
                                lastAction = "Help & Support"
                                userActivity = Date()
                            }
                        }
                        
                        // Recent Activity
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Activity")
                                .font(.headline)
                            
                            VStack(spacing: 8) {
                                ActivityRow(
                                    action: lastAction,
                                    time: "Just now",
                                    icon: "checkmark.circle.fill",
                                    color: .green
                                )
                                
                                ActivityRow(
                                    action: "System backup completed",
                                    time: "2 minutes ago",
                                    icon: "externaldrive.fill",
                                    color: .blue
                                )
                                
                                ActivityRow(
                                    action: "User login detected",
                                    time: "5 minutes ago",
                                    icon: "person.circle.fill",
                                    color: .orange
                                )
                                
                                ActivityRow(
                                    action: "Security scan completed",
                                    time: "10 minutes ago",
                                    icon: "shield.fill",
                                    color: .green
                                )
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        
                        // System Status
                        VStack(alignment: .leading, spacing: 12) {
                            Text("System Status")
                                .font(.headline)
                            
                            VStack(spacing: 8) {
                                StatusRow(
                                    title: "Server Status",
                                    status: "Online",
                                    color: .green
                                )
                                
                                StatusRow(
                                    title: "Database",
                                    status: "Connected",
                                    color: .green
                                )
                                
                                StatusRow(
                                    title: "Security",
                                    status: "Active",
                                    color: .green
                                )
                                
                                StatusRow(
                                    title: "Backup",
                                    status: "Scheduled",
                                    color: .blue
                                )
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .padding()
                }
                
                Spacer()
                
                // Action Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        extendSession()
                    }) {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                            Text("Extend Session")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        logout()
                    }) {
                        HStack {
                            Image(systemName: "power")
                            Text("Logout")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .onReceive(timer) { _ in
                updateSession()
            }
            .onAppear {
                checkSessionStatus()
            }
        }
    }
    
    private var warningIcon: String {
        switch warningType {
        case .sessionTimeout:
            return "clock.fill"
        case .securityAlert:
            return "exclamationmark.triangle.fill"
        case .maintenanceNotice:
            return "wrench.fill"
        case .systemError:
            return "xmark.circle.fill"
        case .dataLoss:
            return "trash.fill"
        }
    }
    
    private var warningColor: Color {
        switch warningType {
        case .sessionTimeout:
            return Color(red: 0.8, green: 0.6, blue: 0.2) // Low contrast yellow
        case .securityAlert:
            return Color(red: 0.9, green: 0.7, blue: 0.3) // Low contrast orange
        case .maintenanceNotice:
            return Color(red: 0.7, green: 0.8, blue: 0.9) // Low contrast blue
        case .systemError:
            return Color(red: 0.8, green: 0.6, blue: 0.6) // Low contrast red
        case .dataLoss:
            return Color(red: 0.9, green: 0.8, blue: 0.7) // Low contrast red
        }
    }
    
    private var warningBackgroundColor: Color {
        switch warningType {
        case .sessionTimeout:
            return Color(red: 0.95, green: 0.9, blue: 0.8) // Very light yellow
        case .securityAlert:
            return Color(red: 0.95, green: 0.9, blue: 0.8) // Very light orange
        case .maintenanceNotice:
            return Color(red: 0.9, green: 0.95, blue: 0.98) // Very light blue
        case .systemError:
            return Color(red: 0.95, green: 0.9, blue: 0.9) // Very light red
        case .dataLoss:
            return Color(red: 0.95, green: 0.9, blue: 0.9) // Very light red
        }
    }
    
    private var warningTitle: String {
        switch warningType {
        case .sessionTimeout:
            return "Session Timeout Warning"
        case .securityAlert:
            return "Security Alert"
        case .maintenanceNotice:
            return "Maintenance Notice"
        case .systemError:
            return "System Error"
        case .dataLoss:
            return "Data Loss Warning"
        }
    }
    
    private func updateSession() {
        guard isSessionActive else { return }
        
        timeRemaining -= 1
        
        if timeRemaining <= 60 && timeRemaining > 0 {
            showWarning = true
            warningType = .sessionTimeout
            warningMessage = "Your session will expire in \(timeRemaining) seconds. Please save your work and refresh the page to continue."
        } else if timeRemaining <= 0 {
            isSessionActive = false
            showWarning = true
            warningType = .sessionTimeout
            warningMessage = "Your session has expired. Please log in again to continue."
        } else if timeRemaining <= 120 {
            showWarning = true
            warningType = .sessionTimeout
            warningMessage = "Your session will expire in \(formatTime(timeRemaining)). Please save your work."
        }
    }
    
    private func checkSessionStatus() {
        let timeSinceActivity = Date().timeIntervalSince(userActivity)
        
        if timeSinceActivity > 240 { // 4 minutes of inactivity
            showWarning = true
            warningType = .securityAlert
            warningMessage = "No activity detected for 4 minutes. For security reasons, your session may expire soon."
        }
    }
    
    private func extendSession() {
        timeRemaining = sessionTimeout
        isSessionActive = true
        showWarning = false
        userActivity = Date()
        lastAction = "Session extended"
    }
    
    private func logout() {
        isLoggedIn = false
        isSessionActive = false
        showWarning = false
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

struct ActivityRow: View {
    let action: String
    let time: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(action)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Text(time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct StatusRow: View {
    let title: String
    let status: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
            
            HStack(spacing: 4) {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                
                Text(status)
                    .font(.subheadline)
                    .foregroundColor(color)
            }
        }
        .padding(.vertical, 2)
    }
}

struct LowContrastWarningText_Previews: PreviewProvider {
    static var previews: some View {
        LowContrastWarningText()
    }
}

