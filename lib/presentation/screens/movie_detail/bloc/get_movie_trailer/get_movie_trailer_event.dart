part of 'get_movie_trailer_bloc.dart';

@immutable
abstract class MovieTrailerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieTrailerEvent extends MovieTrailerEvent {
  final int movieId;

  GetMovieTrailerEvent({required this.movieId});
}
