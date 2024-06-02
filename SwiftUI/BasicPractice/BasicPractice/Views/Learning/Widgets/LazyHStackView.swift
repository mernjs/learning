//
//  LazyHStackView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct LazyHStackView: View {
    var body: some View {
        LazyHStack() {
            ForEach(0..<50) { index in
                Text("Item \(index)")
            }
        }
    }
}

struct LazyHStackView_Previews: PreviewProvider {
    static var previews: some View {
        LazyHStackView()
    }
}
