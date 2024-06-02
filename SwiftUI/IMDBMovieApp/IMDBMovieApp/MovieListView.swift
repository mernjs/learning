import SwiftUI
import Alamofire

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case overview
    }
}

class MovieListController: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var loading: Bool = false
    @Published var search: String = "spider"
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies() {
        loading = true
        let url = "https://api.themoviedb.org/3/search/movie"
        let parameters: Parameters = [
            "api_key": "d4fbc0cd7f3b6b7ea3c3b8e5c74b8f46",
            "language": "en-US",
            "query": search
        ]
        
        AF.request(url, parameters: parameters).responseDecodable(of: MoviesResponse.self) { response in
            DispatchQueue.main.async {
                self.loading = false
                switch response.result {
                case .success(let moviesResponse):
                    self.movies = moviesResponse.results
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                }
            }
        }
    }
}

struct MoviesResponse: Codable {
    let results: [Movie]
}

struct MovieListView: View {
    @StateObject private var controller = MovieListController()
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView{
                if controller.loading {
                    ProgressView().progressViewStyle(.circular)
                } else {
                    TextField("Search...", text: $controller.search)
                    Button("Search"){
                        controller.fetchMovies()
                    }
                    ForEach(controller.movies) { movie in
                        MovieRow(movie: movie, geometry: geometry)
                    }
                }
            }
        }.padding()
        
    }
}

struct MovieRow: View {
    let movie: Movie
    let geometry: GeometryProxy
    
    var body: some View {
        
        VStack {
            Text(movie.title)
                .font(.headline)
            
            if let posterPath = movie.posterPath {
                ZStack {
                    AsyncImageView(imageUrl: URL(string: "https://image.tmdb.org/t/p/w92\(posterPath)")!, geometry: geometry )
                }
            }
            
            HStack {
                Text("Date: \(movie.releaseDate)")
                    .font(.subheadline)
                
                Spacer()
                
                Text("Rating: \(movie.voteAverage)")
                    .font(.subheadline)
            }
        }
    }
    
}

struct AsyncImageView: View {
    var imageUrl: URL
    var geometry: GeometryProxy
    
    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: geometry.size.width, height: 300)
                    .aspectRatio(contentMode: .fit)
            case .success(let image):
                image
                    .resizable()
                    .frame(width: geometry.size.width, height: 300)
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: geometry.size.width, height: 300)
                    .aspectRatio(contentMode: .fit)
            @unknown default:
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: geometry.size.width, height: 300)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}
