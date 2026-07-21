import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String receiverName;
  final String amount;
  final String transactionId;
  final String date;
  final String status;
  final String paymentMethod;
  final String upiId;

  const TransactionDetailsScreen({
    super.key,
    required this.receiverName,
    required this.amount,
    required this.transactionId,
    required this.date,
    required this.status,
    required this.paymentMethod,
    required this.upiId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Transaction Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "₹$amount",
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Payment Successful",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _tile("Receiver", receiverName),
                _divider(),
                _tile("UPI ID", upiId),
                _divider(),
                _tile("Transaction ID", transactionId),
                _divider(),
                _tile("Status", status),
                _divider(),
                _tile("Payment Method", paymentMethod),
                _divider(),
                _tile("Date", date),
              ],
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text(
                "Share Transaction",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 56,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.receipt_long),
              label: const Text("View Receipt", style: TextStyle(fontSize: 18)),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _divider() {
    return const Divider(height: 1);
  }

  static Widget _tile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
