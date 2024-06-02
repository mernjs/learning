//
//  EllipseView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct EllipseView: View {
    var body: some View {
        Ellipse()
                   .frame(width: 200, height: 100)
                   .foregroundColor(.orange)
    }
}

struct EllipseView_Previews: PreviewProvider {
    static var previews: some View {
        EllipseView()
    }
}
