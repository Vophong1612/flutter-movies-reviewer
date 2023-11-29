part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class GetMovieDetailEvent extends MovieDetailEvent {
  GetMovieDetailEvent({required this.movieId});

  final int movieId;
}
