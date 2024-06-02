//
//  RoundedRectangleView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct RoundedRectangleView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
                   .frame(width: 200, height: 100)
                   .foregroundColor(.blue)
    }
}

struct RoundedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleView()
    }
}
