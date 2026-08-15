import 'package:flutter/material.dart';

import '../models/notification_model.dart';
import '../services/notification_api_service.dart';
import '../../rewards/screens/rewards_screen.dart';
import '../../wallet/screens/wallet_screen.dart';
import 'notification_details_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationApiService _api = NotificationApiService.instance;

  List<NotificationModel> _notifications = [];

  bool _isLoading = true;
  bool _isMarkingAllRead = false;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  // ============================================================
  // LOAD NOTIFICATIONS
  // ============================================================

  Future<void> _loadNotifications() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final notifications = await _api.getNotifications();

      if (!mounted) return;

      setState(() {
        _notifications = notifications;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _showError(e);
    }
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> _refresh() async {
    try {
      final notifications = await _api.getNotifications();

      if (!mounted) return;

      setState(() {
        _notifications = notifications;
      });
    } catch (e) {
      if (!mounted) return;

      _showError(e);
    }
  }

  // ============================================================
  // MARK ALL AS READ
  // ============================================================

  Future<void> _markAllAsRead() async {
    final hasUnread = _notifications.any((item) => !item.isRead);

    if (_isMarkingAllRead || !hasUnread) {
      return;
    }

    setState(() {
      _isMarkingAllRead = true;
    });

    try {
      await _api.markAllAsRead();

      if (!mounted) return;

      setState(() {
        _notifications = _notifications
            .map((notification) => notification.copyWith(isRead: true))
            .toList();

        _isMarkingAllRead = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isMarkingAllRead = false;
      });

      _showError(e);
    }
  }

  // ============================================================
  // MARK SINGLE AS READ
  // ============================================================

  Future<void> _markAsRead(NotificationModel notification) async {
    if (notification.isRead) {
      return;
    }

    try {
      await _api.markAsRead(notification.id);

      if (!mounted) return;

      final index = _notifications.indexWhere(
        (item) => item.id == notification.id,
      );

      if (index == -1) return;

      setState(() {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
      });
    } catch (e) {
      if (!mounted) return;

      _showError(e);
    }
  }

  // ============================================================
  // OPEN NOTIFICATION
  // ============================================================

  Future<void> _openNotification(NotificationModel notification) async {
    await _markAsRead(notification);

    if (!mounted) return;

    final updatedNotification = notification.copyWith(isRead: true);

    final navigator = Navigator.of(context);

    switch (notification.type.toUpperCase()) {
      // ========================================================
      // WALLET
      // ========================================================

      case "WALLET":
      case "MONEY_ADDED":
        await navigator.push(
          MaterialPageRoute(builder: (_) => const WalletScreen()),
        );
        return;

      // ========================================================
      // CASHBACK / REWARD
      // ========================================================

      case "CASHBACK":
      case "REWARD":
        await navigator.push(
          MaterialPageRoute(builder: (_) => const RewardsScreen()),
        );
        return;

      // ========================================================
      // PAYMENT / BILL / SECURITY / GENERAL
      // ========================================================

      case "PAYMENT":
      case "TRANSACTION":
      case "SUCCESS":
      case "BILL":
      case "SECURITY":
      case "WARNING":
      default:
        await navigator.push(
          MaterialPageRoute(
            builder: (_) =>
                NotificationDetailsScreen(notification: updatedNotification),
          ),
        );
        return;
    }
  }

  // ============================================================
  // DELETE NOTIFICATION
  // ============================================================

  Future<bool> _deleteNotification(NotificationModel notification) async {
    try {
      await _api.deleteNotification(notification.id);

      if (!mounted) return false;

      final messenger = ScaffoldMessenger.of(context);

      messenger.showSnackBar(
        const SnackBar(content: Text("Notification deleted.")),
      );

      return true;
    } catch (e) {
      if (!mounted) return false;

      _showError(e);
      return false;
    }
  }

  // ============================================================
  // ERROR
  // ============================================================

  void _showError(Object error) {
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(content: Text(error.toString().replaceFirst("Exception: ", ""))),
    );
  }

  // ============================================================
  // ICON
  // ============================================================

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

  // ============================================================
  // COLOR
  // ============================================================

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

  // ============================================================
  // TIME
  // ============================================================

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

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

    return "${dateTime.day.toString().padLeft(2, "0")}/"
        "${dateTime.month.toString().padLeft(2, "0")}/"
        "${dateTime.year}";
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((item) => !item.isRead).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,

        title: Row(
          children: [
            const Text(
              "Notifications",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            if (unreadCount > 0) ...[
              const SizedBox(width: 10),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  unreadCount > 99 ? "99+" : unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),

        actions: [
          if (_isMarkingAllRead)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: unreadCount == 0 ? null : _markAllAsRead,
              child: const Text("Mark all read"),
            ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: RefreshIndicator(
        onRefresh: _refresh,

        child: _isLoading
            ? const _NotificationLoading()
            : _notifications.isEmpty
            ? const _NotificationEmpty()
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),

                padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),

                itemCount: _notifications.length,

                itemBuilder: (context, index) {
                  final notification = _notifications[index];

                  return Dismissible(
                    key: ValueKey(notification.id),

                    direction: DismissDirection.endToStart,

                    background: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),

                    confirmDismiss: (_) => _deleteNotification(notification),

                    onDismissed: (_) {
                      setState(() {
                        _notifications.removeWhere(
                          (item) => item.id == notification.id,
                        );
                      });
                    },

                    child: _NotificationCard(
                      notification: notification,
                      icon: _getIcon(notification.type),
                      color: _getColor(notification.type),
                      time: _formatTime(notification.createdAt),
                      onTap: () {
                        _openNotification(notification);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// ============================================================
// NOTIFICATION CARD
// ============================================================

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final IconData icon;
  final Color color;
  final String time;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.icon,
    required this.color,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnread ? const Color(0xFFF0F6FF) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: isUnread
              ? Border.all(color: Colors.blue.withValues(alpha: 0.15))
              : null,
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
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(icon, color: color),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    notification.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade700, height: 1.35),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    time,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// LOADING SKELETON
// ============================================================

class _NotificationLoading extends StatelessWidget {
  const _NotificationLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),

      padding: const EdgeInsets.all(20),

      itemCount: 6,

      itemBuilder: (_, index) {
        return Container(
          height: 110,
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(radius: 24, backgroundColor: Color(0xFFE5E7EB)),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonLine(width: 150, height: 15),
                      SizedBox(height: 10),
                      _SkeletonLine(width: 230, height: 12),
                      SizedBox(height: 8),
                      _SkeletonLine(width: 80, height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonLine({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// ============================================================
// EMPTY STATE
// ============================================================

class _NotificationEmpty extends StatelessWidget {
  const _NotificationEmpty();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),

      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    size: 48,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "No Notifications",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  "You're all caught up!",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
