import 'package:cine_topia/app/models/movie.dart';

/// Interface para serviços de filmes (SOLID - Dependency Inversion Principle)
abstract class IMovieService {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> searchMovies(String query);
  Future<List<Movie>> getUpcomingMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getNowPlayingMovies();
  Future<bool> testApiConnection();
}