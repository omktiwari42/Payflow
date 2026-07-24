import 'package:flutter/material.dart';

class SearchSkeleton extends StatelessWidget {
  const SearchSkeleton({super.key});

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
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _box(height: 56, radius: BorderRadius.circular(18)),

            const SizedBox(height: 24),

            Row(
              children: List.generate(
                4,
                (_) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _box(
                    height: 38,
                    width: 80,
                    radius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            _box(height: 24, width: 180),

            const SizedBox(height: 16),

            ...List.generate(
              5,
              (_) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      _box(
                        height: 50,
                        width: 50,
                        radius: BorderRadius.circular(14),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _box(height: 16, width: 160),
                            const SizedBox(height: 8),
                            _box(height: 12, width: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            _box(height: 24, width: 170),

            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (_, _) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _box(
                          height: 56,
                          width: 56,
                          radius: BorderRadius.circular(28),
                        ),
                        const SizedBox(height: 14),
                        _box(height: 14, width: 90),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
