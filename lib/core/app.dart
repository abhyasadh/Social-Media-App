import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/navigation/navigation_service.dart';
import '../config/routes/app_routes.dart';
import '../config/themes/app_theme.dart';
import '../features/bottom_navigation/nav_view_model.dart';
import 'common/provider/is_dark_theme.dart';

class App extends ConsumerStatefulWidget {
  final Map<String, dynamic>? data;

  const App({this.data, super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(navViewModelProvider.notifier).updateUser(data: widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);

    return MaterialApp(
      title: 'Yaallo',
      debugShowCheckedModeBanner: false,
      navigatorKey: ref.read(navigationServiceProvider).navigatorKey,
      theme: AppTheme.getApplicationTheme(isDarkTheme),
      initialRoute: widget.data == null ? AppRoutes.loginRoute : AppRoutes.splashRoute,
      routes: AppRoutes.getApplicationRoute(),
    );
  }
}
