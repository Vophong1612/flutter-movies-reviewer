import 'dart:convert';

import 'package:flutter_movies_reviewer/domain/models/movie.dart';

class MovieResponse extends Movie {
  const MovieResponse({
    super.id,
    super.adult,
    super.backdropPath,
    super.genreIds,
    super.originalLanguage,
    super.originalTitle,
    super.overview,
    super.popularity,
    super.posterPath,
    super.releaseDate,
    super.title,
    super.video,
    super.voteAverage,
    super.voteCount,
  });

  factory MovieResponse.fromRawJson(String jsonStr) => MovieResponse.fromMap(json.decode(jsonStr));

  String toRawJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'adult': adult,
        'backdropPath': backdropPath,
        'genreIds': genreIds,
        'originalLanguage': originalLanguage,
        'originalTitle': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'posterPath': posterPath,
        'releaseDate': releaseDate,
        'title': title,
        'video': video,
        'voteAverage': voteAverage,
        'voteCount': voteCount,
      };

  factory MovieResponse.fromMap(Map<String, dynamic> map) => MovieResponse(
      id: map['id'],
      voteCount: map['vote_count'],
      video: map['video'],
      voteAverage: map['vote_average'],
      title: map['title'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      genreIds: map['genre_ids'].cast<int>(),
      backdropPath: map['backdrop_path'],
      adult: map['adult'],
      overview: map['overview'],
      releaseDate: map['release_date'],
    );
}
