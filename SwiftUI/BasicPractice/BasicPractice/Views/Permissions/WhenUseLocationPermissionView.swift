import SwiftUI
import CoreLocation

struct WhenUseLocationPermissionView: View {
    @State private var isLocationAuthorized = false
    @State private var isLocationDenied = false
    
    var body: some View {
        VStack {
            if isLocationDenied {
                Text("Location access denied. Please enable location access in Settings.")
            } else if !isLocationAuthorized {
                Button(action: {
                    requestLocationPermission()
                }) {
                    Text("Request Location Access")
                }
            } else {
                Text("Location access granted. You can now use location services.")
            }
        }
        .padding()
        .onAppear {
            checkLocationPermission()
        }
    }
    
    private func checkLocationPermission() {
        let locationManager = CLLocationManager()
        
        switch CLLocationManager().authorizationStatus {
        case .authorizedWhenInUse:
            isLocationAuthorized = true
        case .notDetermined:
            isLocationAuthorized = false
        case .denied, .restricted:
            isLocationDenied = true
        case .authorizedAlways:
            isLocationAuthorized = true
        @unknown default:
            break
        }
    }
    
    private func requestLocationPermission() {
        let locationManager = CLLocationManager()
        
        locationManager.requestWhenInUseAuthorization()
    }
}
