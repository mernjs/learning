//
//  ListView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List {
                    Text("Item 1")
                        .foregroundColor(.blue)
                    Text("Item 2")
                        .foregroundColor(.green)
                    Text("Item 3")
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
