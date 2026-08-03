import 'package:flutter/material.dart';

import 'transaction_tile.dart';

class LiveRecentTransactions extends StatelessWidget {
  final List<dynamic> transactions;

  const LiveRecentTransactions({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(
          children: [
            Icon(Icons.receipt_long_outlined, size: 50, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              "No recent transactions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 6),
            Text(
              "Your recent payments will appear here.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final t = transactions[index] as Map<String, dynamic>;

        return TransactionTile(
          title: t["note"]?.toString().isNotEmpty == true
              ? t["note"]
              : "Transaction",
          subtitle: t["created_at"]?.toString() ?? "",
          amount:
              "₹${double.tryParse(t["amount"].toString())?.toStringAsFixed(2) ?? "0.00"}",
          icon: Icons.swap_horiz,
          color: Colors.blue,
        );
      },
    );
  }
}
