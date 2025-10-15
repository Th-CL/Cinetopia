import 'package:flutter/material.dart';
import 'package:cine_topia/app/models/movie.dart';
import 'package:cine_topia/app/core/service_locator.dart';
import 'package:cine_topia/app/interfaces/i_navigation_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late final INavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _navigationService = ServiceLocator().get<INavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D0E44),
      body: CustomScrollView(
        slivers: [
          // AppBar customizada com backdrop
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(0xFF1D0E44),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _navigationService.goBack(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Backdrop image
                  if (widget.movie.hasBackdrop)
                    Image.network(
                      widget.movie.fullBackdropUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF333333),
                          child: const Icon(
                            Icons.movie,
                            color: Colors.white54,
                            size: 64,
                          ),
                        );
                      },
                    )
                  else
                    Container(
                      color: const Color(0xFF333333),
                      child: const Icon(
                        Icons.movie,
                        color: Colors.white54,
                        size: 64,
                      ),
                    ),
                  
                  // Gradiente overlay
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xFF1D0E44),
                        ],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Conteúdo principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster e informações básicas
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Poster
                      Container(
                        width: 120,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: widget.movie.hasPoster
                              ? Image.network(
                                  widget.movie.fullPosterUrl,
                                  fit: BoxFit.cover,
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
                      
                      const SizedBox(width: 16),
                      
                      // Informações básicas
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título
                            Text(
                              widget.movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Título original (se diferente)
                            if (widget.movie.originalTitle != widget.movie.title)
                              Text(
                                widget.movie.originalTitle,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            
                            const SizedBox(height: 12),
                            
                            // Data de lançamento
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Color(0xFFB370FF),
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.movie.formattedReleaseDate,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Avaliação
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.movie.formattedRating}/10',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(${widget.movie.voteCount} votos)',
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Popularidade
                            Row(
                              children: [
                                const Icon(
                                  Icons.trending_up,
                                  color: Color(0xFFB370FF),
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Popularidade: ${widget.movie.popularity.toStringAsFixed(1)}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sinopse
                  const Text(
                    'Sinopse',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      widget.movie.overview.isNotEmpty
                          ? widget.movie.overview
                          : 'Sinopse não disponível para este filme.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Informações técnicas
                  const Text(
                    'Informações Técnicas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('ID do Filme', widget.movie.id.toString()),
                        _buildInfoRow('Idioma Original', widget.movie.originalLanguage.toUpperCase()),
                        _buildInfoRow('Classificação', widget.movie.adult ? '18+' : 'Livre'),
                        _buildInfoRow('Ano de Lançamento', widget.movie.releaseYear),
                        _buildInfoRow('Avaliação Média', widget.movie.formattedRating),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Botão de voltar (alternativo)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _navigationService.goBack(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB370FF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        'Voltar à Lista',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget helper para criar linhas de informação
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Color(0xFFB370FF),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}