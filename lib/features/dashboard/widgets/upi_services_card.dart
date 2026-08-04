import 'package:flutter/material.dart';

class UpiServicesCard extends StatelessWidget {
  const UpiServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        "title": "UPI ID",
        "icon": Icons.account_balance_wallet_rounded,
        "color": Colors.blue,
      },
      {
        "title": "Bank",
        "icon": Icons.account_balance_rounded,
        "color": Colors.green,
      },
      {"title": "Passbook", "icon": Icons.book_rounded, "color": Colors.orange},
      {
        "title": "AutoPay",
        "icon": Icons.autorenew_rounded,
        "color": Colors.purple,
      },
      {"title": "QR Code", "icon": Icons.qr_code_rounded, "color": Colors.red},
      {"title": "History", "icon": Icons.history_rounded, "color": Colors.teal},
      {
        "title": "Mandates",
        "icon": Icons.assignment_turned_in_rounded,
        "color": Colors.indigo,
      },
      {
        "title": "Settings",
        "icon": Icons.settings_rounded,
        "color": Colors.grey,
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
            "UPI & Banking",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 82,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (_, index) {
              final item = services[index];

              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
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
