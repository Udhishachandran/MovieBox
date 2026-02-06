import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let runtime: Int
    let vote_average: Double
    let genres: [Genre]
}

struct Genre: Decodable {
    let name: String
}
