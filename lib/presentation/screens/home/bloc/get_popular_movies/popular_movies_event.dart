part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class GetPopularMoviesEvent extends PopularMoviesEvent {}
