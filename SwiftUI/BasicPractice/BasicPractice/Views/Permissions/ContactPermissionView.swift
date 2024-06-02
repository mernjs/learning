import SwiftUI
import Contacts

struct ContactPermissionView: View {
    @State private var isContactAuthorized = false
    @State private var isContactDenied = false
    
    var body: some View {
        VStack {
            if isContactDenied {
                Text("Contact access denied. Please enable contact access in Settings.")
            } else if !isContactAuthorized {
                Button(action: {
                    requestContactPermission()
                }) {
                    Text("Request Contact Access")
                }
            } else {
                Text("Contact access granted. You can now access contacts.")
            }
        }
        .padding()
        .onAppear {
            checkContactPermission()
        }
    }
    
    private func checkContactPermission() {
        let contactStore = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            isContactAuthorized = true
        case .notDetermined:
            isContactAuthorized = false
        case .denied, .restricted:
            isContactDenied = true
        @unknown default:
            break
        }
    }
    
    private func requestContactPermission() {
        let contactStore = CNContactStore()
        
        contactStore.requestAccess(for: .contacts) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    isContactAuthorized = true
                } else {
                    isContactDenied = true
                }
            }
        }
    }
}
