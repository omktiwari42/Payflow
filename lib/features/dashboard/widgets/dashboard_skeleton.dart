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
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          skeleton(
            width: 56,
            height: 56,
            radius: BorderRadius.circular(28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                skeleton(width: 140, height: 16),
                const SizedBox(height: 10),
                skeleton(width: 90, height: 12),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              skeleton(width: 70, height: 16),
              const SizedBox(height: 8),
              skeleton(width: 60, height: 22),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          skeleton(width: 170, height: 28),

          const SizedBox(height: 24),

          skeleton(
            height: 215,
            radius: BorderRadius.circular(28),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: skeleton(
                  height: 140,
                  radius: BorderRadius.circular(22),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: skeleton(
                  height: 140,
                  radius: BorderRadius.circular(22),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          skeleton(width: 170, height: 24),

          const SizedBox(height: 18),

          transactionTile(),
          transactionTile(),
          transactionTile(),
          transactionTile(),
        ],
      ),
    );
  }
}