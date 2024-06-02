//
//  ProgressUIView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct ProgressUIView: View {
    var body: some View {
        ProgressView("Loading...", value: 50, total: 100)
    }
}

struct ProgressUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressUIView()
    }
}
