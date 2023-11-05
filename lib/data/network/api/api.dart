import 'dart:convert';

import 'package:flutter_movies_reviewer/data/dto/get_popular_movies_respone.dart';
import 'package:flutter_movies_reviewer/data/network/constants.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:http/http.dart' as http;

abstract class Api {
  Future<APIResult<List<Movie>>> getPopularMovies(int page);
  Future<APIResult<List<Movie>>> getTopRatedMovies(int page);
}

class ApiImp extends Api {
  String buildUrl(String url) {
    String result = '${Constants.apiUrl}$url&api_key=${Constants.apiKey}';
    return result;
  }

  @override
  Future<APIResult<List<Movie>>> getPopularMovies(int page) async {
    final String url = 'movie/popular?language=en-US&page=$page';

    return await _getMoviesList(url, page);
  }

  @override
  Future<APIResult<List<Movie>>> getTopRatedMovies(int page) async {
    final String url = 'movie/popular?language=en-US&page=$page';

    return await _getMoviesList(url, page);
  }

  Future<APIResult<List<Movie>>> _getMoviesList(String url, int page) async {
    try {
      final response = await http.get(Uri.parse(buildUrl(url)));
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
