//
//  TearsOfJoyView.swift
//  AmLive
//
//  Created by amos.gyamfi@getstream.io on 25.8.2023.
//

import SwiftUI

struct TearsOfJoyView: View {
    @State private var isJoyful = false
    
    var body: some View {
        ZStack {
            Image("tearHead")
            
            VStack(spacing: -30) {
                Image("joyEyes")
                    .rotationEffect(.degrees(isJoyful ? -16 : 8))
                
                Image("tearMouth")
                    .resizable()
                    .frame(width: 33, height: isJoyful ? 32 : 28)
                    .scaleEffect(isJoyful ? 0.8 : 1)
                    .rotationEffect(.degrees(isJoyful ? 8 : -8))
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isJoyful)
            }
            
            
            HStack(spacing: 12){
                Image("tearRight")
                    .rotationEffect(.degrees(isJoyful ? 5 : -30), anchor: .topTrailing)
                    .animation(.easeOut(duration: 0.25).repeatForever(autoreverses: true), value: isJoyful)
                
                Image("tearLeft")
                    .rotationEffect(.degrees(isJoyful ? -30 : 5), anchor: .topLeading)
                    .animation(.easeIn(duration: 0.25).repeatForever(autoreverses: true), value: isJoyful)
            }
        }.scaleEffect(3)
            .onAppear{
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    isJoyful.toggle()
                }
            }
    }
}
