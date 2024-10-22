import 'package:dio/dio.dart';
import 'package:flutter_movies_reviewer/data/dto/get_movie_detail_response.dart';
import 'package:flutter_movies_reviewer/data/dto/get_movie_video_response.dart';
import 'package:flutter_movies_reviewer/data/dto/get_movies_list_response.dart';
import 'package:flutter_movies_reviewer/data/network/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_service.g.dart';

@RestApi(baseUrl: Constants.apiUrl)
abstract class MovieService {
  factory MovieService(Dio dio, {String? baseUrl}) = _MovieService;

  @GET('movie/popular')
  Future<GetMoviesListResponse> getPopularMovies(int page);

  @GET('movie/top_rated')
  Future<GetMoviesListResponse> getTopRatedMovies(int page);

  @GET('movie/{movie_id}')
  Future<MovieDetailResponse> getMovieDetail(@Path("movie_id") int movieId);

  @GET('movie/{movie_id}/recommendations')
  Future<GetMoviesListResponse> getRecommendMovies(@Path("movie_id") int movieId, int page);

  @GET('movie/{movie_id}/videos')
  Future<GetMovieVideoResponse> getMovieVideos(@Path("movie_id") int movieId);
}