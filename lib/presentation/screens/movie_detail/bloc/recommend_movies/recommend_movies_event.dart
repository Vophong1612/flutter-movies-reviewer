part of 'recommend_movies_bloc.dart';

@immutable
abstract class RecommendMoviesEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class GetRecommendMoviesEvent extends RecommendMoviesEvent {
  GetRecommendMoviesEvent({required this.movieId});

  final int movieId;
}
