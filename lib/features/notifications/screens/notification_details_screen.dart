import 'package:flutter/material.dart';

import '../models/notification_model.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailsScreen({super.key, required this.notification});

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
  // DATE FORMAT
  // ============================================================

  String _formatDate(DateTime dateTime) {
    final date = dateTime.toLocal();

    return "${date.day.toString().padLeft(2, "0")}/"
        "${date.month.toString().padLeft(2, "0")}/"
        "${date.year} "
        "${date.hour.toString().padLeft(2, "0")}:"
        "${date.minute.toString().padLeft(2, "0")}";
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final color = _getColor(notification.type);
    final icon = _getIcon(notification.type);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // ==================================================
            // ICON
            // ==================================================
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 52, color: color),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // TITLE
            // ==================================================
            Text(
              notification.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ==================================================
            // TYPE
            // ==================================================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                notification.type,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // DETAILS CARD
            // ==================================================
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Notification Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      notification.message,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Divider(),

                    const SizedBox(height: 8),

                    _DetailRow(
                      icon: Icons.category_outlined,
                      title: "Type",
                      value: notification.type,
                    ),

                    _DetailRow(
                      icon: Icons.access_time,
                      title: "Date",
                      value: _formatDate(notification.createdAt),
                    ),

                    _DetailRow(
                      icon: notification.isRead
                          ? Icons.mark_email_read
                          : Icons.mark_email_unread,
                      title: "Status",
                      value: notification.isRead ? "Read" : "Unread",
                      valueColor: notification.isRead
                          ? Colors.grey
                          : Colors.blue,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // CLOSE BUTTON
            // ==================================================
            SizedBox(
              width: double.infinity,
              height: 55,

              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Done", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DETAIL ROW
// ============================================================

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),

          const SizedBox(width: 12),

          Text(title, style: TextStyle(color: Colors.grey.shade600)),

          const Spacer(),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
            ),
          ),
        ],
      ),
    );
  }
}
