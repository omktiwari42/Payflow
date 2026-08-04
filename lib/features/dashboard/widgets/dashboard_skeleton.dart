import 'package:flutter/material.dart';

class DashboardSkeleton extends StatefulWidget {
  const DashboardSkeleton({super.key});

  @override
  State<DashboardSkeleton> createState() => _DashboardSkeletonState();
}

class _DashboardSkeletonState extends State<DashboardSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget skeleton({
    double? width,
    required double height,
    BorderRadius? radius,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: radius ?? BorderRadius.circular(12),
            color: Color.lerp(
              Colors.grey.shade300,
              Colors.grey.shade100,
              _controller.value,
            ),
          ),
        );
      },
    );
  }

  Widget transactionTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          skeleton(width: 54, height: 54, radius: BorderRadius.circular(27)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                skeleton(width: 150, height: 15),
                const SizedBox(height: 10),
                skeleton(width: 95, height: 12),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              skeleton(width: 70, height: 15),
              const SizedBox(height: 8),
              skeleton(width: 55, height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget statCard() {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          skeleton(width: 28, height: 28, radius: BorderRadius.circular(14)),
          const Spacer(),
          skeleton(width: 70, height: 14),
          const SizedBox(height: 10),
          skeleton(width: 95, height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                children: [
                  skeleton(
                    width: 58,
                    height: 58,
                    radius: BorderRadius.circular(29),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      skeleton(width: 90, height: 12),
                      const SizedBox(height: 10),
                      skeleton(width: 170, height: 20),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Wallet Card
              skeleton(height: 215, radius: BorderRadius.circular(30)),

              const SizedBox(height: 26),

              /// Stats
              Row(
                children: [
                  Expanded(child: statCard()),
                  const SizedBox(width: 16),
                  Expanded(child: statCard()),
                ],
              ),

              const SizedBox(height: 32),

              skeleton(width: 170, height: 20),

              const SizedBox(height: 20),

              transactionTile(),
              transactionTile(),
              transactionTile(),
              transactionTile(),
            ],
          ),
        ),
      ),
    );
  }
}
