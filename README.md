# MovieBox App

A simple iOS app that integrates with The Movie Database (TMDb) API.  
The app displays popular movies, allows searching, viewing details, playing trailers, and marking favorites.

---

## Setup

1. **TMDb API Key**
   - get API Key from [TMDb](https://www.themoviedb.org/).
   - Add your API key in `Utils/Constants.swift`:

   ```swift
   struct Constants {
       static let apiKey = "YOUR_TMDB_API_KEY"
       static let baseURL = "https://api.themoviedb.org/3"
       static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
   }
Assumptions

App targets iOS 16+.
Users must have an internet connection to fetch movie data.
TMDb API is stable and accessible.

Implemented Features

Home Screen: Lists popular movies with title, poster, and rating.
Movie Detail Screen: Shows title, overview, genres, duration, rating, and trailer.
Trailer Playback: Plays trailers inside the app using an embedded YouTube player via WKWebView.
Search: Users can search movies by title.
Favorites: Users can mark/unmark favorites. Favorites persist locally between app launches.
Caching: Movie list and images are cached to improve performance and reduce network calls.

Known Limitations

Movie duration is not displayed on the Home Screen because the "popular movies" API does not provide runtime.
Trailer playback requires a valid YouTube video key.
Movie details are not available offline.
Favorites are stored locally using UserDefaults and are not synced with a backend.
Some TMDb data (e.g., cast information) may be incomplete if API rate limits are reached.
