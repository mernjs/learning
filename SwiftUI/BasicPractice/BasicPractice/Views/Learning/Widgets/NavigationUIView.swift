//
//  NavigationUIView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct NavigationUIView: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .navigationBarTitle("Title")
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
        }
    }
}

struct NavigationUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationUIView()
    }
}
