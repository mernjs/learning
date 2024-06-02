import SwiftUI
import Photos

struct PhotoLibraryPermissionView: View {
    @State private var isPhotoLibraryAuthorized = false
    @State private var isPhotoLibraryDenied = false
    
    var body: some View {
        VStack {
            if isPhotoLibraryDenied {
                Text("Photo library access denied. Please enable photo library access in Settings.")
            } else if !isPhotoLibraryAuthorized {
                Button(action: {
                    requestPhotoLibraryPermission()
                }) {
                    Text("Request Photo Library Access")
                }
            } else {
                Text("Photo library access granted. You can now access photos.")
            }
        }
        .padding()
        .onAppear {
            checkPhotoLibraryPermission()
        }
    }
    
    private func checkPhotoLibraryPermission() {
        let photoLibraryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoLibraryAuthorizationStatus {
        case .authorized:
            isPhotoLibraryAuthorized = true
        case .notDetermined:
            isPhotoLibraryAuthorized = false
        case .denied, .restricted:
            isPhotoLibraryDenied = true
        case .limited:
            isPhotoLibraryAuthorized = true
        @unknown default:
            break
        }
    }
    
    private func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    isPhotoLibraryAuthorized = true
                default:
                    isPhotoLibraryDenied = true
                }
            }
        }
    }
}
