//
//  ReactionsView.swift
//  AmLive
//
//  Created by amos.gyamfi@getstream.io on 25.8.2023.
//

import SwiftUI

struct ReactionsView: View {
    @State private var showReactions = false
    let deviceHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            HStack(spacing: 16) {
                ZStack {
                    TearsOfJoyView()
                        .hueRotation(.degrees(showReactions ? -deviceHeight : 0))
                        .offset(y: showReactions ? -deviceHeight : -30)
                        .scaleEffect(showReactions ? 1 : 0, anchor: showReactions ? .bottomLeading: .bottomTrailing)
                        .rotationEffect(.degrees(showReactions ? -5 : 5))
                        .animation(Animation.easeInOut(duration: 4).delay(1).repeatForever(autoreverses: false), value: showReactions)
                    
                    //Image("handDefault")
                    ClappingHandsEmojiView()
                        .scaleEffect(showReactions ? 5 : 0, anchor: showReactions ? .bottomLeading: .bottomTrailing)
                        .hueRotation(.degrees(showReactions ? -deviceHeight : 0))
                        .offset(x: -20, y: showReactions ? -deviceHeight : -30)
                        .rotationEffect(.degrees(showReactions ? 15 : -30))
                        .animation(Animation.easeOut(duration: 4).delay(1).repeatForever(autoreverses: false), value: showReactions)
                    
                    Image("handDefault")
                    //ClappingHandsEmojiView()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                        .scaleEffect(showReactions ? 3 : 0, anchor: showReactions ? .bottomLeading: .bottomTrailing)
                        .hueRotation(.degrees(showReactions ? 0 : 220))
                        .offset(y: showReactions ? -deviceHeight : -30)
                        .rotationEffect(.degrees(showReactions ? -39 : 20))
                        .animation(Animation.easeIn(duration: 4).delay(1).repeatForever(autoreverses: false), value: showReactions)
                    
                    //Image("handDefault")
                    ClappingHandsEmojiView()
                }
                .frame(width: 38, height: 38)
                
                ZStack {
                    Image("heart3D")
                    //RevolvingHeartView()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .scaleEffect(showReactions ? 3 : 0, anchor: showReactions ? .bottomLeading: .top)
                        .opacity(showReactions ? 2 : 0)
                        .hueRotation(.degrees(showReactions ? 0 : 220))
                        .offset(y: showReactions ? -deviceHeight : -30)
                        .rotationEffect(.degrees(showReactions ? -7.5 : 15))
                        .animation(Animation.easeOut(duration: 4).delay(1.1).repeatForever(autoreverses: false), value: showReactions)
                    
                    RevolvingHeartView()
                        .scaleEffect(showReactions ? 1.2 : 0, anchor: showReactions ? .bottomLeading: .bottomTrailing)
                        .hueRotation(.degrees(showReactions ? 0 : 220))
                        .offset(x: -30, y: showReactions ? -deviceHeight : -30)
                        .rotationEffect(.degrees(showReactions ? -10 : 5))
                        .animation(Animation.easeIn(duration: 4).delay(1).repeatForever(autoreverses: false), value: showReactions)
                    
                    HeartExclamationView()
                        .scaleEffect(showReactions ? 5 : 0, anchor: showReactions ? .bottomLeading: .bottomTrailing)
                        .hueRotation(.degrees(showReactions ? 0 : 20))
                        .offset(x: -20, y: showReactions ? -deviceHeight : -35)
                        .rotationEffect(.degrees(showReactions ? -15 : 15))
                        .animation(Animation.easeIn(duration: 4).delay(1.5).repeatForever(autoreverses: false), value: showReactions)
                    
                    Image("heart3D")
                        .resizable()
                        .hueRotation(.degrees(330))
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                }
                .frame(width: 38, height: 38)
                
                HandRaisedIn3DY()
                    .scaleEffect(1.4)
                
                ReactionsWithKeyframes()
            }
            .padding()
            .onAppear {
                showReactions.toggle()
            }
        }
        .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.quaternary))
        .padding(.bottom)
    }
}
