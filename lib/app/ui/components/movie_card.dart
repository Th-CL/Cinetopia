import 'package:flutter/material.dart';
import 'package:cine_topia/app/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            // Poster do filme
            Container(
              width: 90,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF333333),
                border: Border.all(
                  color: const Color(0xFF555555),
                  width: 1,
                ),
              ),
              margin: const EdgeInsets.only(right: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: movie.hasPoster
                    ? Image.network(
                        movie.fullPosterUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: const Color(0xFF333333),
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB370FF)),
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF333333),
                            child: const Icon(
                              Icons.movie,
                              color: Colors.white54,
                              size: 32,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: const Color(0xFF333333),
                        child: const Icon(
                          Icons.movie,
                          color: Colors.white54,
                          size: 32,
                        ),
                      ),
              ),
            ),
            
            // Informações do filme
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Título
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 6),
                  
                  // Data de lançamento
                  Text(
                    "Lançamento: ${movie.releaseYear}",
                    style: const TextStyle(
                      color: Color(0xFFA5A5A5),
                      fontSize: 14, 
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Avaliação
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.formattedRating,
                        style: const TextStyle(
                          color: Color(0xFFA5A5A5),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "(${movie.voteCount} votos)",
                        style: const TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Resumo
                  if (movie.overview.isNotEmpty)
                    Text(
                      movie.overview,
                      style: const TextStyle(
                        color: Color(0xFFB5B5B5),
                        fontSize: 13,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            
            // Ícone de seta
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFB370FF),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}