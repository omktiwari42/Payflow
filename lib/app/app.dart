// import 'package:flutter/material.dart';

// import '../core/constants/app_constants.dart';
// import '../core/theme/app_theme.dart';
// import '../routes/app_router.dart';

// class PayFlowApp extends StatelessWidget {
//   const PayFlowApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: AppConstants.appName,
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       initialRoute: AppRouter.splash,
//       routes: AppRouter.routes,
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../features/dashboard/screens/dashboard_screen.dart';

class PayFlowApp extends StatelessWidget {
  const PayFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const DashboardScreen(),
    );
  }
}