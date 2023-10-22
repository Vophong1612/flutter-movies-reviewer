import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/data/network/api/api.dart';
import 'package:flutter_movies_reviewer/data/repository/movie_repository_imp.dart';
import 'package:flutter_movies_reviewer/data/use_cases.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_movies_reviewer/presentation/router/app_router.dart';
import 'package:flutter_movies_reviewer/presentation/theme.dart';

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

    final api = ApiImp();
    final movieRepository = MovieRepositoryImp(api: api);
    final getPopularMoviesUseCase =
    GetPopularMoviesUseCase(movieRepository: movieRepository);

    useCases = UseCases(getPopularMoviesUseCase: getPopularMoviesUseCase);
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
