//
//  DividerView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        VStack {
            Text("Above Divider")
            Divider()
            Text("Below Divider")
        }
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
    }
}
