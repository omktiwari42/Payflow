import 'package:flutter/material.dart';

class HelpSupportSkeleton extends StatelessWidget {
  const HelpSupportSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _box(height: 180, radius: 28),

              const SizedBox(height: 20),

              _box(height: 55),

              const SizedBox(height: 24),

              const Text(
                "Loading Help & Support...",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (_, _) => _box(height: 120),
              ),

              const SizedBox(height: 25),

              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, _) => _box(width: 110, height: 110),
                ),
              ),

              const SizedBox(height: 25),

              _box(height: 170),

              const SizedBox(height: 20),

              _box(height: 220),

              const SizedBox(height: 20),

              _box(height: 180),

              const SizedBox(height: 20),

              _box(height: 170),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box({double? width, required double height, double radius = 20}) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
