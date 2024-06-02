//
//  TextEditorView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct TextEditorView: View {
    @State private var notes = ""
    var body: some View {
        ZStack {
                    Color.yellow 
                    
                    TextEditor(text: $notes)
                        .padding()
                }
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
            
    }
}
