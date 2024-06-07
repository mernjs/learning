import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var filterType: FilterType = .cinematic
    
    let context = CIContext()
    
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No image selected")
                    .foregroundColor(.gray)
                    .padding()
            }
            
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
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        print("Loaded input image")
    }
    
    func applyFilter() {
        guard let inputImage = inputImage else {
            print("No input image available")
            return
        }
        guard let ciImage = CIImage(image: inputImage) else {
            print("Failed to create CIImage from input image")
            return
        }
        
        let lutImageName: String
        
        switch filterType {
        case .cinematic:
            lutImageName = "KFLUT-Cinematic"
        case .deepSea:
            lutImageName = "KFLUT-Deep-Sea"
        case .goldenGlow:
            lutImageName = "KFLUT-Golden-Glow"
        case .lushGreen:
            lutImageName = "KFLUT-Lush-Green"
        case .oceanBlue:
            lutImageName = "KFLUT-Ocean-Blue"
        }
        
        guard let lutUIImage = UIImage(named: lutImageName) else {
            print("Failed to load LUT image named \(lutImageName)")
            return
        }
        
        guard let lutCIImage = CIImage(image: lutUIImage) else {
            print("Failed to create CIImage from LUT UIImage")
            return
        }
        
        guard let cubeData = createCubeData(from: lutCIImage, dimension: 64) else {
            print("Failed to create cube data from LUT image")
            return
        }
        
        let filter = CIFilter.colorCube()
        filter.inputImage = ciImage
        filter.cubeDimension = 64
        filter.cubeData = cubeData
        
        guard let outputImage = filter.outputImage else {
            print("Failed to generate output image from filter")
            return
        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            print("Success to create CGImage from output image")
            image = Image(uiImage: uiImage)
            print("Updated image state with filtered image", image)
            
            // Force UI update
            DispatchQueue.main.async {
                // Ensure image is not nil
                guard image != nil else {
                    print("Image is nil after applying filter")
                    return
                }
                print("Forcing UI update")
            }
        } else {
            print("Failed to create CGImage from output image")
        }
    }
    
    func createCubeData(from image: CIImage, dimension: Int) -> Data? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var bitmap = [Float](repeating: 0, count: dimension * dimension * dimension * 4)
        let context = CIContext(options: [.workingColorSpace: colorSpace])
        
        let extent = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        context.render(image,
                       toBitmap: &bitmap,
                       rowBytes: dimension * 4 * MemoryLayout<Float>.size,
                       bounds: extent,
                       format: .RGBAh,
                       colorSpace: colorSpace)
        
        var data = [Float]()
        for z in 0 ..< dimension {
            for y in 0 ..< dimension {
                for x in 0 ..< dimension {
                    let offset = (z * dimension * dimension + y * dimension + x) * 4
                    data.append(bitmap[offset])
                    data.append(bitmap[offset + 1])
                    data.append(bitmap[offset + 2])
                    data.append(bitmap[offset + 3])
                }
            }
        }
        
        return Data(buffer: UnsafeBufferPointer(start: data, count: data.count))
    }
}

struct ImagePicker: UIViewControllerRepresentable {
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
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
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

enum FilterType: String, CaseIterable, Identifiable {
    case cinematic
    case deepSea
    case goldenGlow
    case lushGreen
    case oceanBlue
    
    var id: String { self.rawValue }
}
