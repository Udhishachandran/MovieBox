import Foundation
import Combine

@MainActor
class FavoritesManager: ObservableObject {

    @Published private(set) var favorites: Set<Int> = []

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
}
