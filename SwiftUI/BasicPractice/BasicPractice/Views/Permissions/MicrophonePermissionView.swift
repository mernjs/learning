import SwiftUI
import AVFoundation

struct MicrophonePermissionView: View {
    @State private var isMicrophoneAuthorized = false
    @State private var isMicrophoneDenied = false
    
    var body: some View {
        VStack {
            if isMicrophoneDenied {
                Text("Microphone access denied. Please enable microphone access in Settings.")
            } else if !isMicrophoneAuthorized {
                Button(action: {
                    requestMicrophonePermission()
                }) {
                    Text("Request Microphone Access")
                }
            } else {
                Text("Microphone access granted. You can now use the microphone.")
            }
        }
        .padding()
        .onAppear {
            checkMicrophonePermission()
        }
    }
    
    private func checkMicrophonePermission() {
        let microphoneAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        
        switch microphoneAuthorizationStatus {
        case .authorized:
            isMicrophoneAuthorized = true
        case .notDetermined:
            isMicrophoneAuthorized = false
        case .denied, .restricted:
            isMicrophoneDenied = true
        @unknown default:
            break
        }
    }
    
    private func requestMicrophonePermission() {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                if granted {
                    isMicrophoneAuthorized = true
                } else {
                    isMicrophoneDenied = true
                }
            }
        }
    }
}
