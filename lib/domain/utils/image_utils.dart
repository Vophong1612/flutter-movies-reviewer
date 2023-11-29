import 'package:flutter_movies_reviewer/data/network/constants.dart';

class ImageUtils {
  static String getFullPosterPath(String? posterPath) {
    return "${Constants.rootPosterPath}$posterPath";
  }

  static String getOriginalPath(String? path) {
    return "${Constants.rootOriginalPath}$path";
  }
}