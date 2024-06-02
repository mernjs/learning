import SwiftUI
import Firebase

struct SignOutButton: View {
    @StateObject var navigationState = NavigationState.shared
    var body: some View {
        Button(action: signOut) {
            Text("Sign Out")
                .foregroundColor(Color.white)
                .padding()
        }
        .background(Color.green)
        .cornerRadius(5)
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationState.replace(with: .login)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
