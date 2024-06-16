//
//  LivestreamingCharacter.swift
//  AmLive
//
//  Created by amos.gyamfi@getstream.io on 2.9.2023.

import SwiftUI

struct LivestreamingCharacter: View {
    @State private var isTalking = false
    @State private var isBlinking = false
    @State private var isShaking = false
    @State private var chromaRotating = false
    
    var body: some View {
        ZStack {
            Image("ls-ears")
                .rotationEffect(.degrees(isShaking ? 15 : -5), anchor: .bottom)
                .offset(y: -50)
                .animation(.easeOut.delay(2).repeatForever(autoreverses: true), value: isShaking)
            
            Image("ls-head")
                .offset(y: isShaking ? 2 : -2)
                .animation(.easeInOut.delay(2).repeatForever(autoreverses: true), value: isShaking)
            Image("ls-table")
                .offset(y: 50)
            
            ZStack {
                Image("ls-keyboard")
                    .hueRotation(.degrees(chromaRotating ? 0 : 280))
                    .offset(x: 20, y: 50)
                    .animation(.easeOut.repeatForever(autoreverses: true), value: chromaRotating)
                Image("ls-mouse")
                    .rotationEffect(.degrees(isShaking ? 5 : -5), anchor: isShaking ? .bottomTrailing : .bottomLeading)
                    .offset(x: -31, y: 48)
                    .offset(x: isShaking ? -6 : -2)
                    .animation(.easeOut(duration: 0.25).repeatForever(autoreverses: true), value: isShaking)
            }
            
            Image("ls-hand-l")
                .rotationEffect(.degrees(isShaking ? 50 : -5), anchor: .top)
                .offset(x: 51, y: 35)
                .offset(x: isShaking ? -11 : 1.5)
                .animation(.easeIn.delay(2).repeatForever(autoreverses: true), value: isShaking)
            
            Image("ls-hand-r")
                .rotationEffect(.degrees(isShaking ? 5 : -5), anchor: isShaking ? .topLeading : .topTrailing)
                .offset(x: -32, y: 35)
                .offset(x: isShaking ? -6 : -2)
                .animation(.easeIn(duration: 0.25).repeatForever(autoreverses: true), value: isShaking)
            
            Image("ls-eye-l")
                .rotationEffect(.degrees(isShaking ? 15 : -15))
                .animation(.easeInOut.delay(2).repeatForever(autoreverses: true), value: isShaking)
                .scaleEffect(y: isBlinking ? 0.25 : 1)
                .offset(x: 25, y: -26)
                .animation(.timingCurve(0.68, -0.6, 0.32, 1.6).delay(1.5).repeatForever(autoreverses: false), value: isBlinking)
            Image("ls-eye-r")
                .rotationEffect(.degrees(isShaking ? 15 : -15))
                .animation(.easeOut.delay(2).repeatForever(autoreverses: true), value: isShaking)
                .scaleEffect(y: isBlinking ? 0.4 : 1)
                .offset(x: -20, y: -25)
                .animation(.easeOut.delay(1.5).repeatForever(autoreverses: false), value: isBlinking)
            Image("ls-headset")
                .rotationEffect(.degrees(isShaking ? 2 : -2), anchor: .top)
                .offset(y: isShaking ? 1 : -1)
                .animation(.easeIn.delay(2).repeatForever(autoreverses: true), value: isShaking)
            //.animation(.timingCurve(0.68, -0.6, 0.32, 1.6).repeatForever(autoreverses: true), value: isBlinking)
                .offset(x: 3, y: -20)
            Image("ls-mouth")
                .rotationEffect(.degrees(isShaking ? 15 : 0), anchor: .top)
                .animation(.easeIn.delay(2).repeatForever(autoreverses: true), value: isShaking)
                .offset(x: 3, y: -10)
                .scaleEffect(0.6)
                .scaleEffect(x: isTalking ? 1 : 0.8, anchor: .top)
                .animation(.easeIn.delay(0.01).speed(2).repeatForever(autoreverses: true), value: isTalking)
                .scaleEffect(y: isTalking ? 0.8 : 1, anchor: .top)
                .animation(.easeOut.delay(0.01).speed(2).repeatForever(autoreverses: true), value: isTalking)
        }
        .scaleEffect(2)
        .onAppear {
            isTalking.toggle()
            isBlinking.toggle()
            isShaking.toggle()
            chromaRotating.toggle()
        }
    }
}
