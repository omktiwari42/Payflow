import 'package:flutter/material.dart';

class PromoBannerCard extends StatelessWidget {
  const PromoBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xff2563EB), Color(0xff4F46E5)],
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PayFlow Premium",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Unlimited cashback, instant rewards, exclusive offers and premium banking features.",
                  style: TextStyle(color: Colors.white70, height: 1.4),
                ),

                Spacer(),

                FilledButton(onPressed: null, child: Text("Explore")),
              ],
            ),
          ),

          SizedBox(width: 20),

          Icon(Icons.workspace_premium, color: Colors.amber, size: 80),
        ],
      ),
    );
  }
}
