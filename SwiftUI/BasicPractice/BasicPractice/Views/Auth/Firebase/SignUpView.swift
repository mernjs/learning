import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var agreeCheck: Bool = false
    @State private var errorText: String = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Sign Up")
            VStack(spacing: 10) {
                TextField("Email", text:  $emailAddress).textContentType(.emailAddress)
                SecureField("Password", text: $password)
                Toggle(isOn: $agreeCheck) {
                    Text("Agree to the Terms and Condition")
                        .fontWeight(.thin)
                }
                Button(action: signUp) {
                    Text("Sign Up")
                }
                Text(errorText)
                Spacer()
            }
            .padding(10)
        }
        .alert(isPresented: $showAlert, content: { self.alert })
    }
    
    private func signUp() {
        guard agreeCheck else {
            errorText = "Please Agree to the Terms and Condition"
            return
        }
        
        Auth.auth().createUser(withEmail: emailAddress, password: password) { authResult, error in
            if let error = error {
                errorText = error.localizedDescription
                return
            }
            
            Auth.auth().currentUser?.sendEmailVerification { error in
                if let error = error {
                    errorText = error.localizedDescription
                    return
                }
                showAlert.toggle()
            }
        }
    }
    
    private func resetFields() {
        emailAddress = ""
        password = ""
        agreeCheck = false
        errorText = ""
    }
    
    var alert: Alert {
        Alert(
            title: Text("Verify your Email ID"),
            message: Text("Please click the link in the verification email sent to you"),
            dismissButton: .default(Text("Dismiss")) {
                self.resetFields()
            }
        )
    }
    
}
