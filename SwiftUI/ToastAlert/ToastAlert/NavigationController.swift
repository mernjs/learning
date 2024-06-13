import SwiftUI

class NavigationController: ObservableObject {
    let loginViewController = LoginViewController()
    let signupViewController = SignupViewController()
    let navigationController = UINavigationController()
    
    init() {
        navigationController.viewControllers = [loginViewController]
    }
}
