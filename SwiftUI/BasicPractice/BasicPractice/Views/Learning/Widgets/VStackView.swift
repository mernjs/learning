//
//  VStackView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct VStackView: View {
    var body: some View {
        VStack {
                    Text("First")
                        .foregroundColor(.blue)
                    Text("Second")
                        .foregroundColor(.green)
                    Text("Third")
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
    }
}

struct VStackView_Previews: PreviewProvider {
    static var previews: some View {
        VStackView()
    }
}
