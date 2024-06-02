//
//  ZStackView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct ZStackView: View {
    var body: some View {
        ZStack {
                    Text("Back")
                        .foregroundColor(.blue)
                    Text("Front")
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
    }
}

struct ZStackView_Previews: PreviewProvider {
    static var previews: some View {
        ZStackView()
    }
}
