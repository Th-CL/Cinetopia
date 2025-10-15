import 'package:flutter/material.dart';
import 'package:cine_topia/app/models/movie.dart';
import 'package:cine_topia/app/ui/screens/movie_details_screen.dart';
import 'package:cine_topia/app/interfaces/i_navigation_service.dart';

/// Implementação do serviço de navegação (SOLID - Single Responsibility)
class NavigationService implements INavigationService {
  
  @override
  Future<void> navigateToMovieDetails(
    BuildContext context, 
    Movie movie, {
    bool useSlideTransition = true,
  }) async {
    if (useSlideTransition) {
      await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
              MovieDetailsScreen(movie: movie),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(movie: movie),
        ),
      );
    }
  }

  @override
  void goBack(BuildContext context, [dynamic result]) {
    Navigator.pop(context, result);
  }

  @override
  void goToRoot(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  bool canGoBack(BuildContext context) {
    return Navigator.canPop(context);
  }
}