import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Transaction Details"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xffE8F0FF),
            child: Icon(Icons.check_circle, color: Colors.green, size: 50),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              "₹500.00",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 8),

          const Center(
            child: Text(
              "Payment Successful",
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 30),

          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: const [
                  _InfoRow("Receiver", "Rahul Sharma"),
                  Divider(),
                  _InfoRow("Transaction ID", "TXN123456789"),
                  Divider(),
                  _InfoRow("Date", "05 Aug 2026"),
                  Divider(),
                  _InfoRow("Time", "10:45 AM"),
                  Divider(),
                  _InfoRow("Payment Method", "PayFlow Wallet"),
                  Divider(),
                  _InfoRow("Status", "Successful"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(color: Colors.grey.shade600)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
