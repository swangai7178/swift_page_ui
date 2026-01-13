import SwiftUI

struct SettingsView: View {

    @State private var notificationsEnabled = true

    var body: some View {
        Form {

            Section(header: Text("Preferences")) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
            }

            Section {
                Button("Log Out") {
                    print("User logged out")
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
