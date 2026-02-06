# MovieBox App

A simple iOS app that integrates with The Movie Database (TMDb) API.  
The app displays popular movies, allows searching, viewing details, playing trailers, and marking favorites.

---

## Setup

1. **TMDb API Key**
   - Register at [TMDb](https://www.themoviedb.org/) to get an API key.
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
Trailer Playback: Plays trailers inside the app using embedded YouTube player via WKWebView.
Search: Users can search movies by title.
Favorites: Users can mark/unmark favorites, which persist between app launches.
Caching: Movie list and images are cached for better performance.

Known Limitations

Trailer playback requires a valid YouTube video key.
No offline mode for movie details.
Favorites are stored locally (UserDefaults), not synced with a server.
Some TMDb data (like cast) may not be complete if API limits are reached.
