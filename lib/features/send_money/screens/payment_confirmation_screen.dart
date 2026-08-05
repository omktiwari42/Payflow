import 'package:flutter/material.dart';

import 'payment_success_screen.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final String receiverName;
  final String upiId;
  final double amount;

  const PaymentConfirmationScreen({
    super.key,
    required this.receiverName,
    required this.upiId,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Confirm Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              CircleAvatar(
                radius: 42,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  receiverName.isEmpty ? "?" : receiverName[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2563EB),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                receiverName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                upiId,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Amount",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "₹${amount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.account_balance_wallet),
                      title: Text("Payment Method"),
                      subtitle: Text("PayFlow Wallet"),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text("Transfer Type"),
                      subtitle: Text("Instant"),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.lock_outline),
                      title: Text("Security"),
                      subtitle: Text("256-bit Encrypted"),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton.icon(
                  icon: const Icon(Icons.check_circle),
                  label: const Text(
                    "Confirm Payment",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentSuccessScreen(
                          recipientName: receiverName,
                          amount: amount,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
