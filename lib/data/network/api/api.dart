import 'dart:convert';

import 'package:flutter_movies_reviewer/data/dto/get_movie_detail_response.dart';
import 'package:flutter_movies_reviewer/data/dto/get_popular_movies_respone.dart';
import 'package:flutter_movies_reviewer/data/network/constants.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:http/http.dart' as http;

abstract class Api {
  Future<APIResult<List<Movie>>> getPopularMovies(int page);
  Future<APIResult<List<Movie>>> getTopRatedMovies(int page);
  Future<APIResult<MovieDetail>> getMovieDetail(int movieId);
  Future<APIResult<List<Movie>>> getRecommendMovies(int movieId, int page);
}

class ApiImp extends Api {
  String buildUrl({required String url, String? parameters}) {
    String result = '${Constants.apiUrl}$url?language=en-US&api_key=${Constants.apiKey}&$parameters';
    print(result);
    return result;
  }

  @override
  Future<APIResult<List<Movie>>> getPopularMovies(int page) async {
    const String url = 'movie/popular';

    return await _getMoviesList(url, page);
  }

  @override
  Future<APIResult<List<Movie>>> getTopRatedMovies(int page) async {
    const String url = 'movie/top_rated';

    return await _getMoviesList(url, page);
  }

  @override
  Future<APIResult<MovieDetail>> getMovieDetail(int movieId) async {
    final String url = 'movie/$movieId';
    try {
      final response = await http.get(Uri.parse(buildUrl(url: url)));
      switch (response.statusCode) {
        case 200:
        // If the server did return a 200 OK response,
        // then parse the JSON.
          final data = json.decode(response.body);
          final result = MovieDetailResponse.fromMap(data);
          return APISuccess(result);
        default:
        // If the server did not return a 200 OK response,
        // then return error
        print(response.statusCode);
          return APIFailure(Exception('Failed to get movie detail'));
      }
    } on Exception catch (ex) {
      return APIFailure(ex);
    }
  }

  @override
  Future<APIResult<List<Movie>>> getRecommendMovies(int movieId, int page) async {
    String url = 'movie/$movieId/recommendations';
    return await _getMoviesList(url, page);
  }

  Future<APIResult<List<Movie>>> _getMoviesList(String url, int page) async {
    try {
      final parameter = 'page=$page';
      final response = await http.get(Uri.parse(buildUrl(url: url, parameters: parameter)));
      switch (response.statusCode) {
        case 200:
        // If the server did return a 200 OK response,
        // then parse the JSON.
          final data = json.decode(response.body);
          final results = (data['results'] as List)
              .map((e) => MovieResponse.fromMap(e))
              .toList();
          return APISuccess(results);
        default:
        // If the server did not return a 200 OK response,
        // then return error
          return APIFailure(Exception('Failed to load popular movies'));
      }
    } on Exception catch (ex) {
      return APIFailure(ex);
    }
  }
}
