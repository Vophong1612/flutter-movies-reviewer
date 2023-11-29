import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';
import 'package:flutter_movies_reviewer/domain/repository/movie_repository.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';

class GetMovieDetailUseCase {
  final MovieRepository _movieRepository;

  GetMovieDetailUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  Future<APIResult<MovieDetail>> invoke({required int movieId}) async =>
      await _movieRepository.getMovieDetail(movieId: movieId);
}
