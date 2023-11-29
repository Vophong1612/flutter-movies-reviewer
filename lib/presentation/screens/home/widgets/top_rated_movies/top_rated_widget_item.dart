import 'package:flutter/material.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/utils/custom_date_utils.dart';
import 'package:flutter_movies_reviewer/domain/utils/image_utils.dart';
import 'package:flutter_movies_reviewer/presentation/router/navigator_utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TopRatedWidgetItem extends StatelessWidget {
  const TopRatedWidgetItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return SizedBox(
      width: 150,
      height: 350,
      child: GestureDetector(
        onTap: () {
          NavigatorUtils.instance.navigateToMovieDetailScreen(context, movie.id!);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(ImageUtils.getFullPosterPath(movie.posterPath)),
            Text(
              movie.title ?? "",
              style: ts.titleMedium?.copyWith(
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            RatingBarIndicator(
              rating: movie.voteAverage == null
                  ? 0
                  : movie.voteAverage! / 2,
              itemCount: 5,
              itemSize: 15,
              itemBuilder: (ctx, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            Text(
              CustomDateUtils.formatToDDMMMYYYY(
                  movie.releaseDate) ??
                  "",
              style: ts.bodyMedium?.copyWith(
                color: cs.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}