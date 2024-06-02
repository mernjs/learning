import SwiftUI

struct CarouselSliderView: View {
    @State private var currentIndex = 0
    let images = ["house.fill", "heart.fill", "person.fill", "star.fill"] // System image names
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count) { index in
                    Image(systemName: images[index])
                        .resizable()
                        .scaledToFit()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            HStack {
                Button(action: {
                    currentIndex = max(currentIndex - 1, 0)
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
                .padding(.leading)
                
                Spacer()
                
                Button(action: {
                    currentIndex = min(currentIndex + 1, images.count - 1)
                }) {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
            }
        }
        .padding()
    }
}
