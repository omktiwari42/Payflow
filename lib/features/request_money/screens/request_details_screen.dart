import 'package:flutter/material.dart';

import '../models/request_money_model.dart';

class RequestDetailsScreen extends StatelessWidget {
  final RequestMoneyModel request;

  const RequestDetailsScreen({
    super.key,
    required this.request,
  });

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case "ACCEPTED":
        return Colors.green;
      case "REJECTED":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Widget _row(String title, String value) {
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = request.status;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: _statusColor(status).withOpacity(.15),
            child: Icon(
              Icons.request_page,
              color: _statusColor(status),
              size: 50,
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              "₹${request.amount.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: Chip(
              backgroundColor: _statusColor(status),
              label: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 30),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _row("Request ID", request.id.toString()),
                  _row("Sender", request.senderName),
                  _row("Receiver", request.receiverName),
                  _row("Phone", request.senderPhone),
                  _row(
                    "Note",
                    request.note.isEmpty ? "-" : request.note,
                  ),
                  _row("Date", request.createdAt),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Share feature coming soon."),
                ),
              );
            },
            icon: const Icon(Icons.share),
            label: const Text("Share Request"),
          ),
        ],
      ),
    );
  }
}