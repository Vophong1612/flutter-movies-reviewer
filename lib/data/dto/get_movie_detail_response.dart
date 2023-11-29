import 'dart:convert';

import 'package:flutter_movies_reviewer/data/dto/genres_response.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';

class MovieDetailResponse extends MovieDetail {
  const MovieDetailResponse({
      super.adult,
      super.backdropPath,
      super.budget,
      super.genres,
      super.homepage,
      super.id,
      super.imdbId,
      super.originalLanguage,
      super.originalTitle,
      super.overview,
      super.popularity,
      super.posterPath,
      super.productionCompanies,
      super.productionCountries,
      super.releaseDate,
      super.revenue,
      super.runtime,
      super.spokenLanguages,
      super.status,
      super.tagline,
      super.title,
      super.video,
      super.voteAverage,
      super.voteCount});

  factory MovieDetailResponse.fromRawJson(String jsonStr) =>
      MovieDetailResponse.fromMap(json.decode(jsonStr));

  String toRawJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {

    };
  }

  factory MovieDetailResponse.fromMap(Map<String, dynamic> map) {
    List<GenresResponse> genres = [];
    List<dynamic> genresJson = map['genres'];
    for (var genre in genresJson) {
      genres.add(GenresResponse.fromMap(genre));
    }

    return MovieDetailResponse(
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      budget: map['budget'],
      genres: genres,
      homepage: map['homepage'],
      id: map['id'],
      imdbId: map['imdb_id'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      //production_companies,
        // production_countries,
      releaseDate: map['release_date'],
      revenue: map['revenue'],
      runtime: map['runtime'],
      //spokenLanguagues: spoken_languages
      status: map['status'],
      tagline: map['tagline'],
      title: map['title'],
      video: map['video'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count']
    );
  }
}
