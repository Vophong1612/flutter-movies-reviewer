import 'package:flutter_movies_reviewer/domain/models/movie_video.dart';
import 'package:flutter_movies_reviewer/domain/repository/movie_repository.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';

class GetMovieVideosUseCase {
  final MovieRepository movieRepository;

  GetMovieVideosUseCase({required this.movieRepository});

  Future<APIResult<List<MovieVideo>>> invoice(int movieId) =>
      movieRepository.getMovieVideos(movieId: movieId);
}
