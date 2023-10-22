import 'package:flutter/material.dart';
import 'package:flutter_movies_reviewer/data/network/api/api.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_movies_reviewer/presentation/app_root.dart';
import 'package:flutter_movies_reviewer/presentation/router/app_router.dart';

import 'data/repository/movie_repository_imp.dart';

void main() {
  runApp(AppRoot());
}
