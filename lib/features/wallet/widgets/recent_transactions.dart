import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Recent Transactions",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 18),

        _TransactionTile(
          icon: Icons.shopping_bag,
          title: "Amazon",
          subtitle: "Shopping",
          amount: "- ₹2,499",
          color: Colors.orange,
        ),

        SizedBox(height: 12),

        _TransactionTile(
          icon: Icons.fastfood,
          title: "McDonald's",
          subtitle: "Food & Drinks",
          amount: "- ₹540",
          color: Colors.red,
        ),

        SizedBox(height: 12),

        _TransactionTile(
          icon: Icons.account_balance,
          title: "Salary",
          subtitle: "Monthly Credit",
          amount: "+ ₹45,000",
          color: Colors.green,
          isIncome: true,
        ),

        SizedBox(height: 12),

        _TransactionTile(
          icon: Icons.electric_bolt,
          title: "Electricity Bill",
          subtitle: "Utility",
          amount: "- ₹1,250",
          color: Colors.blue,
        ),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color color;
  final bool isIncome;

  const _TransactionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.color,
    this.isIncome = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 16),

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
                Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),

          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
