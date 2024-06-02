import SwiftUI
import Firebase

struct HomeView: View {
    
    var body: some View {
        ZStack{
            if Auth.auth().currentUser != nil {
                DashboardView()
            } else {
                SignInSignUpButtonView()
            }
        }
    }
}
