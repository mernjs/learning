//
//  HStackView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct HStackView: View {
    var body: some View {
        HStack {
                    Text("Left")
                        .foregroundColor(.blue)
                    Text("Center")
                        .foregroundColor(.green)
                    Text("Right")
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
    }
}

struct HStackView_Previews: PreviewProvider {
    static var previews: some View {
        HStackView()
    }
}
