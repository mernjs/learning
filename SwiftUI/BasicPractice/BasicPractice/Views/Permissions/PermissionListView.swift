import SwiftUI

struct PermissionListView: View {
    var body: some View {
        ScrollView{
            VStack {
                Group {
                    CameraPermissionView()
                    MicrophonePermissionView()
                    PhotoLibraryPermissionView()
                    LocationPermissionView()
                    MotionPermissionView()
                }
                Group {
                    BluetoothPermissionView()
                    CalendarPermissionView()
                    RemindersPermissionView()
                    //HealthPermissionView()
                    HomeKitPermissionView()
                }
                Group {
                    MediaLibraryPermissionView()
                    SpeechPermissionView()
                    AlwaysLocationPermissionView()
                    WhenUseLocationPermissionView()
                }
            }
        }
    }
}
