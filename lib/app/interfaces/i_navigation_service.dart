import 'package:flutter/material.dart';
import 'package:cine_topia/app/models/movie.dart';

/// Interface para navegação (SOLID - Dependency Inversion Principle)
abstract class INavigationService {
  Future<void> navigateToMovieDetails(BuildContext context, Movie movie, {bool useSlideTransition});
  void goBack(BuildContext context, [dynamic result]);
  void goToRoot(BuildContext context);
  bool canGoBack(BuildContext context);
}