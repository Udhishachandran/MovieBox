import Foundation

class TMDBService {

    static func fetchPopularMovies() async throws -> [Movie] {
        if let cached = CacheManager.shared.getMovies(for: Strings.popular) {
            return cached
        }
        
        let url = URL(string: "\(Constants.baseURL)/movie/popular?api_key=\(Constants.apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode off main actor
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        let movies = response.results
        
        CacheManager.shared.setMovies(movies, for: Strings.popular)
        return movies
    }

    static func searchMovies(query: String) async throws -> [Movie] {
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "\(Constants.baseURL)/search/movie?api_key=\(Constants.apiKey)&query=\(q)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        return response.results
    }

    static func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        let url = URL(string: "\(Constants.baseURL)/movie/\(id)?api_key=\(Constants.apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MovieDetail.self, from: data)
    }

    static func fetchTrailer(id: Int) async throws -> Video? {
        let url = URL(string: "\(Constants.baseURL)/movie/\(id)/videos?api_key=\(Constants.apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(VideoResponse.self, from: data)
        return response.results.first { $0.type == Strings.trailer }
    }
}
