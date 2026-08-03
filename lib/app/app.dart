import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/help_support/help_support_routes.dart';
import '../features/navigation/screens/main_navigation_screen.dart';
import '../features/splash/screens/splash_screen.dart';

class PayFlowApp extends StatelessWidget {
  const PayFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      home: SplashScreen(),

      routes: {
        "/login": (_) => const LoginScreen(),

        "/dashboard": (_) => const MainNavigationScreen(),

        ...HelpSupportRoutes.routes,
      },
    );
  }
}
