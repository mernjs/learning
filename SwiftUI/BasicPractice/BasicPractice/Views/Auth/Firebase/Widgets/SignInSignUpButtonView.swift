import SwiftUI

struct SignInSignUpButtonView: View {
    @State private var signUpIsPresent: Bool = false
    @State private var signInIsPresent: Bool = false
    //https://chat.openai.com/c/db1fa78f-6264-4645-a17f-0b4f199e5f48
    
    var body: some View {
        VStack {
            Text("Welcome")
            Spacer()
            VStack(spacing:20) {
                Button(action: { self.signUpIsPresent = true }) {
                    Text("Sign Up")
                }
                Button(action: { self.signInIsPresent = true }) {
                    Text("Sign In")
                }
            }
            Spacer()
        }
        .sheet(isPresented: $signUpIsPresent) {
            SignUpView()
        }
        .sheet(isPresented: $signInIsPresent) {
            SignInView(isPresented: $signInIsPresent)
        }
    }
}
