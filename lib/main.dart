import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movies_reviewer/presentation/app_root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const AppRoot());
}
