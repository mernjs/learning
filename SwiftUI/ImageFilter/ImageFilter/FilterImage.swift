import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct FilterImage: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var filterType: ImageFilterType = .cinematic
    
    let context = CIContext()
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            HStack {
                Button("Select Image") {
                    showingImagePicker = true
                }
                .padding()
                
                Button("Apply Filter") {
                    applyFilter()
                }
                .padding()
            }
            
            Picker("Filter Type", selection: $filterType) {
                ForEach(FilterType.allCases) { filter in
                    Text(filter.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePickerView(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    
    func applyFilter() {
        guard let inputImage = inputImage else { return }
        guard let ciImage = CIImage(image: inputImage) else { return }
        
        let filter = CIFilter.colorControls()
        filter.inputImage = ciImage
        
        switch filterType {
        case .cinematic:
            filter.saturation = 1.2
            filter.contrast = 1.5
        case .deepSea:
            filter.saturation = 1.3
            filter.brightness = -0.1
        case .goldenGlow:
            filter.saturation = 1.1
            filter.brightness = 0.2
        case .lushGreen:
            filter.saturation = 1.4
            filter.brightness = 0.1
        case .oceanBlue:
            filter.saturation = 1.2
            filter.brightness = -0.05
        }
        
        guard let outputImage = filter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    
    
    
}





struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            picker.dismiss(animated: true)
        }
    }
}

enum ImageFilterType: String, CaseIterable, Identifiable {
    case cinematic
    case deepSea
    case goldenGlow
    case lushGreen
    case oceanBlue
    
    var id: String { self.rawValue }
}
