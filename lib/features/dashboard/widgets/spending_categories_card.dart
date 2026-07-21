import 'package:flutter/material.dart';

class SpendingCategoriesCard extends StatelessWidget {
  const SpendingCategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "title": "Food",
        "amount": "₹18,400",
        "progress": 0.82,
        "color": const Color(0xff2563EB),
        "icon": Icons.restaurant_rounded,
      },
      {
        "title": "Shopping",
        "amount": "₹12,150",
        "progress": 0.58,
        "color": const Color(0xffEC4899),
        "icon": Icons.shopping_bag_rounded,
      },
      {
        "title": "Travel",
        "amount": "₹9,800",
        "progress": 0.45,
        "color": const Color(0xff10B981),
        "icon": Icons.flight_takeoff_rounded,
      },
      {
        "title": "Bills",
        "amount": "₹6,900",
        "progress": 0.31,
        "color": const Color(0xffF59E0B),
        "icon": Icons.receipt_long_rounded,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Spending Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text("View All")),
            ],
          ),

          const SizedBox(height: 20),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final item = categories[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: (item["color"] as Color).withValues(
                            alpha: 0.12,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          item["icon"] as IconData,
                          color: item["color"] as Color,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["amount"] as String,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        "${((item["progress"] as double) * 100).toInt()}%",
                        style: TextStyle(
                          color: item["color"] as Color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: item["progress"] as double,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        item["color"] as Color,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.insights_rounded, color: Color(0xff2563EB)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Food and Shopping account for most of your spending this month. Consider setting a budget to improve your savings.",
                    style: TextStyle(fontSize: 14, height: 1.5),
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
