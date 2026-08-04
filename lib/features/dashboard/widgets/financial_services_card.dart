import 'package:flutter/material.dart';

class FinancialServicesCard extends StatelessWidget {
  const FinancialServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "Loans", "icon": Icons.account_balance, "color": Colors.blue},
      {
        "title": "Insurance",
        "icon": Icons.health_and_safety,
        "color": Colors.green,
      },
      {
        "title": "Credit Score",
        "icon": Icons.analytics,
        "color": Colors.orange,
      },
      {"title": "Invest", "icon": Icons.trending_up, "color": Colors.purple},
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
            "Financial Services",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              return InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 72,
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
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
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
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
