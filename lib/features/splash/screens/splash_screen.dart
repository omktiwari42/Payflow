import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../auth/screens/login_screen.dart';
import '../../auth/services/auth_api_service.dart';
import '../../navigation/screens/main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnimation = Tween<double>(
      begin: .6,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, .15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 4));

    final loggedIn = await AuthApiService.instance.isLoggedIn();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            loggedIn ? const MainNavigationScreen() : const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildLogo() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: .20),
              blurRadius: 45,
              spreadRadius: 4,
            ),
          ],
        ),
        child: const Icon(
          Icons.account_balance_wallet_rounded,
          color: Color(0xff2563EB),
          size: 80,
        ),
      ),
    );
  }

  Widget buildTitle() {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 46,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.8,
      ),
      child: AnimatedTextKit(
        totalRepeatCount: 1,
        isRepeatingAnimation: false,
        animatedTexts: [
          TypewriterAnimatedText(
            "PayFlow",
            speed: const Duration(milliseconds: 140),
            cursor: "",
          ),
        ],
      ),
    );
  }

  Widget buildSubtitle() {
    return const Text(
      "Fast • Secure • Smart",
      style: TextStyle(
        color: Colors.white70,
        fontSize: 17,
        letterSpacing: 1,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildLoader() {
    return Column(
      children: const [
        SizedBox(
          width: 34,
          height: 34,
          child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
        ),
        SizedBox(height: 18),
        Text(
          "Loading...",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff2563EB), Color(0xff1D4ED8), Color(0xff0F172A)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildLogo(),

                    const SizedBox(height: 38),

                    buildTitle(),

                    const SizedBox(height: 12),

                    buildSubtitle(),

                    const SizedBox(height: 60),

                    buildLoader(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
