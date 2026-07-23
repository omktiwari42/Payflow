import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewards = [
      {
        "title": "Cashback Earned",
        "subtitle": "Received on Wallet Transfer",
        "amount": "+ ₹150",
        "icon": Icons.account_balance_wallet,
        "color": Colors.green,
      },
      {
        "title": "Amazon Voucher",
        "subtitle": "Reward for 10 Transactions",
        "amount": "₹250",
        "icon": Icons.card_giftcard,
        "color": Colors.orange,
      },
      {
        "title": "Movie Coupon",
        "subtitle": "BookMyShow Offer",
        "amount": "50% OFF",
        "icon": Icons.movie,
        "color": Colors.red,
      },
      {
        "title": "Food Coupon",
        "subtitle": "Swiggy Reward",
        "amount": "₹100",
        "icon": Icons.restaurant,
        "color": Colors.deepOrange,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Rewards & Cashback",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF9800), Color(0xFFFFC107)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                Icon(Icons.emoji_events, size: 60, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  "Reward Points",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "12,540",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.redeem),
              label: const Text(
                "Redeem Rewards",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Recent Rewards",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          ...rewards.map(
            (reward) => Card(
              margin: const EdgeInsets.only(bottom: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: (reward["color"] as Color).withValues(alpha: 0.15),
                  child: Icon(
                    reward["icon"] as IconData,
                    color: reward["color"] as Color,
                  ),
                ),
                title: Text(
                  reward["title"] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(reward["subtitle"] as String),
                trailing: Text(
                  reward["amount"] as String,
                  style: TextStyle(
                    color: reward["color"] as Color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
