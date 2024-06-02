import SwiftUI
import AVKit

struct CustomVideoPlayerView: View {
    @State private var isPlaying = false
    @State private var currentTime: Double = 0
    @State private var totalTime: Double = 0
    @State private var isSliderDragging = false
    
    let player = AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear {
                    player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { time in
                        currentTime = time.seconds
                        totalTime = player.currentItem?.duration.seconds ?? 0
                    }
                }
            
            HStack {
                Button(action: {
                    isPlaying ? player.pause() : player.play()
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
                .padding()
                
                Slider(value: Binding<Double>(
                    get: { currentTime },
                    set: { newTime in
                        currentTime = newTime
                        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
                    }
                ), in: 0...totalTime, onEditingChanged: { editing in
                    isSliderDragging = editing
                })
                    .accentColor(.red)
                    .disabled(totalTime == 0)
                
                Text("\(Int(currentTime)) / \(Int(totalTime))")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding()
        }
        .onReceive(timer) { _ in
            if !isSliderDragging {
                currentTime = player.currentTime().seconds
            }
        }
    }
}
