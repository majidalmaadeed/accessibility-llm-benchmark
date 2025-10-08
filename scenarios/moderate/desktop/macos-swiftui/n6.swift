import SwiftUI
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Main Content Card
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    // Description
                        .font(.body)
                        .foregroundColor(.secondary)
                    VStack(spacing: 0) {
                        HStack(spacing: 2) {
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            }
                            }
                            }
                            }
                        }
                        .padding()
                        .background(Color(NSColor.controlBackgroundColor))
                        .cornerRadius(0, 0, 8, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0, 0, 8, 8)
                                .stroke(Color(NSColor.separatorColor), lineWidth: 1)
                        )
                    }
                }
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                VStack(alignment: .leading, spacing: 15) {
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    Text("")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                    VStack(alignment: .leading, spacing: 8) {
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
    }
}
    let isSelected: Bool
    func makeBody(configuration: Configuration) -> some View {
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 8, 8, 0, 0)
                    .fill(isSelected ? Color.blue : Color(NSColor.controlBackgroundColor).opacity(0.5))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8, 8, 0, 0)
                    .stroke(Color(NSColor.separatorColor), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
    @State private var autoStart = false
    @State private var notifications = false
    @State private var updates = false
    @State private var selectedTheme = "Light"
    let themes = ["Light", "Dark", "Auto"]
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("General Settings")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            VStack(alignment: .leading, spacing: 15) {
                Toggle("Start application on system startup", isOn: $autoStart)
                Toggle("Enable desktop notifications", isOn: $notifications)
                Toggle("Automatically check for updates", isOn: $updates)
                HStack {
                    Text("Theme:")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Picker("Theme", selection: $selectedTheme) {
                        ForEach(themes, id: \.self) { theme in
                            Text(theme).tag(theme)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
        }
    }
}
    @State private var twoFactor = false
    @State private var biometric = false
    @State private var sessionTimeout = false
    @State private var timeoutMinutes = "30"
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Security Settings")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            VStack(alignment: .leading, spacing: 15) {
                Toggle("Enable two-factor authentication", isOn: $twoFactor)
                Toggle("Use biometric authentication", isOn: $biometric)
                Toggle("Enable session timeout", isOn: $sessionTimeout)
                HStack {
                    Text("Session timeout (minutes):")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    TextField("30", text: $timeoutMinutes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                }
            }
        }
    }
}
    @State private var analytics = false
    @State private var crashReports = false
    @State private var location = false
    @State private var retentionDays = "90"
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Privacy Settings")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            VStack(alignment: .leading, spacing: 15) {
                Toggle("Allow usage analytics", isOn: $analytics)
                Toggle("Send crash reports", isOn: $crashReports)
                Toggle("Allow location access", isOn: $location)
                HStack {
                    Text("Data retention (days):")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    TextField("90", text: $retentionDays)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                }
            }
        }
    }
}
    @State private var debugMode = false
    @State private var verboseLogging = false
    @State private var experimentalFeatures = false
    @State private var selectedLogLevel = "Info"
    let logLevels = ["Error", "Warning", "Info", "Debug"]
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Advanced Settings")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            VStack(alignment: .leading, spacing: 15) {
                Toggle("Enable debug mode", isOn: $debugMode)
                Toggle("Enable verbose logging", isOn: $verboseLogging)
                Toggle("Enable experimental features", isOn: $experimentalFeatures)
                HStack {
                    Text("Log level:")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Picker("Log level", selection: $selectedLogLevel) {
                        ForEach(logLevels, id: \.self) { level in
                            Text(level).tag(level)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
        }
    }
}
#Preview {
        .frame(width: 600, height: 700)
}
