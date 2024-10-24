import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movies_reviewer/data/network/constants.dart';
import 'package:flutter_movies_reviewer/data/network/datasources/movie_service.dart';
import 'package:flutter_movies_reviewer/data/repository/movie_repository_imp.dart';
import 'package:flutter_movies_reviewer/data/use_cases.dart';
import 'package:flutter_movies_reviewer/domain/repository/movie_repository.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_movie_detail_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_movie_videos_use_case.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_recommend_movies_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/bloc/get_toprated_movies/toprated_movies_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/movie_detail/bloc/get_movie_detail/movie_detail_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/movie_detail/bloc/get_movie_trailer/get_movie_trailer_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/movie_detail/bloc/recommend_movies/recommend_movies_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'presentation/screens/home/bloc/get_popular_movies/popular_movies_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton<Logger>(
    () => Logger(),
  );

  locator.registerLazySingleton<Dio>(() {
    final logger = locator<Logger>();

    String apiUrl = dotenv.env[Constants.apiUrl] ?? '';

    return Dio(
      BaseOptions(
        baseUrl: apiUrl,
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
      ),
    )..interceptors.add(
        InterceptorsWrapper(onRequest: (options, handler) async {
          String appToken = dotenv.env[Constants.appToken] ?? '';
          options.headers[Constants.authorizationKey] = 'Bearer $appToken';

          logger.d('Method: ${options.method}');
          logger.d('Header: ${options.headers}');
          if (options.data != null) {
            logger.d('Body: ${options.data}');
          }
          return handler.next(options);
        }, onError: (error, handler) {
          logger.e('Dio Error', error: error);
          handler.next(error);
        }),
      );
  });

  locator.registerLazySingleton<MovieService>(() {
    final movieDio = locator<Dio>();
    return MovieService(movieDio);
  });

  locator.registerLazySingleton<MovieRepository>(() {
    final api = locator<MovieService>();
    return MovieRepositoryImp(api: api);
  });

  locator.registerLazySingleton<UseCases>(() {
    final movieRepository = locator<MovieRepository>();

    final getPopularMoviesUseCase = GetPopularMoviesUseCase(movieRepository: movieRepository);
    final getTopRatedMovieUseCase = GetTopRatedMoviesUseCase(movieRepository: movieRepository);
    final getMovieDetailUseCase = GetMovieDetailUseCase(movieRepository: movieRepository);
    final getRecommendMoviesUseCase = GetRecommendMoviesUseCase(movieRepository: movieRepository);
    final getMovieVideosUseCase = GetMovieVideosUseCase(movieRepository: movieRepository);

    return UseCases(
      getPopularMoviesUseCase: getPopularMoviesUseCase,
      getTopRatedMoviesUseCase: getTopRatedMovieUseCase,
      getMovieDetailUseCase: getMovieDetailUseCase,
      getRecommendMoviesUseCase: getRecommendMoviesUseCase,
      getMovieVideosUseCase: getMovieVideosUseCase,
    );
  });

  locator.registerFactory<PopularMoviesBloc>(() {
    final getPopularMoviesUseCase = locator<UseCases>().getPopularMoviesUseCase;
    return PopularMoviesBloc(getPopularMoviesUseCase);
  });

  locator.registerFactory<TopRatedMoviesBloc>(() {
    final getTopRatedMoviesUseCase = locator<UseCases>().getTopRatedMoviesUseCase;
    return TopRatedMoviesBloc(getTopRatedMoviesUseCase);
  });

  locator.registerFactory<GetMovieDetailBloc>(() {
    final getMovieDetailUseCase = locator<UseCases>().getMovieDetailUseCase;
    return GetMovieDetailBloc(getMovieDetailUseCase);
  });

  locator.registerFactory<GetRecommendMoviesBloc>(() {
    final getRecommendMoviesUseCase = locator<UseCases>().getRecommendMoviesUseCase;
    return GetRecommendMoviesBloc(getRecommendMoviesUseCase);
  });

  locator.registerFactory<GetMovieTrailerBloc>(() {
    final getMovieVideosUseCase = locator<UseCases>().getMovieVideosUseCase;
    return GetMovieTrailerBloc(getMovieVideosUseCase);
  });
}
