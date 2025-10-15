import 'package:flutter/material.dart';
import 'package:cine_topia/app/ui/components/movie_card.dart';
import 'package:cine_topia/app/viewmodels/releases_viewmodel.dart';
import 'package:cine_topia/app/ui/widgets/base_view.dart';
import 'package:cine_topia/app/core/service_locator.dart';
import 'package:cine_topia/app/interfaces/i_navigation_service.dart';

class Releases extends BaseView<ReleasesViewModel> {
  const Releases({super.key});

  @override
  State<Releases> createState() => _ReleasesState();
}

class _ReleasesState extends BaseViewState<ReleasesViewModel, Releases> {
  final INavigationService _navigationService = ServiceLocator().get<INavigationService>();

  @override
  ReleasesViewModel createViewModel() {
    return ServiceLocator().createReleasesViewModel();
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
  void onRetry() {
    viewModel.refresh();
  }

  @override
  Widget buildView(BuildContext context) {
    return Container(
      color: const Color(0xFF1D0E44),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.upcoming,
                  color: Color(0xFFB370FF),
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Próximos Lançamentos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (viewModel.isSuccess)
                        Text(
                          "${viewModel.upcomingMovies.length} filmes encontrados",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => viewModel.refresh(),
                  icon: const Icon(
                    Icons.refresh,
                    color: Color(0xFFB370FF),
                  ),
                ),
              ],
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
                          final movie = viewModel.upcomingMovies[index];
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
                        childCount: viewModel.upcomingMovies.length,
                      ),
                    ),
                  ),
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