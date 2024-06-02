//
//  GroupUIView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct GroupUIView: View {
    var body: some View {
        Group {
                    Text("First")
                    Text("Second")
                }
    }
}

struct GroupUIView_Previews: PreviewProvider {
    static var previews: some View {
        GroupUIView()
    }
}
