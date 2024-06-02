//
//  DatePickerView.swift
//  CameraApp
//
//  Created by Vijay Pratap Singh on 05/04/24.
//

import SwiftUI

struct DatePickerView: View {
    @State private var selectedDate = Date()
       
       var body: some View {
           DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
               .padding()
       }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
