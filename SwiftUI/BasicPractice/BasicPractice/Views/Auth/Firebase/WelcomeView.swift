import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Home")
            Spacer()
            Text("Hello World!")
            Spacer()
            SignOutButton()
        }
    }
}
