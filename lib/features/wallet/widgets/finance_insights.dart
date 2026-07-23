import 'package:flutter/material.dart';

class FinanceInsights extends StatelessWidget {
  const FinanceInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Finance Insights",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 18),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
          children: const [
            _InsightCard(
              title: "Monthly Savings",
              value: "₹18,540",
              icon: Icons.savings,
              color: Colors.green,
            ),
            _InsightCard(
              title: "Cashback Earned",
              value: "₹2,150",
              icon: Icons.card_giftcard,
              color: Colors.orange,
            ),
            _InsightCard(
              title: "Credit Score",
              value: "812",
              icon: Icons.star,
              color: Colors.blue,
            ),
            _InsightCard(
              title: "Spending Trend",
              value: "-12%",
              icon: Icons.trending_down,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _InsightCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color, size: 28),
          ),

          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
