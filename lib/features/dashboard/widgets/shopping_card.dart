import 'package:flutter/material.dart';

class ShoppingCard extends StatelessWidget {
  const ShoppingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Amazon",
        "icon": Icons.shopping_bag_rounded,
        "color": Colors.orange,
      },
      {
        "title": "Flipkart",
        "icon": Icons.storefront_rounded,
        "color": Colors.blue,
      },
      {"title": "Food", "icon": Icons.fastfood_rounded, "color": Colors.red},
      {
        "title": "Grocery",
        "icon": Icons.local_grocery_store_rounded,
        "color": Colors.green,
      },
      {
        "title": "Medicines",
        "icon": Icons.medical_services_rounded,
        "color": Colors.purple,
      },
      {
        "title": "Gift Cards",
        "icon": Icons.card_giftcard_rounded,
        "color": Colors.pink,
      },
      {
        "title": "Games",
        "icon": Icons.sports_esports_rounded,
        "color": Colors.indigo,
      },
      {"title": "More", "icon": Icons.apps_rounded, "color": Colors.teal},
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
            "Shopping & Mini Apps",
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
