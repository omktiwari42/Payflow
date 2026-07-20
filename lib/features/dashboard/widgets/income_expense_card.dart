import 'package:flutter/material.dart';

class IncomeExpenseCard extends StatelessWidget {
  const IncomeExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    const double income = 125400;
    const double expense = 78200;
    const double savings = income - expense;
    const double progress = savings / income;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xff2563EB).withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: Color(0xff2563EB),
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Income & Expenses",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Monthly financial overview",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.green,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "+18%",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: _FinanceTile(
                  title: "Income",
                  amount: "₹1,25,400",
                  icon: Icons.arrow_downward_rounded,
                  color: Colors.green,
                  subtitle: "+12% this month",
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: _FinanceTile(
                  title: "Expenses",
                  amount: "₹78,200",
                  icon: Icons.arrow_upward_rounded,
                  color: Colors.red,
                  subtitle: "-5% this month",
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),
                    const Text(
            "Savings Progress",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xff2563EB),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹${savings.toStringAsFixed(0)} saved",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "${(progress * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Color(0xff2563EB),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffF8FAFC),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Colors.amber,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Great job! Your expenses are lower than your income this month. Keep saving to reach your financial goals.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FinanceTile extends StatelessWidget {
  final String title;
  final String amount;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _FinanceTile({
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}