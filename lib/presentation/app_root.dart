import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movies_reviewer/data/network/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/data/network/datasources/movie_service.dart';
import 'package:flutter_movies_reviewer/data/repository/movie_repository_imp.dart';
import 'package:flutter_movies_reviewer/data/use_cases.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_movie_detail_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_movie_videos_use_case.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_recommend_movies_usecase.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:flutter_movies_reviewer/presentation/router/app_router.dart';
import 'package:flutter_movies_reviewer/presentation/theme.dart';
import 'package:logger/logger.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final AppRouter appRouter;
  late final UseCases useCases;

  @override
  void initState() {
    appRouter = AppRouter();

    final logger = Logger();

    String apiUrl = dotenv.env[Constants.apiUrl] ?? '';
    final movieDio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
      ),
    )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String appToken = dotenv.env[Constants.appToken] ?? '';
          options.headers[Constants.authorizationKey] = 'Bearer $appToken';

          logger.d('Method: ${options.method}');
          logger.d('Header: ${options.headers}');
          if (options.data != null) {
            logger.d('Body: ${options.data}');
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          logger.e('Dio Error', error: error);
          handler.next(error);
        }
      ),
    );
    final api = MovieService(movieDio);

    final movieRepository = MovieRepositoryImp(api: api);
    final getPopularMoviesUseCase =
        GetPopularMoviesUseCase(movieRepository: movieRepository);
    final getTopRatedMovieUseCase =
        GetTopRatedMoviesUseCase(movieRepository: movieRepository);
    final getMovieDetailUseCase =
        GetMovieDetailUseCase(movieRepository: movieRepository);
    final getRecommendMoviesUseCase =
        GetRecommendMoviesUseCase(movieRepository: movieRepository);
    final getMovieVideosUseCase =
        GetMovieVideosUseCase(movieRepository: movieRepository);

    useCases = UseCases(
      getPopularMoviesUseCase: getPopularMoviesUseCase,
      getTopRatedMoviesUseCase: getTopRatedMovieUseCase,
      getMovieDetailUseCase: getMovieDetailUseCase,
      getRecommendMoviesUseCase: getRecommendMoviesUseCase,
      getMovieVideosUseCase: getMovieVideosUseCase,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();
    return RepositoryProvider.value(
      value: useCases,
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
