import 'package:flutter/material.dart';

class BillSkeleton extends StatefulWidget {
  const BillSkeleton({super.key});

  @override
  State<BillSkeleton> createState() => _BillSkeletonState();
}

class _BillSkeletonState extends State<BillSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.35, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _box({
    required double height,
    required double width,
    BorderRadius? radius,
  }) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: radius ?? BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _card() {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                _box(height: 52, width: 52, radius: BorderRadius.circular(26)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(height: 18, width: 150),
                      const SizedBox(height: 10),
                      _box(height: 14, width: 100),
                    ],
                  ),
                ),
                _box(height: 28, width: 70),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _box(height: 14, width: 110),
                const Spacer(),
                _box(height: 20, width: 80),
              ],
            ),
            const SizedBox(height: 18),
            _box(height: 46, width: double.infinity),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (_, __) => _card(),
    );
  }
}
