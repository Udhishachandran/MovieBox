import Foundation
import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    let onNavigate: () -> Void
    
    @EnvironmentObject var favorites: FavoritesManager

    var body: some View {
        HStack(spacing: 12) {
            
            AsyncImage(
                url: URL(string: "\(Constants.imageBaseURL)\(movie.poster_path ?? "")")
            ) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)

                Text("⭐️ \(movie.vote_average, specifier: "%.1f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button {
                favorites.toggleFavorite(id: movie.id)
            } label: {
                Image(systemName:
                        favorites.isFavorite(id: movie.id)
                        ? Strings.heartFill
                        : Strings.heart
                )
                .foregroundColor(.red)
            }
            .buttonStyle(.plain)            
        }
        .padding(.vertical, 6)
        .onTapGesture {
            onNavigate()
        }
    }
}
