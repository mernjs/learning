import SwiftUI
import EventKit

struct RemindersPermissionView: View {
    @State private var isReminderAuthorized = false
    @State private var isReminderDenied = false
    
    var body: some View {
        VStack {
            if isReminderDenied {
                Text("Reminders access denied. Please enable reminders access in Settings.")
            } else if !isReminderAuthorized {
                Button(action: {
                    requestReminderPermission()
                }) {
                    Text("Request Reminders Access")
                }
            } else {
                Text("Reminders access granted. You can now access reminders.")
            }
        }
        .padding()
        .onAppear {
            checkReminderPermission()
        }
    }
    
    private func checkReminderPermission() {
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .reminder) {
        case .authorized:
            isReminderAuthorized = true
        case .notDetermined:
            isReminderAuthorized = false
        case .denied, .restricted:
            isReminderDenied = true
        @unknown default:
            break
        }
    }
    
    private func requestReminderPermission() {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .reminder) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    isReminderAuthorized = true
                } else {
                    isReminderDenied = true
                }
            }
        }
    }
}
