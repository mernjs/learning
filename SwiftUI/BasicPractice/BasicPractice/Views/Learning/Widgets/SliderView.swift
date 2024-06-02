//
//  SliderView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct SliderView: View {
    @State private var value = 50.0
    var body: some View {
        Slider(value: $value, in: 0...100, step: 1)
                   .padding()
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
