//
//  FormView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct FormView: View {
    var body: some View {
        Form {
                    Section(header: Text("Section 1")) {
                        Text("Item 1")
                        Text("Item 2")
                    }
                    Section(header: Text("Section 2")) {
                        Text("Item 3")
                        Text("Item 4")
                    }
                }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
