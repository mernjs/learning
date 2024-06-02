//
//  StepperView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct StepperView: View {
    @State private var value = 0
    
    var body: some View {
        Stepper("Value: \(value)", value: $value, in: 0...10)
                    .padding()
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView()
    }
}
