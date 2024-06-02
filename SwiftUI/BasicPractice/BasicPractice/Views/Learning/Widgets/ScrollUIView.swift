//
//  ScrollUIView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct ScrollUIView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<50) { index in
                        Text("Item \(index)")
                    }
                }
    }
}

struct ScrollUIView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollUIView()
    }
}
