import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/data/use_cases.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/bloc/get_popular_movies/popular_movies_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/bloc/get_toprated_movies/toprated_movies_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/widgets/popular_movies/popular_widget.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/widgets/top_rated_movies/top_rated_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget content = screenWidth > 500
        ? const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: PopularWidget()),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TopRatedWidget(),
              )),
            ],
          )
        : const Column(
            children: [
              PopularWidget(),
              TopRatedWidget(),
            ],
          );

    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
          create: (popularMovieCtx) => PopularMoviesBloc(
              getPopularMoviesUseCase:
                  popularMovieCtx.read<UseCases>().getPopularMoviesUseCase)
            ..add(GetPopularMoviesEvent()),
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (topRatedMovieCtx) => TopRatedMoviesBloc(
              getTopRatedMoviesUseCase:
                  topRatedMovieCtx.read<UseCases>().getTopRatedMoviesUseCase)
            ..add(GetTopRatedMoviesEvent()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: content,
          ),
        ),
      ),
    );
  }
}
