class ApiConstants {
  // TMDB API Configuration
  static const String apiKey = 'accbd700b0a89491a520a62aff9166c9';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  
  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String searchMovies = '/search/movie';
  static const String movieDetails = '/movie';
  
  // Default parameters
  static const String defaultLanguage = 'pt-BR';
  static const int defaultPage = 1;
  
  // Helper methods
  static String getPopularMoviesUrl() {
    return '$baseUrl$popularMovies?api_key=$apiKey&language=$defaultLanguage&page=$defaultPage';
  }
  
  static String getSearchMoviesUrl(String query) {
    return '$baseUrl$searchMovies?api_key=$apiKey&query=${Uri.encodeComponent(query)}&language=$defaultLanguage&page=$defaultPage';
  }
  
  static String getImageUrl(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) {
      return '';
    }
    return '$imageBaseUrl$posterPath';
  }
}