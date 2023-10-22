import 'package:equatable/equatable.dart';

class Movie extends Equatable {

  final int? id;
  final int? voteCount;
  final bool? video;
  final num? voteAverage;
  final String? title;
  final double? popularity;
  final String? posterPath;
  final String? originalLanguage;
  final String? originalTitle;
  final List<int>? genreIds;
  final String? backdropPath;
  final bool? adult;
  final String? overview;
  final String? releaseDate;

  @override
  List<Object?> get props => [
        id,
        voteCount,
        video,
        voteAverage,
        title,
        popularity,
        posterPath,
        originalLanguage,
        originalTitle,
        genreIds,
        backdropPath,
        adult,
        overview,
        releaseDate
      ];

  const Movie({
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

  @override
  String toString() {
    return 'Movie{ id: $id, voteCount: $voteCount, video: $video, voteAverage: $voteAverage, title: $title, popularity: $popularity, posterPath: $posterPath, originalLanguage: $originalLanguage, originalTitle: $originalTitle, genreIds: $genreIds, backdropPath: $backdropPath, adult: $adult, overview: $overview, releaseDate: $releaseDate,}';
  }

  Movie copyWith({
    int? id,
    int? voteCount,
    bool? video,
    num? voteAverage,
    String? title,
    double? popularity,
    String? posterPath,
    String? originalLanguage,
    String? originalTitle,
    List<int>? genreIds,
    String? backdropPath,
    bool? adult,
    String? overview,
    String? releaseDate,
  }) {
    return Movie(
      id: id ?? this.id,
      voteCount: voteCount ?? this.voteCount,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      title: title ?? this.title,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      genreIds: genreIds ?? this.genreIds,
      backdropPath: backdropPath ?? this.backdropPath,
      adult: adult ?? this.adult,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }
}
