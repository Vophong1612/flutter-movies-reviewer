part of 'recommend_movies_bloc.dart';

@immutable
abstract class GetRecommendMoviesState {}

class GetRecommendMovieInitialState extends GetRecommendMoviesState {}

class GetRecommendMovieLoadingState extends GetRecommendMoviesState {}

class GetRecommendMovieSuccessState extends GetRecommendMoviesState {
  final List<Movie> recommendMovies;

  GetRecommendMovieSuccessState({required this.recommendMovies});
}

class GetRecommendMovieFailureState extends GetRecommendMoviesState {
  final Exception exception;
  GetRecommendMovieFailureState({required this.exception});
}
