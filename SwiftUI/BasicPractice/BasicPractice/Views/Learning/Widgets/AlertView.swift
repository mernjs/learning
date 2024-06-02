//
//  AlertView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct AlertView: View {
    @State private var showAlert = false
    var body: some View {
        Button(action: {
            showAlert = true
        }) {
            Text("Show Alert")
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Important Message"),
                  message: Text("This is an important alert."),
                  dismissButton: .default(Text("OK")))
        }

    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
