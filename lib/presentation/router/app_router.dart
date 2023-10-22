import 'package:flutter/material.dart';
import 'package:flutter_movies_reviewer/presentation/screens/home/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) =>const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
