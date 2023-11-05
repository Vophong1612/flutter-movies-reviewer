import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/repository/movie_repository.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';

class GetTopRatedMoviesUseCase {
  const GetTopRatedMoviesUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  final MovieRepository _movieRepository;

  Future<APIResult<List<Movie>>> invoke({int page = 1}) async => await _movieRepository.getTopRatedMovies(page: page);
}