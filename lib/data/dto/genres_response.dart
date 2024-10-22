import 'package:json_annotation/json_annotation.dart';

part 'genres_response.g.dart';

@JsonSerializable()
class GenreResponse {
  const GenreResponse({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory GenreResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenreResponseToJson(this);
}