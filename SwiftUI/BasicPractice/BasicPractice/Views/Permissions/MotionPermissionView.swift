import SwiftUI
import CoreMotion

struct MotionPermissionView: View {
    @State private var isMotionAuthorized = false
    @State private var isMotionDenied = false
    
    var body: some View {
        VStack {
            if isMotionDenied {
                Text("Motion & Fitness access denied. This device does not support motion tracking or motion access is denied.")
            } else if !isMotionAuthorized {
                Text("Motion & Fitness access not required. This device does not support motion tracking or motion access is not required.")
            } else {
                Text("Motion & Fitness access granted. You can now access motion and fitness data.")
            }
        }
        .padding()
        .onAppear {
            checkMotionPermission()
        }
    }
    
    private func checkMotionPermission() {
        let motionManager = CMMotionActivityManager()
        
        if CMMotionActivityManager.isActivityAvailable() {
            isMotionAuthorized = true
        } else {
            isMotionDenied = true
        }
    }
}
