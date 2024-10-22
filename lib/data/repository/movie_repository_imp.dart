import 'package:flutter_movies_reviewer/data/mapper/data_mapper.dart';
import 'package:flutter_movies_reviewer/data/network/datasources/movie_service.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_video.dart';
import 'package:flutter_movies_reviewer/domain/repository/movie_repository.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';

class MovieRepositoryImp extends MovieRepository {
  MovieRepositoryImp({required MovieService api}) : _api = api;

  final MovieService _api;

  @override
  Future<APIResult<List<Movie>>> getPopularMovies({int page = 1}) async {
    try {
      final response = await _api.getPopularMovies(page);
      final result = response.results?.map((element) => element.toMovie()).toList() ?? [];
      return APISuccess(result);
    } on Exception {
      return APIFailure(Exception('get popular movies error !'));
    }
  }

  @override
  Future<APIResult<List<Movie>>> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await _api.getTopRatedMovies(page);
      final result = response.results?.map((element) => element.toMovie()).toList() ?? [];
      return APISuccess(result);
    } on Exception {
      return APIFailure(Exception('get top rated movies error !'));
    }
  }

  @override
  Future<APIResult<MovieDetail>> getMovieDetail({required int movieId}) async {
    try {
      final response = await _api.getMovieDetail(movieId);
      final result = response.toMovieDetail();
      return APISuccess(result);
    } on Exception {
      return APIFailure(Exception('get movie detail error !'));
    }
  }

  @override
  Future<APIResult<List<Movie>>> getRecommendMovies({required int movieId, int page = 1}) async {
    try {
      final response = await _api.getRecommendMovies(movieId, page);
      final result = response.results?.map((element) => element.toMovie()).toList() ?? [];
      return APISuccess(result);
    } on Exception {
      return APIFailure(Exception('get recommend movies error !'));
    }
  }

  @override
  Future<APIResult<List<MovieVideo>>> getMovieVideos({required int movieId}) async {
    try {
      final response = await _api.getMovieVideos(movieId);
      final result = response.results?.map((e) => e.toMovieVideo()).toList() ?? [];
      return APISuccess(result);
    } on Exception {
      return APIFailure(Exception('get movie video error !'));
    }
  }
}
