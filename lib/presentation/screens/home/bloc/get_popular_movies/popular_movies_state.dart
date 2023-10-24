part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState {}

class PopularMoviesInitialState extends PopularMoviesState {}

class PopularMoviesLoadingState extends PopularMoviesState {}

class PopularMoviesSuccessState extends PopularMoviesState {
  final List<Movie> movies;

  PopularMoviesSuccessState({required this.movies});
}

class PopularMoviesFailureState extends PopularMoviesState {
  final Exception exception;
  PopularMoviesFailureState({required this.exception});
}