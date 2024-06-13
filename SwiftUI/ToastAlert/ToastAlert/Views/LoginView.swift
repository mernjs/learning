import SwiftUI

struct LoginView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LoginViewController {
        return LoginViewController()
    }
    
    func updateUIViewController(_ uiLoginViewController: LoginViewController, context: Context) {
        // No updates needed for this example
    }
}
