import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionDetailsScreen({super.key, required this.transaction});

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case "SUCCESS":
        return Colors.green;
      case "FAILED":
        return Colors.red;
      case "PENDING":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _tile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = transaction["status"]?.toString() ?? "SUCCESS";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          CircleAvatar(
            radius: 42,
            backgroundColor: _statusColor(status).withOpacity(.15),
            child: Icon(
              Icons.check_circle,
              color: _statusColor(status),
              size: 52,
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Text(
              "₹${transaction["amount"] ?? "0"}",
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: Chip(
              backgroundColor: _statusColor(status),
              label: Text(status, style: const TextStyle(color: Colors.white)),
            ),
          ),

          const SizedBox(height: 28),

          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _tile("Transaction ID", transaction["id"]?.toString() ?? "-"),
                  _tile(
                    "Type",
                    transaction["transaction_type"]?.toString() ?? "-",
                  ),
                  _tile(
                    "Sender",
                    transaction["sender_name"]?.toString() ?? "-",
                  ),
                  _tile(
                    "Receiver",
                    transaction["receiver_name"]?.toString() ?? "-",
                  ),
                  _tile(
                    "Note",
                    transaction["note"]?.toString().isNotEmpty == true
                        ? transaction["note"].toString()
                        : "-",
                  ),
                  _tile("Date", transaction["created_at"]?.toString() ?? "-"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Receipt download coming soon.")),
              );
            },
            icon: const Icon(Icons.download),
            label: const Text("Download Receipt"),
          ),

          const SizedBox(height: 15),

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Share feature coming soon.")),
              );
            },
            icon: const Icon(Icons.share),
            label: const Text("Share Receipt"),
          ),
        ],
      ),
    );
  }
}
