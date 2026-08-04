import 'package:flutter/material.dart';

class LoanServicesCard extends StatelessWidget {
  const LoanServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Personal Loan",
        "icon": Icons.account_balance_wallet_rounded,
        "color": Colors.blue,
      },
      {
        "title": "Pay Later",
        "icon": Icons.schedule_rounded,
        "color": Colors.orange,
      },
      {
        "title": "Credit Card",
        "icon": Icons.credit_card_rounded,
        "color": Colors.red,
      },
      {
        "title": "Gold Loan",
        "icon": Icons.workspace_premium_rounded,
        "color": Colors.amber,
      },
      {"title": "EMI", "icon": Icons.payments_rounded, "color": Colors.green},
      {
        "title": "Mutual Fund",
        "icon": Icons.trending_up_rounded,
        "color": Colors.purple,
      },
      {
        "title": "Fixed Deposit",
        "icon": Icons.savings_rounded,
        "color": Colors.teal,
      },
      {
        "title": "More",
        "icon": Icons.more_horiz_rounded,
        "color": Colors.indigo,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Loans & Credit",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
              mainAxisExtent: 82,
            ),
            itemBuilder: (_, index) {
              final item = items[index];

              return InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: (item["color"] as Color).withOpacity(
                        .12,
                      ),
                      child: Icon(
                        item["icon"] as IconData,
                        color: item["color"] as Color,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item["title"] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
