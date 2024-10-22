import 'package:json_annotation/json_annotation.dart';

part 'get_movie_video_response.g.dart';

@JsonSerializable()
class GetMovieVideoResponse {
  int? id;
  List<MovieVideoResponse>? results;

  GetMovieVideoResponse({
    this.id,
    this.results,
  });

  factory GetMovieVideoResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMovieVideoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMovieVideoResponseToJson(this);
}

@JsonSerializable()
class MovieVideoResponse {
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  @JsonKey(name: 'published_at')
  final String? publishedAt;
  final String? id;

  const MovieVideoResponse({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory MovieVideoResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieVideoResponseToJson(this);
}
