part of 'toprated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class GetTopRatedMoviesEvent extends TopRatedMoviesEvent {}
