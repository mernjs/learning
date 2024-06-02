//
//  ToggleView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct ToggleView: View {
    @State private var isOn = false
    
    var body: some View {
        Toggle("Toggle", isOn: $isOn)
                    .padding()
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
