import SwiftUI
import Foundation

struct SavedUserDataUpdated: Codable {
    let email: String
    let firstName: String
    let lastName: String
    let token: String
}

struct DashboardView: View {
    
    @StateObject var navigationState = NavigationState.shared
    
    @State private var savedUserDataUpdated: SavedUserDataUpdated?
    
    private let savedUserDataKey = "SavedUserData"
    
//    init(currentView: Binding<ContentView.Views>) {
//            _currentView = currentView
//            loadSavedUserData()
//        }
    
    var body: some View {
        VStack {
            
            if let userData = savedUserDataUpdated {
                Text("Email: \(userData.email)")
                Text("First Name: \(userData.firstName)")
                Text("Last Name: \(userData.lastName)")
            }

            Button(action: {
                logout()
            }) {
                Text("Logout")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()

        }
    }
    
    private func loadSavedUserData() {
        guard let savedData = UserDefaults.standard.data(forKey: savedUserDataKey) else { return }
        do {
            let userData = try JSONDecoder().decode(SavedUserDataUpdated.self, from: savedData)
            savedUserDataUpdated = userData
        } catch {
            print("Error decoding user data:", error)
        }
    }
    
    private func logout() {
        UserDefaults.standard.removeObject(forKey: savedUserDataKey)
        navigationState.replace(with: .login)
    }
}
