import 'package:cine_topia/app/models/movie.dart';
import 'package:cine_topia/app/interfaces/i_movie_service.dart';
import 'package:cine_topia/app/viewmodels/base_viewmodel.dart';

/// ViewModel para busca de filmes (MVVM Pattern)
class SearchMoviesViewModel extends BaseViewModel {
  final IMovieService _movieService;
  
  List<Movie> _movies = [];
  String _lastQuery = '';

  SearchMoviesViewModel(this._movieService);

  List<Movie> get movies => _movies;
  String get lastQuery => _lastQuery;

  /// Carrega filmes populares
  Future<void> loadPopularMovies() async {
    setState(ViewState.loading);
    
    try {
      _movies = await _movieService.getPopularMovies();
      _lastQuery = '';
      
      if (_movies.isEmpty) {
        setState(ViewState.empty);
      } else {
        setState(ViewState.success);
      }
    } catch (e) {
      setError('Erro ao carregar filmes populares: ${e.toString()}');
    }
  }

  /// Busca filmes por query
  Future<void> searchMovies(String query) async {
    _lastQuery = query;
    
    if (query.trim().isEmpty) {
      await loadPopularMovies();
      return;
    }

    setState(ViewState.loading);
    
    try {
      _movies = await _movieService.searchMovies(query);
      
      if (_movies.isEmpty) {
        setState(ViewState.empty);
      } else {
        setState(ViewState.success);
      }
    } catch (e) {
      setError('Erro ao buscar filmes: ${e.toString()}');
    }
  }

  /// Recarrega a última busca ou filmes populares
  Future<void> refresh() async {
    if (_lastQuery.isEmpty) {
      await loadPopularMovies();
    } else {
      await searchMovies(_lastQuery);
    }
  }

  /// Inicializa os dados
  Future<void> initialize() async {
    await loadPopularMovies();
  }
}