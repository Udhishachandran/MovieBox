import Foundation
import Combine

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var detail: MovieDetail?
    @Published var trailerKey: String?

    func load(id: Int) {
        TMDBService.fetchMovieDetail(id: id) {
            self.detail = $0
        }

        TMDBService.fetchTrailer(id: id) {
            self.trailerKey = $0?.key
        }
    }
}
