import SwiftUI
struct ToastNotificationIssuesView: View {
    @State private var notifications: [ToastNotification] = []
    @State private var notificationCount = 0
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Main Content Card
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    Text("Toast Notifications Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    // Description
                        .font(.body)
                        .foregroundColor(.secondary)
                    // Notification Controls
                    VStack(spacing: 15) {
                        // Success Notification
                        Button("Show Success Notification") {
                            showToast(type: .success, message: "Operation completed successfully!")
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .tint(.green)
                        // Error Notification
                        Button("Show Error Notification") {
                            showToast(type: .error, message: "An error occurred while processing your request.")
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .tint(.red)
                        // Warning Notification
                        Button("Show Warning Notification") {
                            showToast(type: .warning, message: "Please review your input before proceeding.")
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .tint(.orange)
                        // Info Notification
                        Button("Show Info Notification") {
                            showToast(type: .info, message: "New updates are available for download.")
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .tint(.blue)
                        // Clear All Button
                        Button("Clear All Notifications") {
                            clearAllNotifications()
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.regular)
                    }
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                // Toast Notifications Container
                VStack(spacing: 10) {
                    ForEach(notifications) { notification in
                        ToastNotificationView(notification: notification) {
                            removeNotification(notification)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 15) {
                        Text("• Missing dismiss button: No way to close notifications programmatically")
                        Text("• No auto-hide timer: Notifications don't disappear automatically")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    Text("")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Implement auto-hide timer with configurable duration")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor).opacity(0.5))
                .cornerRadius(8)
            }
            .padding()
        }
        .onAppear {
        }
    }
    private func showToast(type: ToastType, message: String) {
        notificationCount += 1
        let notification = ToastNotification(
            id: notificationCount,
            type: type,
            message: message
        )
        notifications.insert(notification, at: 0)
        // Should implement auto-hide functionality with configurable duration
        // Basic auto-hide (5 seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            removeNotification(notification)
        }
    }
    private func removeNotification(_ notification: ToastNotification) {
        notifications.removeAll { $0.id == notification.id }
    }
    private func clearAllNotifications() {
        notifications.removeAll()
        notificationCount = 0
    }
    }
}
enum ToastType {
    case success, error, warning, info
    var color: Color {
        switch self {
        case .success: return .green
        case .error: return .red
        case .warning: return .orange
        case .info: return .blue
        }
    }
    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .info: return "info.circle.fill"
        }
    }
}
struct ToastNotification: Identifiable {
    let id: Int
    let type: ToastType
    let message: String
}
struct ToastNotificationView: View {
    let notification: ToastNotification
    let onDismiss: () -> Void
    var body: some View {
        HStack {
            // Icon
            Image(systemName: notification.type.icon)
                .foregroundColor(notification.type.color)
                .font(.title2)
            // Message
            Text(notification.message)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            Spacer()
            Button("×") {
                onDismiss()
            }
            .buttonStyle(.plain)
            .font(.title2)
            .foregroundColor(.secondary)
            .frame(width: 24, height: 24)
        }
        .padding()
        .background(notification.type.color.opacity(0.1))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(notification.type.color.opacity(0.3), lineWidth: 1)
        )
    }
}
#Preview {
    ToastNotificationIssuesView()
        .frame(width: 600, height: 700)
}
