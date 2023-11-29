import 'dart:convert';

import 'package:flutter_movies_reviewer/domain/models/genres.dart';

class GenresResponse extends Genres {
  const GenresResponse({super.id, super.name});
  factory GenresResponse.fromRawJson(String jsonStr) =>
      GenresResponse.fromMap(json.decode(jsonStr));

  String toRawJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory GenresResponse.fromMap(Map<String, dynamic> map) {
    return GenresResponse(
        id: map['id'],
        name: map['name']
    );
  }
}