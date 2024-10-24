import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/data/use_cases.dart';
import 'package:flutter_movies_reviewer/injection.dart';
import 'package:flutter_movies_reviewer/presentation/router/app_router.dart';
import 'package:flutter_movies_reviewer/presentation/theme.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final AppRouter appRouter;

  @override
  void initState() {
    appRouter = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();
    return RepositoryProvider.value(
      value: locator<UseCases>(),
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
