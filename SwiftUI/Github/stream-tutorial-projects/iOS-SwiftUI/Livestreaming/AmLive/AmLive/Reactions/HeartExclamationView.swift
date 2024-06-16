//
//  HeartExclamationView.swift
//  AmLive
//
//  Created by amos.gyamfi@getstream.io on 25.8.2023.
//

import SwiftUI

struct HeartExclamationView: View {
    @State private var isYRotating: Double = 0
    
    var body: some View {
        Button {
            // Add tap action
        } label: {
            VStack(spacing: 0) {
                Image("heartExclamation")
                    .rotation3DEffect(.degrees(isYRotating), axis: (x: 0, y: 1, z: 0))
                    .font(.system(size: 128))
                    .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: isYRotating)
                    .onAppear {
                        isYRotating = 360
                    }
                Image("circleExclamation")
            }
        }
    }
}
