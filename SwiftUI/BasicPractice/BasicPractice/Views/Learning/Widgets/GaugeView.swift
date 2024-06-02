//
//  GaugeView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct GaugeView: View {
    @State private var value = 75.0
    var body: some View {
        Gauge(value: value, in: 0...100) {
            Text("Gauge")
        } currentValueLabel: {
            Text("\(Int(value))")
        }

    }
}

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeView()
    }
}
