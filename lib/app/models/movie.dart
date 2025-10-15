
import 'package:cine_topia/app/config/api_constants.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final String releaseDate;
  final List<int> genreIds;
  final bool adult;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;
  final bool video;
  final int voteCount;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genreIds,
    this.adult = false,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    this.video = false,
    required this.voteCount,
  });

  /// Converte um JSON da API TMDB em uma instância Movie
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      adult: json['adult'] ?? false,
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      video: json['video'] ?? false,
      voteCount: json['vote_count'] ?? 0,
    );
  }

  /// Converte a instância Movie em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'genre_ids': genreIds,
      'adult': adult,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'popularity': popularity,
      'video': video,
      'vote_count': voteCount,
    };
  }

  // URL completa do poster
  String get fullPosterUrl => ApiConstants.getImageUrl(posterPath);
  
  // URL completa do backdrop
  String get fullBackdropUrl => ApiConstants.getImageUrl(backdropPath);
  
  // Ano de lançamento
  String get releaseYear {
    if (releaseDate.isNotEmpty && releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }
    return 'N/A';
  }

  // Nota formatada (0.0 - 10.0)
  String get formattedRating => voteAverage.toStringAsFixed(1);

  // Nota em estrelas (0-5)
  double get starRating => voteAverage / 2;

  // URL da imagem (compatibilidade)
  String get imageUrl => fullPosterUrl;

  // Verifica se o filme tem poster
  bool get hasPoster => posterPath != null && posterPath!.isNotEmpty;

  // Verifica se o filme tem backdrop
  bool get hasBackdrop => backdropPath != null && backdropPath!.isNotEmpty;

  // Data formatada em português
  String get formattedReleaseDate {
    if (releaseDate.isEmpty) return 'Data não disponível';
    
    try {
      final parts = releaseDate.split('-');
      if (parts.length == 3) {
        final year = parts[0];
        final month = parts[1];
        final day = parts[2];
        
        const months = [
          '', 'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
          'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
        ];
        
        final monthName = int.parse(month) <= 12 ? months[int.parse(month)] : 'mês inválido';
        return '$day de $monthName de $year';
      }
    } catch (e) {
      return releaseDate;
    }
    
    return releaseDate;
  }

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, releaseYear: $releaseYear, rating: $formattedRating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Movie && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}