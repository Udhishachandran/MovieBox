import Foundation
import Combine

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var detail: MovieDetail?
    @Published var trailerKey: String?

    func load(id: Int) {
        Task {
            do {
                self.detail = try await TMDBService.fetchMovieDetail(id: id)
                self.trailerKey = try await TMDBService.fetchTrailer(id: id)?.key
            } catch {
                print("\(Strings.failedToLoadMovieDetail):", error)
            }
        }
    }
}
