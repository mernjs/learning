import SwiftUI
import CoreLocation

struct LocationPermissionView: View {
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
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationAuthorized = true
        case .notDetermined:
            isLocationAuthorized = false
        case .denied, .restricted:
            isLocationDenied = true
        @unknown default:
            break
        }
    }
    
    private func requestLocationPermission() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
}
