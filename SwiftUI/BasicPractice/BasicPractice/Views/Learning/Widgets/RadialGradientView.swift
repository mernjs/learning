//
//  RadialGradientView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct RadialGradientView: View {
    var body: some View {
        RadialGradient(gradient: Gradient(colors: [.red, .blue]), center: .center, startRadius: 0, endRadius: 100)
                    .frame(width: 200, height: 100)
    }
}

struct RadialGradientView_Previews: PreviewProvider {
    static var previews: some View {
        RadialGradientView()
    }
}
