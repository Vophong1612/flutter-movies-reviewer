part of 'movie_detail_bloc.dart';

@immutable
abstract class GetMovieDetailState {}

class GetMovieDetailInitialState extends GetMovieDetailState {}

class GetMovieDetailLoadingState extends GetMovieDetailState {}

class GetMovieDetailSuccessState extends GetMovieDetailState {
  final MovieDetail movieDetail;

  GetMovieDetailSuccessState({required this.movieDetail});
}

class GetMovieDetailFailureState extends GetMovieDetailState {
  final Exception exception;
  GetMovieDetailFailureState({required this.exception});
}
