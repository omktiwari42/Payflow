import 'package:flutter/material.dart';

class NotificationCenterCard extends StatelessWidget {
  const NotificationCenterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: const Color(0xffEF4444).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  color: Color(0xffEF4444),
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Notification Center",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Recent alerts and updates",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "5 New",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 28),

          const _NotificationTile(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: "Payment Successful",
            subtitle: "₹2,500 sent to Rahul",
            time: "2 min ago",
          ),

          const SizedBox(height: 18),

          const _NotificationTile(
            icon: Icons.warning_amber,
            iconColor: Colors.orange,
            title: "Electricity Bill Due",
            subtitle: "Due tomorrow",
            time: "15 min ago",
          ),

          const SizedBox(height: 18),

          const _NotificationTile(
            icon: Icons.card_giftcard,
            iconColor: Colors.purple,
            title: "Cashback Received",
            subtitle: "₹150 added to wallet",
            time: "1 hour ago",
          ),

          const SizedBox(height: 18),

          const _NotificationTile(
            icon: Icons.trending_up,
            iconColor: Colors.blue,
            title: "Investment Increased",
            subtitle: "Portfolio up 2.3% today",
            time: "Today",
          ),
                    const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xffEEF6FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xff2563EB),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "AI Alert: Your food expenses are 9% lower than last week. Keep this trend to save an extra ₹2,000 this month.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.done_all),
              label: const Text("Mark all as read"),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  const _NotificationTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: iconColor.withValues(alpha: 0.12),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}