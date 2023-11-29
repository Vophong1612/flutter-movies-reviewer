import 'package:flutter/material.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/home_screen.dart';
import 'package:flutter_movies_reviewer/presentation/screens/movie_detail/movie_detail.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case MovieDetailWidget.route:
        final args = settings.arguments! as MovieDetailArguments;
        return MaterialPageRoute(
          builder: (_) => MovieDetailWidget(movieId: args.movieId),
        );
      default:
        return null;
    }
  }
}
