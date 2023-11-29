import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/data/use_cases.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';
import 'package:flutter_movies_reviewer/domain/utils/image_utils.dart';
import 'package:flutter_movies_reviewer/domain/utils/number_utils.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/widgets/top_rated_movies/top_rated_widget_item.dart';
import 'package:flutter_movies_reviewer/presentation/screens/movie_detail/bloc/get_movie_detail/movie_detail_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailArguments {
  final int movieId;

  const MovieDetailArguments({required this.movieId});
}

class MovieDetailWidget extends StatelessWidget {
  const MovieDetailWidget({super.key, required this.movieId});

  static const route = '/movie-detail';
  final int movieId;

  @override
  Widget build(BuildContext context) {
    print('movie detail build');
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return BlocProvider<GetMovieDetailBloc>(
      create: (ctx) => GetMovieDetailBloc(
          getMovieDetailUseCase: ctx.read<UseCases>().getMovieDetailUseCase)
        ..add(GetMovieDetailEvent(movieId: movieId)),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<GetMovieDetailBloc, GetMovieDetailState>(
                builder: (BuildContext context, GetMovieDetailState state) {
                  if (state is GetMovieDetailSuccessState) {
                    final movie = state.movieDetail;
                    return _Content(movieDetail: movie);
                  } else if (state is GetMovieDetailFailureState) {
                    return Center(
                      child: Text(
                        state.exception.toString(),
                        style: ts.bodyMedium!.copyWith(color: cs.onBackground),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final MovieDetail movieDetail;

  const _Content({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          __ContentPoster(path: movieDetail.backdropPath),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: __ContentMovieInfo(movieDetail: movieDetail),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: __ContentOverview(
              overview: movieDetail.overview,
            ),
          ),
        ],
      ),
    );
  }
}

class __ContentPoster extends StatelessWidget {
  const __ContentPoster({super.key, required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Image.network(
          ImageUtils.getOriginalPath(path),
          height: 300,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Container(
              height: 300,
              color: cs.onSurfaceVariant,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (_, __, ___) {
            return Container(
              height: 300,
              color: cs.onSurfaceVariant,
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  cs.background.withOpacity(0),
                  cs.background.withOpacity(0.3),
                  cs.background,
                ])),
          ),
        )
      ],
    );
  }
}

class __ContentMovieInfo extends StatelessWidget {
  final MovieDetail movieDetail;

  const __ContentMovieInfo({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            ImageUtils.getFullPosterPath(movieDetail.posterPath),
            width: 120,
            fit: BoxFit.fill,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 120,
                color: cs.shadow,
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieDetail.title ?? "",
                          style: ts.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold, color: cs.primary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          movieDetail.genresText,
                          style:
                              ts.bodyMedium!.copyWith(color: cs.onBackground),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        RatingBarIndicator(
                          rating: movieDetail.voteAverage == null
                              ? 0
                              : movieDetail.voteAverage! / 2,
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
                          "${movieDetail.voteAverage != null ? (movieDetail.voteAverage! / 1).toPrecision(2) : 0}/10",
                          style: ts.bodyMedium?.copyWith(
                            color: cs.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class __ContentOverview extends StatefulWidget {
  final String? overview;

  const __ContentOverview({super.key, required this.overview});

  @override
  State<__ContentOverview> createState() {
    return ___ContentOverviewState();
  }
}

class ___ContentOverviewState extends State<__ContentOverview> {
  bool showMore = false;

  void _switchShowMore() {
    setState(() {
      showMore = !showMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview",
          style: ts.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
        ),
        GestureDetector(
          onTap: _switchShowMore,
          child: Text(
            widget.overview ?? "Movie has no overview.",
            style: ts.bodyMedium!.copyWith(color: cs.onBackground),
            maxLines: showMore ? null : 4,
            overflow: showMore ? null : TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}