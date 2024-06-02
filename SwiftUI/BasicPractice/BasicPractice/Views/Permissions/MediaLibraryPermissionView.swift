import SwiftUI
import MediaPlayer
import Photos

struct MediaLibraryPermissionView: View {
    @State private var isMediaLibraryAuthorized = false
    @State private var isMediaLibraryDenied = false
    
    var body: some View {
        VStack {
            if isMediaLibraryDenied {
                Text("Media library access denied. Please enable media library access in Settings.")
            } else if !isMediaLibraryAuthorized {
                Button(action: {
                    requestMediaLibraryPermission()
                }) {
                    Text("Request Media Library Access")
                }
            } else {
                Text("Media library access granted. You can now access media library.")
            }
        }
        .padding()
        .onAppear {
            checkMediaLibraryPermission()
        }
    }
    
    private func checkMediaLibraryPermission() {
        let mediaAuthorizationStatus = MPMediaLibrary.authorizationStatus()
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        if mediaAuthorizationStatus == .authorized && photoAuthorizationStatus == .authorized {
            isMediaLibraryAuthorized = true
        } else {
            isMediaLibraryDenied = true
        }
    }
    
    private func requestMediaLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { photoStatus in
            MPMediaLibrary.requestAuthorization { mediaStatus in
                DispatchQueue.main.async {
                    if photoStatus == .authorized && mediaStatus == .authorized {
                        isMediaLibraryAuthorized = true
                    } else {
                        isMediaLibraryDenied = true
                    }
                }
            }
        }
    }
}
