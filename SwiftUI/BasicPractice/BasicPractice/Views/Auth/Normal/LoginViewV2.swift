import SwiftUI
import Foundation

struct SavedUserDataV2: Codable {
    let email: String
    let firstName: String
    let lastName: String
    let token: String
}

class AuthServiceV2: ObservableObject {
    static let shared = AuthServiceV2()
    private let apiKey = ""
    private let loginURL = ""
    
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    func updateEmail(_ newEmail: String) {
        self.email = newEmail
    }
    
    func updatePassword(_ newPassword: String) {
        self.password = newPassword
    }
    
    func updateErrorMessage(_ newErrorMessage: String) {
        self.errorMessage = newErrorMessage
    }
    
    func login(email: String, password: String, completion: @escaping (Result<SavedUserDataV2, Error>) -> Void) {
        isLoading = true
        
        guard let url = URL(string: loginURL) else {
            completion(.failure(NetworkErrorV2.invalidURL))
            isLoading = false
            return
        }
        
        let parameters = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: ["user": parameters])
        } catch {
            completion(.failure(error))
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            defer { self.isLoading = false }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkErrorV2.noHTTPResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(error ?? NetworkErrorV2.unknown))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let response = try JSONDecoder().decode(LoginResponseV2.self, from: data)
                    let userData = response.data.user
                    self.saveUserData (userData)
                    completion(.success(userData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    completion(.failure(NetworkErrorV2.serverError(errorResponse.message)))
                } catch {
                    completion(.failure(NetworkErrorV2.invalidJSON))
                }
            }
        }.resume()
    }
    
    private func saveUserData(_ userData: SavedUserDataV2) {
        if let encodedData = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(encodedData, forKey: "SavedUserData")
        }
    }
}

struct LoginResponseV2: Codable {
    let data: UserDataResponseV2
}

struct UserDataResponseV2: Codable {
    let user: SavedUserDataV2
}

struct ErrorResponseV2: Codable {
    let message: String
}

enum NetworkErrorV2: Error {
    case invalidURL
    case noHTTPResponse
    case serverError(String)
    case invalidJSON
    case unknown
}

struct LoginViewV2: View {
    
    @StateObject var navigationState = NavigationState.shared
    
    @ObservedObject private var authService = AuthServiceV2.shared
    
    var body: some View {
        VStack {
            TextField("Email", text: $authService.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $authService.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text(authService.errorMessage)
                .foregroundColor(.red)
                .padding()
            
            Button(action: {
                onSubmit()
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(authService.isLoading)
            
            Button(action: {
                navigationState.navigate(to: .signup)
            }) {
                Text("Sign Up")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .onReceive(authService.$isLoading) { loading in
            // Handle loading state changes if needed
        }
    }
    
    func onSubmit() {
        authService.errorMessage = ""
        
        authService.login(email: authService.email, password: authService.password) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    navigationState.replace(with: .dashboard)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    authService.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
