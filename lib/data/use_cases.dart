import 'package:flutter_movies_reviewer/domain/usecase/get_movie_detail_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_top_rated_movies_usecase.dart';

class UseCases {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetMovieDetailUseCase getMovieDetailUseCase;

  UseCases({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getMovieDetailUseCase,
  });
}
