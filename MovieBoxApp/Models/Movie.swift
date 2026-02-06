import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Identifiable, Decodable, Hashable {
    let id: Int
    let title: String
    let poster_path: String?
    let vote_average: Double
    let runtime: Int?
}
