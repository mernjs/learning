//
//  AngularGradientView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct AngularGradientView: View {
    var body: some View {
        AngularGradient(gradient: Gradient(colors: [.red, .blue]), center: .center)
                   .frame(width: 200, height: 100)
    }
}

struct AngularGradientView_Previews: PreviewProvider {
    static var previews: some View {
        AngularGradientView()
    }
}
