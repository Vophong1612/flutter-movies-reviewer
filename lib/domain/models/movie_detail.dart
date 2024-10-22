import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/genres.dart';
import 'package:flutter_movies_reviewer/domain/models/production_companies.dart';
import 'package:flutter_movies_reviewer/domain/models/production_countries.dart';
import 'package:flutter_movies_reviewer/domain/models/spoken_languages.dart';

class MovieDetail extends Equatable {
  const MovieDetail({
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [id];

  String get genresText {
    if (genres == null) return "";

    String result = "";
    for (int i = 0; i < genres!.length; i++) {
      if (i == 0) {
        result += "${genres![i].name ?? ""},";
      } else if (i == genres!.length - 1) {
        result += " ${genres![i].name ?? ""}";
      } else {
        result += " ${genres![i].name ?? ""},";
      }
    }
    return result;
  }
}
