import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/data/use_cases.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/bloc/get_popular_movies/popular_movies_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/widgets/popular_movies/popular_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopularMoviesBloc>(
      create: (context) => PopularMoviesBloc(
          getPopularMoviesUseCase:
              context.read<UseCases>().getPopularMoviesUseCase)
        ..add(GetPopularMoviesEvent()),
      child: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PopularWidget()
              ],
            )
          ),
        ),
      ),
    );
  }
}
