import SwiftUI

struct OnboardingView: View {
    @State private var currentPageIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPageIndex) {
                OnboardingPage(imageName: "onboarding1", title: "Welcome", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                    .tag(0)
                OnboardingPage(imageName: "onboarding2", title: "Explore", description: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .tag(1)
                OnboardingPage(imageName: "onboarding3", title: "Enjoy", description: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            HStack {
                Button(action: {
                    withAnimation {
                        currentPageIndex = max(currentPageIndex - 1, 0)
                    }
                }) {
                    Text("Previous")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                       
                }
                .disabled(currentPageIndex == 0) // Disable button if on the first page
                .padding()
                
                Spacer()
                
                Button(action: {
                    if currentPageIndex < 2 { // Check if not on the last page
                        withAnimation {
                            currentPageIndex += 1
                        }
                    } else { // On the last page, action changes to "Get Started"
                        // Add your action here for "Get Started"
                        // For example: navigate to the next screen
                    }
                }) {
                    
                        Text(currentPageIndex < 2 ? "Next" : "Get Started")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                   
                    
                }
                .padding()
            }
        }
    }
}

struct OnboardingPage: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text(description)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 50)
    }
}
