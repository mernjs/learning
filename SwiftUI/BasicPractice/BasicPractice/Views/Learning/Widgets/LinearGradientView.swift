//
//  LinearGradientView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct LinearGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing)
                   .frame(width: 200, height: 100)
    }
}

struct LinearGradientView_Previews: PreviewProvider {
    static var previews: some View {
        LinearGradientView()
    }
}
