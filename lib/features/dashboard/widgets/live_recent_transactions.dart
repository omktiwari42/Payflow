import 'package:flutter/material.dart';

import 'transaction_tile.dart';

class LiveRecentTransactions extends StatelessWidget {
  final List<dynamic> transactions;

  const LiveRecentTransactions({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Recent Activity",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(55, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text("View All"),
              ),
            ],
          ),

          const SizedBox(height: 10),

          if (transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xffEEF4FF),
                    child: Icon(
                      Icons.receipt_long_outlined,
                      color: Color(0xff2563EB),
                      size: 24,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "No Recent Transactions",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Payments will appear here.",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length > 5 ? 5 : transactions.length,
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemBuilder: (_, index) {
                final t = transactions[index] as Map<String, dynamic>;

                final amount = double.tryParse(t["amount"].toString()) ?? 0;

                final type = (t["transaction_type"] ?? "")
                    .toString()
                    .toLowerCase();

                final credit =
                    type == "credit" ||
                    type == "received" ||
                    type == "add_money";

                return TransactionTile(
                  title: (t["note"]?.toString().isNotEmpty ?? false)
                      ? t["note"].toString()
                      : "Payment",
                  subtitle: t["created_at"]?.toString() ?? "",
                  amount: "${credit ? '+' : '-'}₹${amount.toStringAsFixed(2)}",
                  icon: credit
                      ? Icons.south_west_rounded
                      : Icons.north_east_rounded,
                  color: credit ? Colors.green : Colors.red,
                );
              },
            ),
        ],
      ),
    );
  }
}
