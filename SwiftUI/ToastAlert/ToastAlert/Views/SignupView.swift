import SwiftUI

struct SignupView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SignupViewController {
        return SignupViewController()
    }
    
    func updateUIViewController(_ uiViewController: SignupViewController, context: Context) {
        // No updates needed for this example
    }
}
