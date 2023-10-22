import 'package:flutter_movies_reviewer/domain/models/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({int page});
}