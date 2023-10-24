import 'package:flutter_movies_reviewer/data/network/api/api.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';

import '../../domain/repository/movie_repository.dart';

class MovieRepositoryImp extends MovieRepository {
  MovieRepositoryImp({required Api api}) : _api = api;

  final Api _api;

  @override
  Future<APIResult<List<Movie>>> getPopularMovies({int page = 1}) async {
    return await _api.getPopularMovie(page);
  }
}