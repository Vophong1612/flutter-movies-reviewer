import 'package:flutter_movies_reviewer/data/network/api/api.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';

import '../../domain/repository/movie_repository.dart';

class MovieRepositoryImp extends MovieRepository {
  MovieRepositoryImp({required Api api}) : _api = api;

  final Api _api;

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    //todo: implement result enum
    return await _api.getPopularMovie(page);
  }
}
