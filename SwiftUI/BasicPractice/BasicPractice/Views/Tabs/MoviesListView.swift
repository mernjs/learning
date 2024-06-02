import SwiftUI

struct MoviesListView: View {
    enum Tab {
        case latest, old, upcoming
    }
    
    @State private var selectedTab: Tab = .latest
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Tab", selection: $selectedTab) {
                    Text("Latest").tag(Tab.latest)
                    Text("Old").tag(Tab.old)
                    Text("Upcoming").tag(Tab.upcoming)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Content based on selected tab
                switch selectedTab {
                    case .latest:
                        LatestMoviesView()
                    case .old:
                        OldMoviesView()
                    case .upcoming:
                        UpcomingMoviesView()
                }
                
                Spacer()
            }
            .navigationTitle("Movies")
        }
    }
}

struct LatestMoviesView: View {
    var body: some View {
        Text("Latest Movies")
            .font(.title)
            .foregroundColor(.blue)
    }
}

struct OldMoviesView: View {
    var body: some View {
        Text("Old Movies")
            .font(.title)
            .foregroundColor(.green)
    }
}

struct UpcomingMoviesView: View {
    var body: some View {
        Text("Upcoming Movies")
            .font(.title)
            .foregroundColor(.orange)
    }
}
