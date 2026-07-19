import 'package:flutter/material.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/splash/screens/splash_screen.dart';

class AppRouter {
  static const splash = '/';
  static const login = '/login';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        login: (_) => const LoginScreen(),
      };
}