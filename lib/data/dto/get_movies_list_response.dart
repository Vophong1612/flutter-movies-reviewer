import 'package:json_annotation/json_annotation.dart';

part 'get_movies_list_response.g.dart';

@JsonSerializable()
class GetMoviesListResponse {
  int? page;
  List<MovieResponse>? results;
  int? totalPages;
  int? totalResults;

  GetMoviesListResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory GetMoviesListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMoviesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMoviesListResponseToJson(this);
}

@JsonSerializable()
class MovieResponse {
  final int? id;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final bool? video;
  @JsonKey(name: 'vote_average')
  final num? voteAverage;
  final String? title;
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final bool? adult;
  final String? overview;
  @JsonKey(name: 'release_date')
  final String? releaseDate;

  const MovieResponse({
    this.id,
    this.voteCount,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
