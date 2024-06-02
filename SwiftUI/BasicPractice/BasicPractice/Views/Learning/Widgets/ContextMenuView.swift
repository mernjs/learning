//
//  ContextMenuView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct ContextMenuView: View {
    var body: some View {
        Text("Long press me")
            .contextMenu {
                Button(action: { /* action for first option */ }) {
                    Text("First Option")
                }
                Button(action: { /* action for second option */ }) {
                    Text("Second Option")
                }
            }
    }
}

struct ContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuView()
    }
}
