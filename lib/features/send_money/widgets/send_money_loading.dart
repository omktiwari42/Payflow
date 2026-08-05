import 'package:flutter/material.dart';

class SendMoneyLoading extends StatelessWidget {
  const SendMoneyLoading({super.key});

  Widget _box({
    required double width,
    required double height,
    double radius = 12,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 20),

        _box(width: double.infinity, height: 60, radius: 18),

        const SizedBox(height: 24),

        Row(
          children: List.generate(
            4,
            (_) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: _box(width: double.infinity, height: 90, radius: 18),
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        _box(width: 150, height: 22),

        const SizedBox(height: 20),

        ...List.generate(
          6,
          (_) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(width: 160, height: 16),

                      const SizedBox(height: 10),

                      _box(width: 90, height: 12),
                    ],
                  ),
                ),

                _box(width: 26, height: 26, radius: 13),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
