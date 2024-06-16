//
//  HandRaisedIn3DY.swift
//  AmLive
//
//  Created by amos.gyamfi@getstream.io on 25.8.2023.
//

import SwiftUI

struct HandRaisedIn3DY: View {
    @State private var handIsRaised = false
    
    var body: some View {
        Button {
            // Add tap action
        } label: {
            Image("handRaised")
                .rotation3DEffect(.degrees(handIsRaised ? 0 : -180), axis: (x: 0, y: 1, z: 0))
                .offset(y: handIsRaised ? -125 : 0)
                .onAppear{
                    withAnimation(.easeInOut(duration: 1).delay(0.5).repeatForever(autoreverses: true)){
                        handIsRaised.toggle()
                    }
                }
        }
    }
}
