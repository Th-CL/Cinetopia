import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchMoviesService {
  // Substitua 'SUA_CHAVE_AQUI' pela sua chave da TMDB
  static const String _apiKey = 'SUA_CHAVE_AQUI';
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // Buscar filmes populares
  static Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&language=pt-BR'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> moviesJson = data['results'];
        
        return moviesJson.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar filmes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar filmes por nome
  static Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/search/movie?api_key=$_apiKey&language=pt-BR&query=${Uri.encodeComponent(query)}'
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> moviesJson = data['results'];
        
        return moviesJson.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar filmes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Construir URL completa da imagem
  static String getImageUrl(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) {
      return '';
    }
    return '$_imageBaseUrl$posterPath';
  }
}

// Modelo de dados para os filmes
class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final String releaseDate;
  final List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }

  // URL completa do poster
  String get fullPosterUrl => SearchMoviesService.getImageUrl(posterPath);
  
  // URL completa do backdrop
  String get fullBackdropUrl => SearchMoviesService.getImageUrl(backdropPath);
  
  // Ano de lançamento
  String get releaseYear {
    if (releaseDate.isNotEmpty) {
      return releaseDate.split('-').first;
    }
    return '';
  }

  // Nota formatada
  String get formattedRating => voteAverage.toStringAsFixed(1);
}