import 'package:flutter/material.dart';

class CardsSkeleton extends StatelessWidget {
  const CardsSkeleton({super.key});

  Widget _box({
    required double height,
    required double width,
    BorderRadius? radius,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: radius ?? BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(28),
          ),
        ),

        const SizedBox(height: 28),

        Row(
          children: [
            Expanded(
              child: _box(
                height: 90,
                width: double.infinity,
                radius: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _box(
                height: 90,
                width: double.infinity,
                radius: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _box(
                height: 90,
                width: double.infinity,
                radius: BorderRadius.circular(18),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        ...List.generate(
          4,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
