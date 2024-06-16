//
//  LivestreamView.swift
//  AmLive
//
//  Created by amos.gyamfi@getstream.io on 25.8.2023.
//

import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

struct LivestreamView: View {
    
    @Injected(\.streamVideo) var streamVideo
    
    let call: Call
    
    // Handles backstage, duration, number of participants , list of participants
    @StateObject var state: CallState
    
    let formatter = DateComponentsFormatter()
    
    init(call: Call) {
        self.call = call
        _state = StateObject(wrappedValue: call.state)
        formatter.unitsStyle = .positional
    }
    
    var duration: String? {
        guard call.state.duration > 0  else { return nil }
        return formatter.string(from: call.state.duration)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { reader in
                    if let first = state.participants.first {
                        VideoRendererView(id: first.id, size: reader.size) { renderer in
                            renderer.handleViewRendering(for: first) { size, participant in }
                        }
                    } else {
                        Color(UIColor.secondarySystemBackground)
                    }
                }
                
                VStack {
                    
                    if call.state.backstage {
                        //Spacer()
                        Button {
                            Task {
                                try await call.goLive()
                                //try await call.startHLS()
                                /*try await call.goLive(
                                        startHls: true,
                                        startRecording: true,
                                        startTranscription: true
                                    )*/
                            }
                        } label: {
                            Text("Go Live")
                                .bold()
                                .padding(EdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32))
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom, 24)
                        
                    } else {
                        //Spacer()
                        CommentView()
                            .padding(.bottom, 64)
                        Button(role: .destructive) {
                            Task {
                                try await call.stopLive()
                            }
                        } label: {
                            Text("Stop Livestream")
                                .bold()
                                .padding(EdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32))
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom, 24)
                        
                        ReactionsView()
                        /*VStack {
                            ReactionsView()
                            CommentView()
                        }
                        .frame(height: 180)
                        .rotationEffect(.degrees(0), anchor: .bottom)*/
                    }
                    
                    
                }
                .padding(.bottom, 32)
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    if let duration {
                        Text("Live \(duration)")
                            .font(.headline)
                            .bold()
                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                            .background(.quaternary)
                            .cornerRadius(8)
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing){
                    HStack {
                        Image(systemName: "eyes.inverse")
                            .symbolEffect(.pulse)
                            .bold()
                        Text("Watching \(state.participantCount)")
                            .bold()
                            .opacity(call.state.backstage ? 0 : 1)
                    }
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(.quaternary)
                    .cornerRadius(8)
                }
            }
        }
    }
    
}

