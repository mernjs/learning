import SwiftUI
import HomeKit

class HomeKitPermissionManager: NSObject, ObservableObject, HMHomeManagerDelegate {
    @Published var isHomeKitAuthorized = false
    @Published var isHomeKitDenied = false
    private let homeManager = HMHomeManager()

    override init() {
        super.init()
        homeManager.delegate = self
        checkHomeKitPermission(homeManager)
    }

    func checkHomeKitPermission(_ manager: HMHomeManager) {
        DispatchQueue.main.async {
            if manager.authorizationStatus == .authorized {
                self.isHomeKitAuthorized = true
            } else {
                self.isHomeKitAuthorized = false
                self.isHomeKitDenied = true
            }
        }
    }

    func requestHomeKitPermission() {
        // Accessing the `homes` property triggers the authorization request.
        _ = homeManager.homes

        // The delegate method `homeManagerDidUpdateHomes` will handle the permission update.
    }

    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        checkHomeKitPermission(manager)
    }
}





struct HomeKitPermissionView: View {
    @ObservedObject var homeKitPermissionManager = HomeKitPermissionManager()

    var body: some View {
        VStack {
            if homeKitPermissionManager.isHomeKitDenied {
                Text("HomeKit access denied. Please enable HomeKit access in Settings.")
            } else if !homeKitPermissionManager.isHomeKitAuthorized {
                Button(action: {
                    homeKitPermissionManager.requestHomeKitPermission()
                }) {
                    Text("Request HomeKit Access")
                }
            } else {
                Text("HomeKit access granted. You can now access HomeKit data.")
            }
        }
        .padding()
    }
}
