import 'package:flutter/material.dart';
import 'package:flutter_movies_reviewer/presentation/screens/movie_detail/movie_detail.dart';

class NavigatorUtils {

  NavigatorUtils._();

  static final NavigatorUtils instance = NavigatorUtils._();

  void navigateToMovieDetailScreen(BuildContext context, int movieId) {
    Navigator.of(context).pushNamed(
      MovieDetailWidget.route,
      arguments: MovieDetailArguments(
        movieId: movieId,
      ),
    );
  }
}