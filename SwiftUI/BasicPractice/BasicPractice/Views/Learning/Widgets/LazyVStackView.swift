//
//  LazyVStackView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct LazyVStackView: View {
    var body: some View {
        LazyVStack {
            ForEach(0..<50) { index in
                Text("Item \(index)")
            }
        }
    }
}

struct LazyVStackView_Previews: PreviewProvider {
    static var previews: some View {
        LazyVStackView()
    }
}
