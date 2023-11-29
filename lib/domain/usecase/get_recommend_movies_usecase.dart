import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/repository/movie_repository.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';

class GetRecommendMoviesUseCase {
  const GetRecommendMoviesUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  final MovieRepository _movieRepository;

  Future<APIResult<List<Movie>>> invoke(
          {required int movieId, int page = 1}) async =>
      await _movieRepository.getRecommendMovies(movieId: movieId, page: page);
}
