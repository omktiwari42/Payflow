import 'package:flutter/material.dart';
import 'payment_success_screen.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final String receiverName;
  final String upiId;
  final String amount;

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
        title: const Text(
          "Confirm Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 42,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                receiverName.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              receiverName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              upiId,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),

            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Amount",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "₹ $amount",
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
                    leading: Icon(Icons.lock),
                    title: Text("Security"),
                    subtitle: Text("Encrypted Transaction"),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentSuccessScreen(
                        receiverName: receiverName,
                        amount: amount,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle),
                label: const Text(
                  "Confirm Payment",
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
