import Foundation

final class CacheManager {
    static let shared = CacheManager()
    
    private init() {}
    
    private let movieCache = NSCache<NSString, NSArray>()
    
    func setMovies(_ movies: [Movie], for key: String) {
        movieCache.setObject(movies as NSArray, forKey: key as NSString)
    }
    
    func getMovies(for key: String) -> [Movie]? {
        movieCache.object(forKey: key as NSString) as? [Movie]
    }
}
