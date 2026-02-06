import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = MovieListViewModel()
    @State private var selectedMovie: Movie?
    var body: some View {
        NavigationStack {
            List(vm.movies) { movie in
                MovieRowView(
                    movie: movie,
                    onNavigate: {
                    }
                )
                .background(
                    NavigationLink(value: movie) {
                        EmptyView()
                    }
                        .opacity(0)
                )
            }
            .navigationTitle(Strings.popularMovies)
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movieId: movie.id)
            }
            .searchable(text: $vm.searchText)
            .onChange(of: vm.searchText) { _ in vm.search() }
            .onAppear { vm.loadMovies() }
        }
    }
    
}
