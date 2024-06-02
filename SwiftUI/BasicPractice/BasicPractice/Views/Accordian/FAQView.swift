import SwiftUI

struct FAQView: View {
    @State private var selectedIndex: Int?
    
    let faqs = [
        FAQ(question: "What is SwiftUI?", answer: "SwiftUI is a modern UI framework provided by Apple to build user interfaces across all Apple platforms using the Swift programming language."),
        FAQ(question: "Is SwiftUI available for all Apple platforms?", answer: "Yes, SwiftUI is available for iOS, macOS, watchOS, and tvOS."),
        FAQ(question: "Can I use SwiftUI with UIKit/AppKit?", answer: "Yes, you can use SwiftUI views in UIKit/AppKit by integrating SwiftUI views into your existing UIKit/AppKit apps."),
        FAQ(question: "Is SwiftUI backward compatible?", answer: "SwiftUI is available starting from iOS 13.0, macOS 10.15, watchOS 6, and tvOS 13.0. It is not backward compatible with earlier versions of iOS, macOS, watchOS, and tvOS."),
        FAQ(question: "Can I use SwiftUI with Objective-C?", answer: "SwiftUI is a Swift-only framework and cannot be directly used with Objective-C. However, you can still use SwiftUI views within an app written in Objective-C by bridging them through Swift."),
    ]
    
    var body: some View {
        List {
            ForEach(faqs.indices, id: \.self) { index in
                Section(header:
                    FAQHeaderView(faq: faqs[index], index: index, selectedIndex: $selectedIndex)
                ) {
                    if selectedIndex == index {
                        Text(faqs[index].answer)
                            .padding()
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("FAQ")
    }
}

struct FAQHeaderView: View {
    let faq: FAQ
    let index: Int
    @Binding var selectedIndex: Int?
    
    var body: some View {
        Button(action: {
            if selectedIndex == index {
                selectedIndex = nil
            } else {
                selectedIndex = index
            }
        }) {
            HStack {
                Text(faq.question)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: selectedIndex == index ? "chevron.up" : "chevron.down")
                    .imageScale(.large)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}
