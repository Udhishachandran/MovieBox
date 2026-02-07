import Foundation
import Combine

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText = ""
    
    private var searchTask: Task<Void, Never>? = nil
    
    func loadMovies() {
        searchTask?.cancel()
        searchTask = Task {
            do {
                let movies = try await TMDBService.fetchPopularMovies()
                self.movies = movies
            } catch {
                print("\(Strings.failedToLoadMovies):", error)
                self.movies = []
            }
        }
    }
    
    func search() {
        searchTask?.cancel()
        
        let text = searchText
        searchTask = Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let movies: [Movie]
                if text.isEmpty {
                    movies = try await TMDBService.fetchPopularMovies()
                } else {
                    movies = try await TMDBService.searchMovies(query: text)
                }
                self.movies = movies
            } catch {
                print("\(Strings.searchFailed):", error)
                self.movies = []
            }
        }
    }
}
