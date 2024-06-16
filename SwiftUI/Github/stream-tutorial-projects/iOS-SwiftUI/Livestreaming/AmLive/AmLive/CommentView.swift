//
//  CommentView.swift
//  AmLive
//
//  Created by amos.gyamfi@getstream.io on 3.9.2023.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isSender: Bool
    var isDelivered: Bool = false
}

struct CommentView: View {
    @State private var messages: [Message] = []
    @State private var newMessage = ""
    @State private var messageCount = 2
    @State private var showingBubble = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Color.clear
                VStack(spacing: 12) {
                    Color.clear
                    Spacer()
                    ForEach(messages) { message in
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing, spacing: 2) {
                                Text(message.content)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    
                                    .phaseAnimator([false, true], trigger: messageCount) { messageBubble, scaleFromBottomTrailing in
                                        messageBubble
                                            .scaleEffect(scaleFromBottomTrailing ? 2 : 1, anchor: .bottomTrailing)
                                    } animation: { scaleFromBottomTrailing in
                                            .bouncy(duration: 0.25, extraBounce: 0.5)
                                    }
                                
                                Text(Date.now, style: .time)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                    HStack {
                        TextField("Comment", text: $newMessage)
                            .padding()
                            
                            .frame(width: 260)
                        
                        Button {
                            sendMessage()
                            messageCount = 1
                            showingBubble = true
                            
                        }; label: do {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title)
                                .disabled(newMessage.isEmpty)
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else {
            return
        }
    
        withAnimation() {
            messages.append(Message(content: newMessage, isSender: true))
        }
        
        withAnimation() {
            newMessage = ""
        }
    }
}
