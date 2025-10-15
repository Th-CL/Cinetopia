import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cine_topia/app/config/api_constants.dart';
import 'package:cine_topia/app/models/movie.dart';
import 'package:cine_topia/app/interfaces/i_movie_service.dart';

/// Implementação do serviço de filmes (SOLID - Interface Segregation)
class MovieService implements IMovieService {
  
  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getPopularMoviesUrl()),
        headers: _getHeaders(),
      );

      return _processMoviesResponse(response, 'filmes populares');
    } catch (e) {
      throw Exception('Erro ao carregar filmes populares: $e');
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      throw Exception('Termo de busca não pode estar vazio');
    }

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getSearchMoviesUrl(query)),
        headers: _getHeaders(),
      );

      return _processMoviesResponse(response, 'busca de filmes');
    } catch (e) {
      throw Exception('Erro ao buscar filmes: $e');
    }
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final url = '${ApiConstants.baseUrl}/movie/now_playing?api_key=${ApiConstants.apiKey}&language=${ApiConstants.defaultLanguage}&page=${ApiConstants.defaultPage}';
      
      final response = await http.get(
        Uri.parse(url),
        headers: _getHeaders(),
      );

      return _processMoviesResponse(response, 'filmes em cartaz');
    } catch (e) {
      throw Exception('Erro ao carregar filmes em cartaz: $e');
    }
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final url = '${ApiConstants.baseUrl}/movie/upcoming?api_key=${ApiConstants.apiKey}&language=${ApiConstants.defaultLanguage}&page=${ApiConstants.defaultPage}';
      
      final response = await http.get(
        Uri.parse(url),
        headers: _getHeaders(),
      );

      return _processMoviesResponse(response, 'próximos lançamentos');
    } catch (e) {
      throw Exception('Erro ao carregar próximos lançamentos: $e');
    }
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    try {
      final url = '${ApiConstants.baseUrl}/movie/top_rated?api_key=${ApiConstants.apiKey}&language=${ApiConstants.defaultLanguage}&page=${ApiConstants.defaultPage}';
      
      final response = await http.get(
        Uri.parse(url),
        headers: _getHeaders(),
      );

      return _processMoviesResponse(response, 'filmes mais bem avaliados');
    } catch (e) {
      throw Exception('Erro ao carregar filmes mais bem avaliados: $e');
    }
  }

  @override
  Future<bool> testApiConnection() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getPopularMoviesUrl()),
        headers: _getHeaders(),
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Headers padrão para requisições
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  /// Processa a resposta HTTP e converte em lista de filmes
  List<Movie> _processMoviesResponse(http.Response response, String context) {
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        
        if (data['results'] != null) {
          final List<dynamic> moviesJson = data['results'];
          return moviesJson.map((json) => Movie.fromJson(json)).toList();
        } else {
          throw Exception('Formato de resposta inválido: campo "results" não encontrado');
        }
      } catch (e) {
        throw Exception('Erro ao processar dados de $context: $e');
      }
    } else {
      throw Exception('Erro HTTP $context: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}