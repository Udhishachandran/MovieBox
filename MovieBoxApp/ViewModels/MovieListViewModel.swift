import Foundation
import Combine

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText = ""
    
    private var searchTask: DispatchWorkItem?

    
    func loadMovies() {
        TMDBService.fetchPopularMovies { self.movies = $0 }
    }
    
    func search() {
        searchTask?.cancel()
        
        let task = DispatchWorkItem {
            if self.searchText.isEmpty {
                self.loadMovies()
            } else {
                TMDBService.searchMovies(query: self.searchText) {
                    self.movies = $0
                }
            }
        }
        
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: task)
    }
}
