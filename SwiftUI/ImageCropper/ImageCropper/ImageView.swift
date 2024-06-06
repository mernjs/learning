import SwiftUI
import Mantis

struct ImageView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> CropViewController {
        var config = Mantis.Config()
        config.cropShapeType = .square
        config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1.0)
        config.showRotationDial = true
        let cropViewController = Mantis.cropViewController(image: image ?? UIImage(), config: config)
        cropViewController.delegate = context.coordinator
        return cropViewController
    }

    func updateUIViewController(_ uiViewController: CropViewController, context: Context) {
        // No update needed
    }

    class Coordinator: NSObject, CropViewControllerDelegate {
        var parent: ImageView

        init(_ parent: ImageView) {
            self.parent = parent
        }

        func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage) {
            parent.image = cropped
            parent.isPresented = false
        }

        func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
            parent.isPresented = false
        }

        func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
            parent.image = cropped
            parent.isPresented = false
        }

        func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
            parent.image = cropped
            parent.isPresented = false
        }

        func cropViewControllerDidFailToCrop(_ cropViewController: Mantis.CropViewController, original: UIImage) {
            parent.isPresented = false
        }

        func cropViewControllerDidBeginResize(_ cropViewController: Mantis.CropViewController) {
            // Optional: handle begin resize if needed
        }

        func cropViewControllerDidEndResize(_ cropViewController: Mantis.CropViewController, original: UIImage, cropInfo: Mantis.CropInfo) {
            // Optional: handle end resize if needed
        }
    }
}
