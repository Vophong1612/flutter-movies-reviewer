import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';

abstract class MovieRepository {
  Future<APIResult<List<Movie>>> getPopularMovies({int page});
  Future<APIResult<List<Movie>>> getTopRatedMovies({int page});
  Future<APIResult<MovieDetail>> getMovieDetail({required int movieId});
}