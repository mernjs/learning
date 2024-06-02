//
//  CircleView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct CircleView: View {
    var body: some View {
        Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
