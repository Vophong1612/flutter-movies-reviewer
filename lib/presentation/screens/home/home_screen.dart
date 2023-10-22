import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/data/use_cases.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/bloc/get_popular_movies/popular_movies_bloc.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/widgets/popular_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*List<Movie> movies = [
      Movie(
        releaseDate: "2023-07-03",
        title: "Sound of Freedom 1",
        posterPath: "/qA5kPYZA7FkVvqcEfJRoOy4kpHg.jpg",
        voteAverage: 7,
      ),
      Movie(
        releaseDate: "2023-07-04",
        title: "Sound of Freedom 2",
        posterPath: "/qA5kPYZA7FkVvqcEfJRoOy4kpHg.jpg",
        voteAverage: 6,
      ),
      Movie(
        releaseDate: "2023-07-05",
        title: "Sound of Freedom 3",
        posterPath: "/qA5kPYZA7FkVvqcEfJRoOy4kpHg.jpg",
        voteAverage: 9,
      ),
    ];*/
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider<PopularMoviesBloc>(
      create: (context) => PopularMoviesBloc(
          getPopularMoviesUseCase:
              context.read<UseCases>().getPopularMoviesUseCase)
        ..add(GetPopularMoviesEvent()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                /*Popular movies carousel */
                BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (popularMovieBlocContext, state) {
                    if (state is PopularMoviesSuccessState) {
                      return CarouselSlider(
                        items: state.movies
                            .map((mv) => PopularWidget(movie: mv))
                            .toList(),
                        options: CarouselOptions(
                          height: screenWidth > 500 ? 800 : 500,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (i, _) {},
                          scrollDirection: Axis.horizontal,
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
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          cs.secondaryContainer.withOpacity(0.8),
                          cs.secondaryContainer.withOpacity(0.6),
                          cs.secondaryContainer.withOpacity(0),
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular Movies",
                        style: ts.titleLarge!.copyWith(
                          color: cs.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
