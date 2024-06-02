//
//  ButtonView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Button(action: {
                   // Button action
               }) {
                   Text("Tap me")
                       .foregroundColor(.white)
                                       .padding()
                                       .background(Color.blue)
                                       .cornerRadius(10)
               }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
