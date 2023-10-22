import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/repository/movie_repository.dart';

class GetPopularMoviesUseCase {
  const GetPopularMoviesUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  final MovieRepository _movieRepository;

  Future<List<Movie>> invoke({int page = 1}) async => await _movieRepository.getPopularMovies(page: page);
}
