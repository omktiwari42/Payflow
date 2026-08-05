import 'package:flutter/material.dart';

import 'transaction_receipt_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String recipientName;
  final double amount;

  const PaymentSuccessScreen({
    super.key,
    required this.recipientName,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final transactionId =
        "#TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 70),
              ),

              const SizedBox(height: 30),

              const Text(
                "Payment Successful",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              Text(
                "₹${amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Sent to $recipientName",
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                child: Column(
                  children: [
                    _detailRow("Transaction ID", transactionId),
                    const Divider(),
                    _detailRow("Status", "Completed"),
                    const Divider(),
                    _detailRow("Payment Method", "PayFlow Wallet"),
                    const Divider(),
                    _detailRow("Amount", "₹${amount.toStringAsFixed(2)}"),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransactionReceiptScreen(
                          receiverName: recipientName,
                          amount: amount.toStringAsFixed(2),
                          upiId: "payflow@upi",
                          transactionId: transactionId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.receipt_long),
                  label: const Text(
                    "Download Receipt",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
