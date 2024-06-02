import SwiftUI

struct SignupView: View {
    
    @StateObject var navigationState = NavigationState.shared
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    private var signupURL = ""
    private var apiKey = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()

            Button(action: {
                onSubmit()
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(isLoading)
            
            Button(action: {
                navigationState.navigate(to: .login)
            }) {
                Text("Login")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
    
    private func onSubmit() {
        guard let url = URL(string: signupURL) else {
            print("Invalid URL")
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        let parameters = SignupParameters(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            print("Error creating JSON data:", error.localizedDescription)
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            defer { isLoading = false }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No HTTP response")
                DispatchQueue.main.async {
                    errorMessage = "No HTTP response"
                }
                return
            }
            
            guard let data = data else {
                print("No data in response:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            if httpResponse.statusCode == 200 {
                handleSuccessResponse(data: data)
            } else {
                handleErrorResponse(data: data)
            }
        }.resume()
    }
    
    private func handleSuccessResponse(data: Data) {
        do {
            _ = try JSONDecoder().decode(SignupResponse.self, from: data)
            DispatchQueue.main.async {
                print("Redirect to dashboard")
            }
        } catch {
            print("Error decoding error message:", error.localizedDescription)
            print("Response data:", String(data: data, encoding: .utf8) ?? "Unable to decode data")
            DispatchQueue.main.async {
                errorMessage = "An unexpected error occurred"
            }
        }
    }
    
    private func handleErrorResponse(data: Data) {
        do {
            let errorResponse = try JSONDecoder().decode(ErrorMessageResponse.self, from: data)
            DispatchQueue.main.async {
                errorMessage = errorResponse.message
            }
        } catch {
            print("Error decoding error message:", error.localizedDescription)
            print("Response data:", String(data: data, encoding: .utf8) ?? "Unable to decode data")
            DispatchQueue.main.async {
                errorMessage = "An unexpected error occurred"
            }
        }
    }


}

struct SignupParameters: Codable {
    let email: String
    let password: String
}

struct SignupResponse: Codable {
    let data: UserDataResponse
}

struct ErrorMessageResponse: Codable {
    let message: String
}
