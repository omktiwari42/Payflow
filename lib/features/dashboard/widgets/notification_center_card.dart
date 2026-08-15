import 'package:flutter/material.dart';

import '../../notifications/models/notification_model.dart';
import '../../notifications/services/notification_api_service.dart';
import '../../notifications/screens/notifications_screen.dart';

class NotificationCenterCard extends StatefulWidget {
  const NotificationCenterCard({super.key});

  @override
  State<NotificationCenterCard> createState() =>
      _NotificationCenterCardState();
}

class _NotificationCenterCardState extends State<NotificationCenterCard> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      final notifications =
      await NotificationApiService.instance.getNotifications();

      if (!mounted) return;

      setState(() {
        _notifications = notifications.take(4).toList();
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  IconData _getIcon(String type) {
    switch (type.toUpperCase()) {
      case "PAYMENT":
      case "TRANSACTION":
      case "SUCCESS":
        return Icons.check_circle;

      case "CASHBACK":
      case "REWARD":
        return Icons.card_giftcard;

      case "WALLET":
      case "MONEY_ADDED":
        return Icons.account_balance_wallet;

      case "SECURITY":
        return Icons.security;

      case "BILL":
        return Icons.receipt_long;

      case "WARNING":
        return Icons.warning_rounded;

      default:
        return Icons.notifications;
    }
  }

  Color _getColor(String type) {
    switch (type.toUpperCase()) {
      case "PAYMENT":
      case "TRANSACTION":
      case "SUCCESS":
        return Colors.green;

      case "CASHBACK":
      case "REWARD":
        return Colors.orange;

      case "WALLET":
      case "MONEY_ADDED":
        return Colors.blue;

      case "SECURITY":
        return Colors.red;

      case "BILL":
        return Colors.deepPurple;

      case "WARNING":
        return Colors.amber.shade800;

      default:
        return Colors.blue;
    }
  }

  String _formatTime(DateTime value) {
    final now = DateTime.now();
    final difference = now.difference(value);

    if (difference.inSeconds < 60) {
      return "Just now";
    }

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    }

    if (difference.inHours < 24) {
      return "${difference.inHours} hour"
          "${difference.inHours == 1 ? "" : "s"} ago";
    }

    if (difference.inDays == 1) {
      return "Yesterday";
    }

    if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    }

    return "${value.day.toString().padLeft(2, "0")}/"
        "${value.month.toString().padLeft(2, "0")}/"
        "${value.year}";
  }

  Future<void> _openNotifications() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NotificationsScreen(),
      ),
    );

    if (!mounted) return;

    await _loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount =
        _notifications
            .where((item) => !item.isRead)
            .length;

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
                  color:
                  Colors.red.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.red,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
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

              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Text(
                    unreadCount > 99
                        ? "99+ New"
                        : "$unreadCount New",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 24),

          if (_isLoading)
            const _NotificationCardSkeleton()
          else
            if (_notifications.isEmpty)
              const _EmptyNotifications()
            else
              ..._notifications.map(
                    (notification) =>
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 14),
                      child: _NotificationTile(
                        icon: _getIcon(notification.type),
                        iconColor:
                        _getColor(notification.type),
                        title: notification.title,
                        subtitle: notification.message,
                        time:
                        _formatTime(notification.createdAt),
                        isUnread: !notification.isRead,
                      ),
                    ),
              ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _openNotifications,
              icon: const Icon(Icons.arrow_forward),
              label: const Text("View all"),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NOTIFICATION TILE
// ============================================================

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;

  const _NotificationTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isUnread
            ? const Color(0xffF5F9FF)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                iconColor.withValues(alpha: 0.12),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),

              if (isUnread)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration:
                    const BoxDecoration(
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
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isUnread
                        ? FontWeight.bold
                        : FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Text(
            time,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EMPTY STATE
// ============================================================

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Column(
        children: [
          Icon(
            Icons.notifications_none,
            size: 42,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 10),
          Text(
            "No recent notifications",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LOADING SKELETON
// ============================================================

class _NotificationCardSkeleton extends StatelessWidget {
  const _NotificationCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
            (_) =>
            Container(
              height: 82,
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
      ),
    );
  }
}