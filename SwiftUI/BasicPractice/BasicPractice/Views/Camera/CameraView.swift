import SwiftUI
import AVFoundation
import UIKit
import Photos


class CameraManager {
    var captureDevice: AVCaptureDevice?
    var captureSession: AVCaptureSession
    
    
    init() {
        self.captureDevice = AVCaptureDevice.default(for: .video)
        self.captureSession = AVCaptureSession()
        
    }
    
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completion(granted)
        }
    }
    
    func zoomIn() {
        guard let device = captureDevice else { return }
        do {
            try device.lockForConfiguration()
            let maxZoomFactor = device.activeFormat.videoMaxZoomFactor
            let newZoomFactor = min(maxZoomFactor, device.videoZoomFactor + 1)
            device.videoZoomFactor = newZoomFactor
            device.unlockForConfiguration()
        } catch {
            print("Error while zooming in:", error.localizedDescription)
        }
    }
    
    func zoomOut() {
        guard let device = captureDevice else { return }
        do {
            try device.lockForConfiguration()
            let newZoomFactor = max(1.0, device.videoZoomFactor - 1)
            device.videoZoomFactor = newZoomFactor
            device.unlockForConfiguration()
        } catch {
            print("Error while zooming out:", error.localizedDescription)
        }
    }
    
    func supportedModes() -> [AVCaptureDevice.FocusMode] {
        guard let device = captureDevice else { return [] }
        var supportedModes: [AVCaptureDevice.FocusMode] = []
        if device.isFocusModeSupported(.locked) {
            supportedModes.append(.locked)
        }
        if device.isFocusModeSupported(.autoFocus) {
            supportedModes.append(.autoFocus)
        }
        if device.isFocusModeSupported(.continuousAutoFocus) {
            supportedModes.append(.continuousAutoFocus)
        }
        return supportedModes
    }
    
    func supportedVideoQualities() -> [AVCaptureDevice.Format] {
        return captureDevice?.formats ?? []
    }
    
    func updateVideoQuality(_ newQuality: AVCaptureDevice.Format) {
        guard let device = captureDevice else { return }
        do {
            try device.lockForConfiguration()
            device.activeFormat = newQuality
            device.unlockForConfiguration()
        } catch {
            print("Error while updating video quality:", error.localizedDescription)
        }
    }
    
    func updateFocusMode(_ newFocusMode: AVCaptureDevice.FocusMode) {
        guard let device = captureDevice else { return }
        do {
            try device.lockForConfiguration()
            if device.isFocusModeSupported(newFocusMode) {
                device.focusMode = newFocusMode
            }
            device.unlockForConfiguration()
        } catch {
            print("Error while updating focus mode:", error.localizedDescription)
        }
    }
    
    func setISO(_ isoValue: Float) {
        guard let device = captureDevice else { return }
        do {
            try device.lockForConfiguration()
            let minISO = device.activeFormat.minISO
            let maxISO = device.activeFormat.maxISO
            let newISO = max(min(isoValue, maxISO), minISO)
            device.setExposureModeCustom(duration: AVCaptureDevice.currentExposureDuration, iso: newISO, completionHandler: nil)
            device.unlockForConfiguration()
        } catch {
            print("Error while setting ISO:", error.localizedDescription)
        }
    }

    func setShutterSpeed(_ shutterDuration: CMTime) {
        guard let device = captureDevice else { return }
        do {
            try device.lockForConfiguration()
            let maxShutterDuration = device.activeFormat.maxExposureDuration
            let minShutterDuration = device.activeFormat.minExposureDuration
            let newShutterDuration = CMTimeClampToRange(shutterDuration, range: CMTimeRange(start: minShutterDuration, duration: CMTimeSubtract(maxShutterDuration, minShutterDuration)))

            device.setExposureModeCustom(duration: newShutterDuration, iso: AVCaptureDevice.currentISO, completionHandler: nil)
            device.unlockForConfiguration()
        } catch {
            print("Error while setting shutter speed:", error.localizedDescription)
        }
    }

    func focus(at focusPoint: CGPoint) {
        guard let device = captureDevice else { return }
        do {
            try device.lockForConfiguration()
            if device.isFocusPointOfInterestSupported {
                device.focusPointOfInterest = focusPoint
                device.focusMode = .autoFocus
            }
            device.unlockForConfiguration()
        } catch {
            print("Error while focusing:", error.localizedDescription)
        }
    }

    
}



struct CameraPreview: UIViewControllerRepresentable {
    
    let cameraManager = CameraManager()

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()

        guard let captureDevice = cameraManager.captureDevice,
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            fatalError("Failed to get camera device or create input")
        }

        let captureSession = cameraManager.captureSession
        captureSession.addInput(input)

        DispatchQueue.global(qos: .background).async {
            captureSession.startRunning()
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = viewController.view.bounds

        DispatchQueue.main.async {
            viewController.view.layer.addSublayer(previewLayer)
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}


struct CameraView: View {
    @StateObject var navigationState = NavigationState.shared
    
    let cameraManager = CameraManager()
    @State private var isCameraAuthorized: Bool? = nil
    
    var body: some View {
        VStack {
            if let isCameraAuthorized = isCameraAuthorized {
                if isCameraAuthorized {
                    CameraPreview()
                        .overlay(
                            MenuButtons()
                                .padding(.top, 10)
                        )
                } else {
                    Text("Camera access is not granted. Please grant access in Settings.")
                }
            } else {
                Text("Checking camera permission...")
                    .padding()
            }
        }
        .onAppear {
            cameraManager.requestCameraPermission { granted in
                isCameraAuthorized = granted
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}



struct MenuButtons: View {
    let cameraManager = CameraManager()
    
    var body: some View {
        VStack {
            Button("Zoom In") {
                cameraManager.zoomIn()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button("Zoom Out") {
                cameraManager.zoomOut()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            FocusModeMenu(items: cameraManager.supportedModes()) { newFocusMode in
                cameraManager.updateFocusMode(newFocusMode)
            }
            
            VideoQualityMenu(items: cameraManager.supportedVideoQualities()) { newQuality in
                cameraManager.updateVideoQuality(newQuality)
            }
        }
    }
}

struct FocusModeMenu: View {
    let items: [AVCaptureDevice.FocusMode]
    let action: (AVCaptureDevice.FocusMode) -> Void
    
    var body: some View {
        Menu {
            ForEach(items, id: \.self) { item in
                Button(action: {
                    action(item)
                }) {
                    Text("\(item.rawValue)")
                }
            }
        } label: {
            Label("Select Focus Mode", systemImage: "arrowtriangle.down.square")
                .padding()
        }
    }
}

struct VideoQualityMenu: View {
    let items: [AVCaptureDevice.Format]
    let action: (AVCaptureDevice.Format) -> Void
    
    var body: some View {
        Menu {
            ForEach(items, id: \.self) { item in
                Button(action: {
                    action(item)
                }) {
                    Text(formatDescription(for: item))
                }
            }
        } label: {
            Label("Video Quality", systemImage: "arrowtriangle.down.square")
                .padding()
        }
    }
    
    func formatDescription(for format: AVCaptureDevice.Format) -> String {
        let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
        let fps = Int(format.videoSupportedFrameRateRanges.first?.maxFrameRate ?? 0)
        return "\(dimensions.width) x \(dimensions.height) - \(fps) fps"
    }
}
