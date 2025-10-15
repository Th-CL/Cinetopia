import 'package:cine_topia/app/interfaces/i_movie_service.dart';
import 'package:cine_topia/app/interfaces/i_navigation_service.dart';
import 'package:cine_topia/app/services/search_movies_service.dart';
import 'package:cine_topia/app/services/navigation_service.dart';
import 'package:cine_topia/app/viewmodels/search_movies_viewmodel.dart';
import 'package:cine_topia/app/viewmodels/releases_viewmodel.dart';

/// Container de Dependency Injection (SOLID - Dependency Inversion Principle)
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};

  /// Inicializa e registra todos os serviços
  static void initialize() {
    _instance.registerServices();
  }

  /// Registra os serviços
  void registerServices() {
    // Registrar serviços
    _services[IMovieService] = MovieService();
    _services[INavigationService] = NavigationService();
  }

  /// Obtém um serviço
  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Serviço ${T.toString()} não registrado');
    }
    return service as T;
  }

  /// Cria ViewModels com dependências injetadas
  SearchMoviesViewModel createSearchMoviesViewModel() {
    return SearchMoviesViewModel(get<IMovieService>());
  }

  ReleasesViewModel createReleasesViewModel() {
    return ReleasesViewModel(get<IMovieService>());
  }

  /// Limpa todos os serviços (útil para testes)
  void reset() {
    _services.clear();
  }
}