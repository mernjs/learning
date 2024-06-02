//
//  CapsuleView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct CapsuleView: View {
    var body: some View {
        Capsule()
                    .frame(width: 200, height: 100)
                    .foregroundColor(.yellow)
    }
}

struct CapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleView()
    }
}
