import 'package:flutter/material.dart';

class ScanPayCard extends StatelessWidget {
  const ScanPayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Scan QR",
        "icon": Icons.qr_code_scanner_rounded,
        "color": Colors.blue,
      },
      {
        "title": "Nearby",
        "icon": Icons.storefront_rounded,
        "color": Colors.green,
      },
      {
        "title": "Merchants",
        "icon": Icons.store_mall_directory_rounded,
        "color": Colors.orange,
      },
      {
        "title": "Saved",
        "icon": Icons.bookmark_rounded,
        "color": Colors.purple,
      },
      {
        "title": "Favorites",
        "icon": Icons.favorite_rounded,
        "color": Colors.red,
      },
      {
        "title": "Offers",
        "icon": Icons.local_offer_rounded,
        "color": Colors.teal,
      },
      {
        "title": "Nearby ATM",
        "icon": Icons.atm_rounded,
        "color": Colors.indigo,
      },
      {"title": "All", "icon": Icons.apps_rounded, "color": Colors.grey},
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
            "Scan & Pay Nearby",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 82,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
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
