//
//  LazyHGridView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct LazyHGridView: View {
    var body: some View {
        LazyHGrid(rows: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]) {
            ForEach(0..<9) { index in
                Text("Item \(index)")
            }
        }

    }
}

struct LazyHGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyHGridView()
    }
}
