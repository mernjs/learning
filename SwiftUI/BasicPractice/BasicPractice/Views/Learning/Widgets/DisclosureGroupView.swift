//
//  DisclosureGroupView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct DisclosureGroupView: View {
    var body: some View {
        DisclosureGroup("Show More Details") {
            Text("Additional details go here")
        }
        DisclosureGroup {
            Text("Content inside the DisclosureTriangle")
        } label: {
            Text("Show/Hide")
        }
    }
}

struct DisclosureGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureGroupView()
    }
}
