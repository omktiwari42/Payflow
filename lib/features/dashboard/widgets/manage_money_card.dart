import 'package:flutter/material.dart';

class ManageMoneyCard extends StatelessWidget {
  const ManageMoneyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Wallet",
        "icon": Icons.account_balance_wallet_rounded,
        "color": Colors.blue,
      },
      {
        "title": "Bank",
        "icon": Icons.account_balance_rounded,
        "color": Colors.green,
      },
      {
        "title": "Passbook",
        "icon": Icons.menu_book_rounded,
        "color": Colors.orange,
      },
      {
        "title": "Rewards",
        "icon": Icons.card_giftcard_rounded,
        "color": Colors.pink,
      },
      {
        "title": "AutoPay",
        "icon": Icons.autorenew_rounded,
        "color": Colors.purple,
      },
      {"title": "Security", "icon": Icons.shield_rounded, "color": Colors.red},
      {
        "title": "Support",
        "icon": Icons.support_agent_rounded,
        "color": Colors.teal,
      },
      {
        "title": "Settings",
        "icon": Icons.settings_rounded,
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
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Manage Money",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(55, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text("View All"),
              ),
            ],
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
              mainAxisExtent: 84,
            ),
            itemBuilder: (_, index) {
              final item = items[index];

              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: (item["color"] as Color).withOpacity(
                        .12,
                      ),
                      child: Icon(
                        item["icon"] as IconData,
                        color: item["color"] as Color,
                        size: 25,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      item["title"] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
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
