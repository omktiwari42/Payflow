import 'package:flutter/material.dart';

class BillsDueCard extends StatelessWidget {
  const BillsDueCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bills = [
      {
        "title": "Electricity",
        "subtitle": "Due Tomorrow",
        "amount": "₹1,450",
        "icon": Icons.bolt_rounded,
        "color": const Color(0xffF59E0B),
        "status": "Pending",
      },
      {
        "title": "Jio Fiber",
        "subtitle": "Due in 3 Days",
        "amount": "₹999",
        "icon": Icons.wifi_rounded,
        "color": const Color(0xff2563EB),
        "status": "Pending",
      },
      {
        "title": "Netflix",
        "subtitle": "Auto Pay",
        "amount": "₹649",
        "icon": Icons.movie_rounded,
        "color": const Color(0xffE11D48),
        "status": "Auto",
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
        children: [
          Row(
            children: [
              const Text(
                "Bills Due",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text("View All")),
            ],
          ),

          const SizedBox(height: 18),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bills.length,
            separatorBuilder: (_, _) => const Divider(height: 28),
            itemBuilder: (context, index) {
              final bill = bills[index];

              return Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: (bill["color"] as Color).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      bill["icon"] as IconData,
                      color: bill["color"] as Color,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bill["title"] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          bill["subtitle"] as String,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    bill["amount"] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: bill["status"] == "Pending"
                          ? Colors.orange.withValues(alpha: 0.12)
                          : Colors.green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      bill["status"] as String,
                      style: TextStyle(
                        color: bill["status"] == "Pending"
                            ? Colors.orange
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          const Divider(),

          const SizedBox(height: 20),

          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Due",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "₹3,098",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.payment_rounded),
                label: const Text("Pay Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2563EB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
