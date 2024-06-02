import SwiftUI
import AVFoundation

struct CameraPermissionView: View {
    @State private var isCameraAuthorized = false
    @State private var isCameraDenied = false
    
    var body: some View {
        VStack {
            if isCameraDenied {
                Text("Camera access denied. Please enable camera access in Settings.")
            } else if !isCameraAuthorized {
                Button(action: {
                    requestCameraPermission()
                }) {
                    Text("Request Camera Access")
                }
            } else {
                Text("Camera access granted. You can now use the camera.")
            }
        }
        .padding()
        .onAppear {
            checkCameraPermission()
        }
    }
    
    private func checkCameraPermission() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .authorized:
            isCameraAuthorized = true
        case .notDetermined:
            isCameraAuthorized = false
        case .denied, .restricted:
            isCameraDenied = true
        @unknown default:
            break
        }
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    isCameraAuthorized = true
                } else {
                    isCameraDenied = true
                }
            }
        }
    }
}
