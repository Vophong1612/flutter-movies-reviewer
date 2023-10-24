import 'dart:convert';

import 'package:flutter_movies_reviewer/data/network/constants.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_movies_reviewer/data/dto/get_popular_movies_respone.dart';

abstract class Api {
  Future<List<MovieResponse>> getPopularMovie(int page);
}

class ApiImp extends Api {
  String buildUrl(String url) {
    String result = '${Constants.apiUrl}$url&api_key=${Constants.apiKey}';
    return result;
  }

  @override
  Future<List<MovieResponse>> getPopularMovie(int page) async {
    final String url = 'movie/popular?language=en-US&page=$page';

    final response = await http.get(Uri.parse(buildUrl(url)));
    switch (response.statusCode) {
      case 200:
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final data = json.decode(response.body);
        final results = (data['results'] as List)
            .map((e) => MovieResponse.fromMap(e))
            .toList();
        return results;
      default:
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load popular movies');
    }
  }
}
