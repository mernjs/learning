//
//  ActionSheetView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 06/04/24.
//

import SwiftUI

struct ActionSheetView: View {
    @State private var showActionSheet = false
    
    var body: some View {
        Button(action: {
            showActionSheet = true
        }) {
            Text("Show Action Sheet")
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Choose an option"),
                message: Text("This is an action sheet."),
                buttons: [
                    .default(Text("Option 1")) {
                        // Option 1 action
                    },
                    .destructive(Text("Option 2")) {
                        // Option 2 action
                    },
                    .cancel()
                ]
            )
        }
    }
}

struct ActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetView()
    }
}
