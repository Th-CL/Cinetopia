import 'package:cine_topia/app/models/movie.dart';
import 'package:cine_topia/app/interfaces/i_movie_service.dart';
import 'package:cine_topia/app/viewmodels/base_viewmodel.dart';

/// ViewModel para lançamentos (MVVM Pattern)
class ReleasesViewModel extends BaseViewModel {
  final IMovieService _movieService;
  
  List<Movie> _upcomingMovies = [];

  ReleasesViewModel(this._movieService);

  List<Movie> get upcomingMovies => _upcomingMovies;

  /// Carrega próximos lançamentos
  Future<void> loadUpcomingMovies() async {
    setState(ViewState.loading);
    
    try {
      final allUpcomingMovies = await _movieService.getUpcomingMovies();
      
      // Filtrar apenas filmes com data de lançamento futura
      final now = DateTime.now();
      _upcomingMovies = allUpcomingMovies.where((movie) {
        if (movie.releaseDate.isEmpty) {
          return false; // Remove filmes sem data de lançamento
        }
        
        try {
          final releaseDate = DateTime.parse(movie.releaseDate);
          return releaseDate.isAfter(now); // Apenas filmes com data futura
        } catch (e) {
          return false; // Remove filmes com data inválida
        }
      }).toList();
      
      // Ordenar por data de lançamento (mais próximos primeiro)
      _upcomingMovies.sort((a, b) {
        try {
          final dateA = DateTime.parse(a.releaseDate);
          final dateB = DateTime.parse(b.releaseDate);
          return dateA.compareTo(dateB);
        } catch (e) {
          return 0;
        }
      });
      
      if (_upcomingMovies.isEmpty) {
        setState(ViewState.empty);
      } else {
        setState(ViewState.success);
      }
    } catch (e) {
      setError('Erro ao carregar lançamentos: ${e.toString()}');
    }
  }

  /// Recarrega os lançamentos
  Future<void> refresh() async {
    await loadUpcomingMovies();
  }

  /// Inicializa os dados
  Future<void> initialize() async {
    await loadUpcomingMovies();
  }
}