import 'dart:convert';

import 'package:flutter_movies_reviewer/domain/models/movie_video.dart';

class MovieVideoResponse extends MovieVideo {
  const MovieVideoResponse({
    super.iso6391,
    super.iso31661,
    super.name,
    super.key,
    super.site,
    super.size,
    super.type,
    super.official,
    super.publishedAt,
    super.id,
  });

  factory MovieVideoResponse.fromRawJson(String jsonStr) => MovieVideoResponse.fromMap(json.decode(jsonStr));

  String toRawJson() => json.encode(toMap());

  factory MovieVideoResponse.fromMap(Map<String, dynamic> map) =>
      MovieVideoResponse(
        iso6391: map['iso_639_1'],
        iso31661: map['iso_3166_1'],
        name: map['name'],
        key: map['key'],
        site: map['site'],
        size: map['size'],
        type: map['type'],
        official: map['official'],
        publishedAt: map['published_at'],
        id: map['id'],
      );

  Map<String, dynamic> toMap() => {
        'iso_639_1': iso6391,
        'iso_3166_1': iso31661,
        'name': name,
        'key': key,
        'site': site,
        'size': size,
        'type': type,
        'official': official,
        'published_at': publishedAt,
        'id': id,
      };
}
