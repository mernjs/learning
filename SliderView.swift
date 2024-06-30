import SwiftUI
import SlidingRuler

struct SliderView: View {
    @State private var value: Double = 0
    
    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.maximumFractionDigits = 0
        return f
    }
    
    var body: some View {
        HStack {
            SlidingRuler(
                value: $value,
                in: 0...1,
                step: 0.1,
                snap: .fraction,
                tick: .fraction,
                formatter: formatter
            )
        }
        .padding(15)
        .background(Color.black.opacity(0.5))
        .foregroundStyle(.white)
    }
}
