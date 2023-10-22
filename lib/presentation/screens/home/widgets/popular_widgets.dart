import 'package:flutter/material.dart';
import 'package:flutter_movies_reviewer/data/network/constants.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/utils/custom_date_utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "${Constants.rootPosterPath}${movie.posterPath}",
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    cs.primary.withOpacity(0),
                    cs.primary.withOpacity(0.6),
                    cs.primary,
                  ],
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      movie.title ?? "",
                      style: ts.titleMedium?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      CustomDateUtils.formatToDDMMMYYYY(movie.releaseDate) ??
                          "",
                      style: ts.bodyMedium?.copyWith(
                        color: cs.onPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: movie.voteAverage == null
                              ? 0
                              : movie.voteAverage! / 2,
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
                          "${movie.voteAverage ?? 0}/10",
                          style: ts.bodyMedium?.copyWith(
                            color: cs.onPrimary,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
