import Foundation

class TMDBService {

    static func fetchPopularMovies(completion: @escaping ([Movie]) -> Void) {

        if let cached = CacheManager.shared.getMovies(for: Strings.popular) {
            DispatchQueue.main.async {
                completion(cached)
            }
            return
        }

        let url = URL(string: "\(Constants.baseURL)/movie/popular?api_key=\(Constants.apiKey)")!

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }

            let response = try? JSONDecoder().decode(MovieResponse.self, from: data)
            let movies = response?.results ?? []

            CacheManager.shared.setMovies(movies, for: Strings.popular)

            DispatchQueue.main.async {
                completion(movies)
            }
        }.resume()
    }

    static func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {

        let q = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "\(Constants.baseURL)/search/movie?api_key=\(Constants.apiKey)&query=\(q)")!

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }

            let response = try? JSONDecoder().decode(MovieResponse.self, from: data)

            DispatchQueue.main.async {
                completion(response?.results ?? [])
            }
        }.resume()
    }

    static func fetchMovieDetail(id: Int, completion: @escaping (MovieDetail?) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/movie/\(id)?api_key=\(Constants.apiKey)")!

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }

            let detail = try? JSONDecoder().decode(MovieDetail.self, from: data)

            DispatchQueue.main.async {
                completion(detail)
            }
        }.resume()
    }

    static func fetchTrailer(id: Int, completion: @escaping (Video?) -> Void) {

        let url = URL(string: "\(Constants.baseURL)/movie/\(id)/videos?api_key=\(Constants.apiKey)")!

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }

            let response = try? JSONDecoder().decode(VideoResponse.self, from: data)
            let trailer = response?.results.first { $0.type == Strings.trailer }

            DispatchQueue.main.async {
                completion(trailer)
            }
        }.resume()
    }
}
