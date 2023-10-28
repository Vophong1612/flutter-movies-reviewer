import 'package:flutter/material.dart';
import 'package:flutter_movies_reviewer/data/network/constants.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';

class PopularWidgetItem extends StatelessWidget {
  const PopularWidgetItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {

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
        ],
      ),
    );
  }
}
