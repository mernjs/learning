import AlertToast
import SwiftUI

struct ShowToast: View{

    @State private var showToast = false

    var body: some View{
        VStack{

            Button("Show Toast"){
                 showToast.toggle()
            }
        }
        .toast(isPresenting: $showToast){
//            AlertToast(type: .regular, title: "Message Sent!")
            AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
//            AlertToast(displayMode: .banner(.slide), type: .regular, title: "Message Sent!")
            
        }
    }
}
