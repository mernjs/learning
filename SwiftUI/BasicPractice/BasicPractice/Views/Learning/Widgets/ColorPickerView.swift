//
//  ColorPickerView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct ColorPickerView: View {
    @State private var selectedColor = Color.blue
    var body: some View {
        ColorPicker("Select color", selection: $selectedColor)
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}
