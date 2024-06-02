import SwiftUI
import Firebase

struct SignInView: View {
    
    @StateObject var navigationState = NavigationState.shared
    
    @Binding var isPresented: Bool
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var verifyEmail: Bool = true
    @State private var errorText: String = ""
    @State private var showEmailAlert = false
    @State private var showPasswordAlert = false
    
    var body: some View {
        VStack {
            Text("Sign In")
            VStack(spacing: 10) {
                
                TextField("Email", text:  $emailAddress).textContentType(.emailAddress)
                SecureField("Password", text: $password)
                
                Button(action: signIn) {
                    Text("Sign In")
                }
                
                Button(action: resetPassword) {
                    Text("Forgot Password")
                }
                
                Text(errorText)
                    
                if !verifyEmail {
                    Button(action: sendVerificationEmail) {
                        Text("Send Verify Email Again")
                    }
                }
            }
            .padding(10)
        }
        .alert(isPresented: $showEmailAlert, content: { verifyEmailAlert })
        .alert(isPresented: $showPasswordAlert, content: { passwordResetAlert })
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: emailAddress, password: password) { user, error in
            if let error = error {
                self.errorText = error.localizedDescription
                return
            }
            
            guard let user = user else { return }
            
            self.verifyEmail = user.user.isEmailVerified
            
            if !self.verifyEmail {
                self.errorText = "Please verify your email"
                return
            }
           self.resetStates()
           self.isPresented = false // Dismiss the sheet
            navigationState.replace(with: .dashboard)
        }
    }
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: emailAddress) { error in
            if let error = error {
                self.errorText = error.localizedDescription
                return
            }
            self.showPasswordAlert.toggle()
        }
    }
    
    func sendVerificationEmail() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                self.errorText = error.localizedDescription
                return
            }
            self.showEmailAlert.toggle()
        }
    }
    
    func resetStates() {
        emailAddress = ""
        password = ""
        verifyEmail = true
        errorText = ""
    }
    
    var verifyEmailAlert: Alert {
        Alert(
            title: Text("Verify your Email ID"),
            message: Text("Please click the link in the verification email sent to you"),
            dismissButton: .default(Text("Dismiss")) {
                self.resetStates()
            }
        )
    }
    
    var passwordResetAlert: Alert {
        Alert(
            title: Text("Reset your password"),
            message: Text("Please click the link in the password reset email sent to you"),
            dismissButton: .default(Text("Dismiss")) {
                self.resetStates()
            }
        )
    }
}
