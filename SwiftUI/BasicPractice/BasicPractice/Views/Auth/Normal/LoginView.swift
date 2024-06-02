import SwiftUI
import Foundation

struct SavedUserData: Codable {
    let email: String
    let firstName: String
    let lastName: String
    let token: String
}

class AuthService: ObservableObject {
    static let shared = AuthService()
    private let apiKey = ""
    private let loginURL = ""
    
    @Published var isLoading = false
    
    func login(email: String, password: String, completion: @escaping (Result<SavedUserData, Error>) -> Void) {
        isLoading = true
        
        guard let url = URL(string: loginURL) else {
            completion(.failure(NetworkError.invalidURL))
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
                completion(.failure(NetworkError.noHTTPResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(error ?? NetworkError.unknown))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    let userData = response.data.user
                    self.saveUserData(userData)
                    completion(.success(userData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    completion(.failure(NetworkError.serverError(errorResponse.message)))
                } catch {
                    completion(.failure(NetworkError.invalidJSON))
                }
            }
        }.resume()
    }
    
    private func saveUserData(_ userData: SavedUserData) {
        if let encodedData = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(encodedData, forKey: "SavedUserData")
        }
    }
}

struct LoginResponse: Codable {
    let data: UserDataResponse
}

struct UserDataResponse: Codable {
    let user: SavedUserData
}

struct ErrorResponse: Codable {
    let message: String
}

enum NetworkError: Error {
    case invalidURL
    case noHTTPResponse
    case serverError(String)
    case invalidJSON
    case unknown
}

struct LoginView: View {
    
    @StateObject var navigationState = NavigationState.shared

    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @ObservedObject private var authService = AuthService.shared
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text(errorMessage)
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
        errorMessage = ""
        
        authService.login(email: email, password: password) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    navigationState.replace(with: .dashboard)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
