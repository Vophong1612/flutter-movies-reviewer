import 'package:flutter_movies_reviewer/data/dto/genres_response.dart';
import 'package:flutter_movies_reviewer/data/dto/get_movie_detail_response.dart';
import 'package:flutter_movies_reviewer/data/dto/get_movie_video_response.dart';
import 'package:flutter_movies_reviewer/data/dto/get_movies_list_response.dart';
import 'package:flutter_movies_reviewer/domain/models/genres.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_video.dart';

extension MovieParsing on MovieResponse {
  Movie toMovie() => Movie(
    id: id,
    voteCount: voteCount,
    video: video,
    voteAverage: voteAverage,
    title: title,
    popularity: popularity,
    posterPath: posterPath,
    originalLanguage: originalLanguage,
    originalTitle: originalTitle,
    genreIds: genreIds,
    backdropPath: backdropPath,
    adult: adult,
    overview: overview,
    releaseDate: releaseDate,
  );
}

extension MovieDetailParsing on MovieDetailResponse {
  MovieDetail toMovieDetail() => MovieDetail(
    adult: adult,
    backdropPath: backdropPath,
    budget: budget,
    genres: genres?.map((e) => e.toGenres()).toList() ?? [],
    homepage: homepage,
    id: id,
    imdbId: imdbId,
    originalLanguage: originalLanguage,
    originalTitle: originalTitle,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    releaseDate: releaseDate,
    revenue: revenue,
    runtime: runtime,
    status: status,
    tagline: tagline,
    title: title,
    video: video,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );
}

extension GenresParsing on GenreResponse {
  Genre toGenres() => Genre(
    id: id,
    name: name
  );
}

extension MovieVideoParsing on MovieVideoResponse {
  MovieVideo toMovieVideo() => MovieVideo(
    iso6391: iso6391,
    iso31661: iso31661,
    name: name,
    key: key,
    site: site,
    size: size,
    type: type,
    official: official,
    publishedAt: publishedAt,
    id: id,
  );
}