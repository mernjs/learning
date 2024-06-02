import SwiftUI
import Combine

enum NavigationViewState: Hashable {
    case splash, login, signup, dashboard, camera
}

struct ContentView: View {
    @StateObject var navigationState = NavigationState.shared

    var body: some View {
        NavigationStack(path: $navigationState.navigationPath) {
            content
            .navigationDestination(for: NavigationViewState.self) { state in
                navigationDestination(for: state)
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch navigationState.currentNavigationState {
        case .splash:
            SplashView()
        case .login:
            LoginView()
        case .signup:
            SignupView()
        case .dashboard:
            DashboardView()
       
        default:
            VStack(){
                
            }
            
        }
    }

    @ViewBuilder
    private func navigationDestination(for state: NavigationViewState) -> some View {
        switch state {
        case .splash:
            SplashView()
        case .login:
            LoginView()
        case .signup:
            SignupView()
        case .dashboard:
            DashboardView()
        case .camera:
            CameraView()
        }
    }
}

class NavigationState: ObservableObject {
    
    private init(){}
    
    static var shared = NavigationState()
    
    @Published var navigationPath = NavigationPath()
    @Published var currentNavigationState: NavigationViewState = .signup

    func replace(with state: NavigationViewState) {
        currentNavigationState = state
    }

    func navigate(to state: NavigationViewState) {
        navigationPath.append(state)
    }
}
