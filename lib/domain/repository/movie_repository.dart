import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';

abstract class MovieRepository {
  Future<APIResult<List<Movie>>> getPopularMovies({int page});
}