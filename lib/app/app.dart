import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motiva',
      theme: AppTheme.light,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.initial,
    );
  }
}
