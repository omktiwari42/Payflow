import 'package:flutter/material.dart';

import '../../dashboard/screens/dashboard_screen.dart';
import '../../dashboard/widgets/payflow_bottom_navbar.dart';
import '../../profile/screens/profile_screen.dart';
import '../../scan/screens/scan_screen.dart';
import '../../search/screens/search_screen.dart';
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
      DashboardScreen(key: _dashboardKey), // Home
      const WalletScreen(), // Wallet
      const ScanScreen(), // Scan
      const SearchScreen(), // Search
      const ProfileScreen(), // Profile
    ];
  }

  void _changePage(int index) {
    if (_selectedIndex == index) {
      if (index == 0) {
        _dashboardKey.currentState?.refreshDashboard();
      }
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      _dashboardKey.currentState?.refreshDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: PayflowBottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _changePage,
      ),
    );
  }
}
