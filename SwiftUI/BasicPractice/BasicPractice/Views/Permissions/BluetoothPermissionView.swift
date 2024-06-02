import SwiftUI
import CoreBluetooth

struct BluetoothPermissionView: View {
    @State private var isBluetoothAvailable = false
    
    var body: some View {
        VStack {
            if isBluetoothAvailable {
                Text("Bluetooth is available on this device.")
            } else {
                Text("Bluetooth is not available on this device.")
            }
        }
        .padding()
        .onAppear {
            checkBluetoothAvailability()
        }
    }
    
    private func checkBluetoothAvailability() {
        if CBCentralManager().state == .poweredOn {
            isBluetoothAvailable = true
        } else {
            isBluetoothAvailable = false
        }
    }
}

