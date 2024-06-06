import SwiftUI

struct ContentView: View {
    @State private var image: UIImage? = UIImage(named: "example")
    @State private var isCropping = false

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Text("No Image")
            }

            Button("Crop Image") {
                isCropping = true
            }
            .sheet(isPresented: $isCropping) {
                ImageCropperView(image: $image, isPresented: $isCropping)
            }
        }
    }
}
