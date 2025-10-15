import 'package:flutter/material.dart';
import 'package:cine_topia/app/ui/components/movie_card.dart';
import 'package:cine_topia/app/viewmodels/search_movies_viewmodel.dart';
import 'package:cine_topia/app/ui/widgets/base_view.dart';
import 'package:cine_topia/app/core/service_locator.dart';
import 'package:cine_topia/app/interfaces/i_navigation_service.dart';

class SearchMovies extends BaseView<SearchMoviesViewModel> {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends BaseViewState<SearchMoviesViewModel, SearchMovies> {
  final TextEditingController _searchController = TextEditingController();
  final INavigationService _navigationService = ServiceLocator().get<INavigationService>();

  @override
  SearchMoviesViewModel createViewModel() {
    return ServiceLocator().createSearchMoviesViewModel();
  }

  @override
  void initState() {
    super.initState();
    // Inicializa os dados
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initialize();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void onRetry() {
    viewModel.refresh();
  }

  /// Atualiza a busca com base no texto digitado
  void _onSearchChanged(String query) {
    viewModel.searchMovies(query);
  }

  @override
  Widget buildView(BuildContext context) {
    return Container(
      color: const Color(0xFF1D0E44),
      child: Column(
        children: [
          // Campo de busca
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar filmes...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white54),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFB370FF), width: 2),
                ),
              ),
            ),
          ),
          
          // Lista de filmes
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await viewModel.refresh();
              },
              backgroundColor: const Color(0xFFB370FF),
              color: Colors.white,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final movie = viewModel.movies[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: MovieCard(
                              movie: movie,
                              onTap: () {
                                _navigationService.navigateToMovieDetails(context, movie);
                              },
                            ),
                          );
                        },
                        childCount: viewModel.movies.length,
                      ),
                    ),
                  ),
                  // Espaço extra no final
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}