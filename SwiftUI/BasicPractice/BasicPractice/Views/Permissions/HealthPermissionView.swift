import SwiftUI
import HealthKit

struct HealthPermissionView: View {
    @State private var isHealthAuthorized = false
    @State private var isHealthDenied = false
    
    var body: some View {
        VStack {
            if isHealthDenied {
                Text("Health data access denied. Please enable health data access in Settings.")
            } else if !isHealthAuthorized {
                Button(action: {
                    requestHealthPermission()
                }) {
                    Text("Request Health Data Access")
                }
            } else {
                Text("Health data access granted. You can now access health data.")
            }
        }
        .padding()
        .onAppear {
            checkHealthPermission()
        }
    }
    
    private func checkHealthPermission() {
        let healthStore = HKHealthStore()
        
        if HKHealthStore.isHealthDataAvailable() {
            let typesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .heartRate)!]
            
            healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        isHealthAuthorized = true
                    } else {
                        isHealthDenied = true
                    }
                }
            }
        } else {
            isHealthDenied = true
        }
    }
    
    private func requestHealthPermission() {
        let healthStore = HKHealthStore()
        
        let typesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .heartRate)!]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            DispatchQueue.main.async {
                if success {
                    isHealthAuthorized = true
                } else {
                    isHealthDenied = true
                }
            }
        }
    }
}
