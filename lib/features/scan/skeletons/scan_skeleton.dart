import 'package:flutter/material.dart';

class ScanSkeleton extends StatelessWidget {
  const ScanSkeleton({super.key});

  Widget _box({
    double height = 20,
    double width = double.infinity,
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            _box(width: 180, height: 28, radius: BorderRadius.circular(8)),

            const Spacer(),

            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (_) => Column(
                    children: [
                      _box(
                        width: 68,
                        height: 68,
                        radius: BorderRadius.circular(18),
                      ),
                      const SizedBox(height: 10),
                      _box(
                        width: 60,
                        height: 12,
                        radius: BorderRadius.circular(6),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
