import 'package:flutter/material.dart';
import 'package:cine_topia/app/services/search_movies_service.dart';

class MoviesProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = '';

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Carregar filmes populares
  Future<void> loadPopularMovies() async {
    _setLoading(true);
    try {
      _movies = await SearchMoviesService.getPopularMovies();
      _error = '';
    } catch (e) {
      _error = e.toString();
      _movies = [];
    } finally {
      _setLoading(false);
    }
  }

  // Buscar filmes por nome
  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      await loadPopularMovies();
      return;
    }

    _setLoading(true);
    try {
      _movies = await SearchMoviesService.searchMovies(query);
      _error = '';
    } catch (e) {
      _error = e.toString();
      _movies = [];
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}