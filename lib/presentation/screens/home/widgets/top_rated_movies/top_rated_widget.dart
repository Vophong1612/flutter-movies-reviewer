import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/bloc/get_toprated_movies/toprated_movies_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/widgets/top_rated_movies/top_rated_widget_item.dart';

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return SizedBox(
      height: 400,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: Text(
              "TopRated Movies",
              style: ts.titleLarge!.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: (_, state) {
              if (state is TopRatedSuccessState) {
                if (state.movies.isEmpty) {
                  return const Center(
                    child: Text(
                      "Top rated movies is not available, please try again later !",
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return _Content(movies: state.movies);
                }
              } else if (state is TopRatedMoviesFailureState) {
                return Center(
                  child: Text(
                    "Some thing went wrong: \n${state.exception.toString()}",
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({required this.movies});

  final List<Movie> movies;

  @override
  State<_Content> createState() {
    return __ContentState();
  }
}

class __ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10,),
        itemBuilder: (ctx, index) {
          return TopRatedWidgetItem(
            movie: widget.movies[index],
          );
        },
        itemCount: widget.movies.length,
      ),
    );
  }
}
