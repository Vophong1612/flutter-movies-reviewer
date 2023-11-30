import 'package:flutter_movies_reviewer/domain/usecase/get_movie_detail_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_movie_videos_use_case.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_recommend_movies_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_top_rated_movies_usecase.dart';

class UseCases {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetMovieDetailUseCase getMovieDetailUseCase;
  final GetRecommendMoviesUseCase getRecommendMoviesUseCase;
  final GetMovieVideosUseCase getMovieVideosUseCase;

  UseCases({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getMovieDetailUseCase,
    required this.getRecommendMoviesUseCase,
    required this.getMovieVideosUseCase,
  });
}
