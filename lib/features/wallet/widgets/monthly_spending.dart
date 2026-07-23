import 'package:flutter/material.dart';

class MonthlySpending extends StatelessWidget {
  const MonthlySpending({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Monthly Spending",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 18),

        SpendingTile(
          title: "Food & Dining",
          amount: "₹12,450",
          percentage: 75,
          color: Colors.orange,
          icon: Icons.restaurant,
        ),

        SizedBox(height: 14),

        SpendingTile(
          title: "Shopping",
          amount: "₹8,230",
          percentage: 58,
          color: Colors.purple,
          icon: Icons.shopping_bag,
        ),

        SizedBox(height: 14),

        SpendingTile(
          title: "Transport",
          amount: "₹4,180",
          percentage: 40,
          color: Colors.blue,
          icon: Icons.directions_car,
        ),

        SizedBox(height: 14),

        SpendingTile(
          title: "Entertainment",
          amount: "₹2,900",
          percentage: 28,
          color: Colors.red,
          icon: Icons.movie,
        ),
      ],
    );
  }
}

class SpendingTile extends StatelessWidget {
  final String title;
  final String amount;
  final int percentage;
  final Color color;
  final IconData icon;

  const SpendingTile({
    super.key,
    required this.title,
    required this.amount,
    required this.percentage,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(amount, style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),

              Text(
                "$percentage%",
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 14),

          LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }
}
