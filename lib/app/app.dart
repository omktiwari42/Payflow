import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/help_support/help_support_routes.dart';
import '../features/navigation/screens/main_navigation_screen.dart';

class PayFlowApp extends StatelessWidget {
  const PayFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // Start the app with Login Screen
      home: const LoginScreen(),

      routes: {
        ...HelpSupportRoutes.routes,

        "/dashboard": (_) => const MainNavigationScreen(),
      },
    );
  }
}
