//
//  SpacerView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct SpacerView: View {
    var body: some View {
        VStack {
                    Text("Top")
                        .foregroundColor(.blue)
                    Spacer()
                    Text("Bottom")
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
    }
}

struct VStackSpacerView_Previews: PreviewProvider {
    static var previews: some View {
        SpacerView()
    }
}
