part of 'get_movie_trailer_bloc.dart';

@immutable
abstract class GetMovieTrailerState {}

class GetMovieTrailerInitialState extends GetMovieTrailerState {}

class GetMovieTrailerLoadingState extends GetMovieTrailerState {}

class GetMovieTrailerSuccessState extends GetMovieTrailerState {
  final MovieVideo movieVideo;

  GetMovieTrailerSuccessState({required this.movieVideo});
}

class GetMovieTrailerErrorState extends GetMovieTrailerState {
  final Exception exception;

  GetMovieTrailerErrorState({required this.exception});
}
