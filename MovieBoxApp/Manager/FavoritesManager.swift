import Foundation
import SwiftUI
import Combine

@MainActor
class FavoritesManager: ObservableObject {
    
    @Published private(set) var favorites: Set<Int> = [] {
        didSet {
            saveFavorites()
        }
    }
    
    private let key = "favorites_key"
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(id: Int) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }
    
    // MARK: - Persistence
    
    private func saveFavorites() {
        let array = Array(favorites)
        UserDefaults.standard.set(array, forKey: key)
    }
    
    private func loadFavorites() {
        if let saved = UserDefaults.standard.array(forKey: key) as? [Int] {
            favorites = Set(saved)
        }
    }
}
