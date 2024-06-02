import SwiftUI
import Speech

struct SpeechPermissionView: View {
    @State private var isSpeechAuthorized = false
    @State private var isSpeechDenied = false
    
    var body: some View {
        VStack {
            if isSpeechDenied {
                Text("Speech recognition access denied. Please enable speech recognition access in Settings.")
            } else if !isSpeechAuthorized {
                Button(action: {
                    requestSpeechPermission()
                }) {
                    Text("Request Speech Recognition Access")
                }
            } else {
                Text("Speech recognition access granted. You can now use speech recognition.")
            }
        }
        .padding()
        .onAppear {
            checkSpeechPermission()
        }
    }
    
    private func checkSpeechPermission() {
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US")) // Specify the desired locale
        
        // Check if speech recognition is available and authorized
        if speechRecognizer != nil {
            SFSpeechRecognizer.requestAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        isSpeechAuthorized = true
                    default:
                        isSpeechDenied = true
                    }
                }
            }
        } else {
            // Speech recognition is not available
            isSpeechDenied = true
        }
    }
    
    private func requestSpeechPermission() {
        // Not needed since requestAuthorization is called in checkSpeechPermission
    }
}
