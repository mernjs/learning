import SwiftUI
import EventKit

struct CalendarPermissionView: View {
    @State private var isCalendarAuthorized = false
    @State private var isCalendarDenied = false
    
    var body: some View {
        VStack {
            if isCalendarDenied {
                Text("Calendar access denied. Please enable calendar access in Settings.")
            } else if !isCalendarAuthorized {
                Button(action: {
                    requestCalendarPermission()
                }) {
                    Text("Request Calendar Access")
                }
            } else {
                Text("Calendar access granted. You can now access calendar events.")
            }
        }
        .padding()
        .onAppear {
            checkCalendarPermission()
        }
    }
    
    private func checkCalendarPermission() {
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            isCalendarAuthorized = true
        case .notDetermined:
            isCalendarAuthorized = false
        case .denied, .restricted:
            isCalendarDenied = true
        @unknown default:
            break
        }
    }
    
    private func requestCalendarPermission() {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    isCalendarAuthorized = true
                } else {
                    isCalendarDenied = true
                }
            }
        }
    }
}
