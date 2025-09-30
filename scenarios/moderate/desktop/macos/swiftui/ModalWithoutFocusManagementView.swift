import SwiftUI
    @State private var showModal = false
    @State private var selectedTheme = "Light"
    @State private var selectedLanguage = "English"
    @State private var selectedNotifications = "All"
    let themes = ["Light", "Dark", "Auto"]
    let languages = ["English", "Spanish", "French"]
    let notifications = ["All", "Important Only", "None"]
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Main Content Card
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    Text("Settings Modal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    // Description
                    Text("Configure your application settings using the modal below.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    // Open Modal Button
                    Button("Open Settings Modal") {
                        showModal = true
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                VStack(alignment: .leading, spacing: 15) {
                        Text("• Escape key not handled: Modal doesn't close when Escape is pressed")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    Text("How to Fix:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Handle Escape key to close modal")
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
        .sheet(isPresented: $showModal) {
            VStack(spacing: 20) {
                // Modal Header
                HStack {
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Spacer()
                    Button("×") {
                        showModal = false
                    }
                    .buttonStyle(.plain)
                    .font(.title2)
                    .foregroundColor(.secondary)
                }
                // Settings Form
                VStack(alignment: .leading, spacing: 20) {
                    // Theme Setting
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Theme:")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Picker("Theme", selection: $selectedTheme) {
                            ForEach(themes, id: \.self) { theme in
                                Text(theme).tag(theme)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    // Language Setting
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Language:")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Picker("Language", selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language).tag(language)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    // Notifications Setting
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email Notifications:")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Picker("Notifications", selection: $selectedNotifications) {
                            ForEach(notifications, id: \.self) { notification in
                                Text(notification).tag(notification)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Spacer()
                // Modal Actions
                HStack {
                    Button("Cancel") {
                        showModal = false
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                    Button("Save Settings") {
                        // Simulate saving settings
                        showModal = false
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .frame(width: 500, height: 400)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        }
        .onAppear {
        }
    }
    }
}
#Preview {
        .frame(width: 600, height: 700)
}
