//
//  PickerView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct PickerView: View {
    @State private var selectedOption = 0
    var body: some View {
        Picker("Select an option", selection: $selectedOption) {
            Text("Option 1")
            Text("Option 2")
            Text("Option 3")
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
