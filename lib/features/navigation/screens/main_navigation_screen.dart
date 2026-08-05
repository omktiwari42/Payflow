import 'package:flutter/material.dart';

import '../../dashboard/screens/dashboard_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../scan/screens/scan_screen.dart';
import '../../wallet/screens/wallet_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final GlobalKey<DashboardScreenState> _dashboardKey =
      GlobalKey<DashboardScreenState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      DashboardScreen(key: _dashboardKey),
      const WalletScreen(),
      const ScanScreen(),
      const ProfileScreen(),
    ];
  }

  void _changePage(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      _dashboardKey.currentState?.refreshDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(index: _selectedIndex, children: _pages);
  }
}
