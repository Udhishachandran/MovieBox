import SwiftUI

struct MovieDetailView: View {

    let movieId: Int
    @EnvironmentObject var favorites: FavoritesManager
    @StateObject private var vm = MovieDetailViewModel()

    var body: some View {
        ScrollView {

            if let key = vm.trailerKey {
                YouTubePlayerView(videoID: key)
                    .aspectRatio(16/9, contentMode: .fit)
                //                    .frame(height: 220)
                //                    .cornerRadius(12)
                //                    .padding(.bottom)
            }
            else {
                Text("No trailer available.")
            }

            if let movie = vm.detail {
                VStack(alignment: .leading, spacing: 12) {

                    Text(movie.title)
                        .font(.title)
                        .bold()

                    Text(movie.overview)

                    Text("\(Strings.duration): \(movie.runtime) min")
                    Text("\(Strings.rating): ⭐️ \(movie.vote_average)")
                    Text("\(Strings.genres): \(movie.genres.map { $0.name }.joined(separator: ", "))")
                    
                    Button {
                        favorites.toggleFavorite(id: movie.id)
                    } label: {
                        Label(Strings.favorite, systemImage:
                                favorites.isFavorite(id: movie.id)
                              ? Strings.heartFill : Strings.heart)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            vm.load(id: movieId)
        }
    }
}
