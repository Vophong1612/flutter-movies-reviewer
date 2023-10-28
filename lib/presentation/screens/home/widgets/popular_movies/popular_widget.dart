import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/utils/custom_date_utils.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/bloc/get_popular_movies/popular_movies_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/widgets/popular_movies/popular_widgets_item.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return Stack(
      children: [
        /*Popular movies carousel */
        BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (popularMovieBlocContext, state) {
            if (state is PopularMoviesSuccessState) {
              if (state.movies.isEmpty) {
                return const Center(
                  child: Text(
                    "Popular movies is not available, please try again later !",
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return _Content(movies: state.movies);
              }
            } else if (state is PopularMoviesFailureState) {
              return SizedBox(
                height: screenWidth > 500 ? 800 : 500,
                child: Center(
                  child: Text(
                    "Some thing went wrong: \n${state.exception.toString()}",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: screenWidth > 500 ? 800 : 500,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),

        /* Popular movies title */
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  cs.background.withOpacity(0.8),
                  cs.background.withOpacity(0.6),
                  cs.background.withOpacity(0),
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Popular Movies",
                style: ts.titleLarge!.copyWith(
                  color: cs.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key, required this.movies});

  final List<Movie> movies;

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {

  late Movie _currentMovie;

  void _updateCurrentMovie(Movie movie) {
    setState(() {
      _currentMovie = movie;
    });
  }

  @override
  void initState() {
    _currentMovie = widget.movies.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return Column(
      children: [
        CarouselSlider(
          items:
              widget.movies.map((mv) => PopularWidgetItem(movie: mv)).toList(),
          options: CarouselOptions(
            height: screenWidth > 500 ? 500 : 440,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, _) {
              _updateCurrentMovie(widget.movies[index]);
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                cs.primaryContainer.withOpacity(0),
                cs.primaryContainer.withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _currentMovie.title ?? "",
                  style: ts.titleMedium?.copyWith(
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Row(
                          children: [
                            RatingBarIndicator(
                              rating: _currentMovie.voteAverage == null
                                  ? 0
                                  : _currentMovie.voteAverage! / 2,
                              itemCount: 5,
                              itemSize: 25,
                              itemBuilder: (ctx, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${_currentMovie.voteAverage ?? 0}/10",
                              style: ts.bodyMedium?.copyWith(
                                color: cs.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Text(
                          CustomDateUtils.formatToDDMMMYYYY(
                                  _currentMovie.releaseDate) ??
                              "",
                          style: ts.bodyMedium?.copyWith(
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
