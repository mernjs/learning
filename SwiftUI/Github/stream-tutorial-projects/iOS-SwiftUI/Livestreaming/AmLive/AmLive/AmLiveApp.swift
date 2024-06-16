//
//  AmLiveApp.swift
//  AmLive
//
//  Created by amos.gyamfi@getstream.io on 25.8.2023.
//

import SwiftUI
import StreamVideo

@main
// MARK:  Broadcast a Live Video From an iOS Device
/*struct AmLiveApp: App {

    // Create an instance of the StreamVideo client
    @State var streamVideo: StreamVideo
    let call: Call
    
    init() {
        // Define user properties
        let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUFJPWFkiLCJpc3MiOiJwcm9udG8iLCJzdWIiOiJ1c2VyL1BST1hZIiwiaWF0IjoxNjkzMzA3MDU2LCJleHAiOjE2OTM5MTE4NjF9.4MLtsLuZ2BQX94gONn28YUG94F7G-P0IaivwqO819nw"
        let userId = "PROXY"
        let callId = "5gMzqr9WvKoM"
        
        // Create a user object
        let user = User(id: userId, name: "tutorial")
        
        // Initialize the video client with the API key and token

        let streamVideo = StreamVideo(
            apiKey: "hd8szvscpxvd",
            user: user,
            token: .init(rawValue: userToken)
        )
        self.streamVideo = streamVideo
        
        // Create and join a live stream
        let call = streamVideo.call(callType: "livestream", callId: callId)
        self.call = call
        Task {
            try await call.join(create: true)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LiveStreamView(call: call)
        }
    }
}*/

/*struct LiveStreamView: View {
    
    let call: Call
    
    var body: some View {
        VStack(spacing: 120) {
            Text("You are now broadcasting from your phone")
            LivestreamingCharacter()
        }
    }
    
}*/

// MARK: Video Rendering
struct AmLiveApp: App {

    @State var streamVideo: StreamVideo
    let call: Call
    
    init() {
        let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUFJPWFkiLCJpc3MiOiJwcm9udG8iLCJzdWIiOiJ1c2VyL1BST1hZIiwiaWF0IjoxNjkzMzA3MDU2LCJleHAiOjE2OTM5MTE4NjF9.4MLtsLuZ2BQX94gONn28YUG94F7G-P0IaivwqO819nw"
        let userId = "PROXY"
        let callId = "5gMzqr9WvKoM"
        
        // Set up the user
        let user = User(id: userId, name: "tutorial")
        
        // Create the Stream Video client
        let streamVideo = StreamVideo(
            apiKey: "hd8szvscpxvd",
            user: user,
            token: .init(rawValue: userToken)
        )
        self.streamVideo = streamVideo
        
        // Create a call: Specify the type as live stream with a unique callID
        let call = streamVideo.call(callType: "livestream", callId: callId)
        self.call = call
        Task {
            // Create the call object on our server and initiate the real-time transport for audio and video
            try await call.join(create: true)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LivestreamView(call: call)
        }
    }
}


