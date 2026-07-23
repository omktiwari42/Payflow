import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Payment Successful",
        "message": "₹2,500 sent to Rahul Sharma",
        "time": "2 min ago",
        "icon": Icons.check_circle,
        "color": Colors.green,
      },
      {
        "title": "Cashback Received",
        "message": "You earned ₹150 cashback",
        "time": "30 min ago",
        "icon": Icons.card_giftcard,
        "color": Colors.orange,
      },
      {
        "title": "Money Added",
        "message": "₹5,000 added from HDFC Bank",
        "time": "1 hour ago",
        "icon": Icons.account_balance_wallet,
        "color": Colors.blue,
      },
      {
        "title": "Security Alert",
        "message": "New login detected on your account",
        "time": "Yesterday",
        "icon": Icons.security,
        "color": Colors.red,
      },
      {
        "title": "Reward Unlocked",
        "message": "You unlocked a ₹250 Amazon Voucher",
        "time": "Yesterday",
        "icon": Icons.emoji_events,
        "color": Colors.amber,
      },
      {
        "title": "Bill Reminder",
        "message": "Electricity bill due tomorrow",
        "time": "2 days ago",
        "icon": Icons.receipt_long,
        "color": Colors.deepPurple,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Mark all read")),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: (notification["color"] as Color).withValues(
                    alpha: .15,
                  ),
                  child: Icon(
                    notification["icon"] as IconData,
                    color: notification["color"] as Color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification["title"] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification["message"] as String,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notification["time"] as String,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
