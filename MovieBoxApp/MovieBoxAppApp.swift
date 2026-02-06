import SwiftUI

@main
struct MovieBoxAppApp: App {
    
    @StateObject private var favorites = FavoritesManager()
    
    init() {
        URLCache.shared.memoryCapacity = 100 * 1024 * 1024
        URLCache.shared.diskCapacity = 200 * 1024 * 1024
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(favorites)
        }
    }
}
