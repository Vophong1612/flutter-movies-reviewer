part of 'toprated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesState {}

class TopRatedInitialState extends TopRatedMoviesState {}

class TopRatedLoadingState extends TopRatedMoviesState {}

class TopRatedSuccessState extends TopRatedMoviesState {
  final List<Movie> movies;

  TopRatedSuccessState({required this.movies});
}

class TopRatedMoviesFailureState extends TopRatedMoviesState {
  final Exception exception;
  TopRatedMoviesFailureState({required this.exception});
}
