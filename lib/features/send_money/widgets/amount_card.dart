import 'package:flutter/material.dart';

class AmountCard extends StatelessWidget {
  final String name;
  final String phone;
  final String amount;

  const AmountCard({
    super.key,
    required this.name,
    required this.phone,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff2563EB), Color(0xff3B82F6)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2563EB).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white,
            child: Text(
              name.isEmpty ? "?" : name[0].toUpperCase(),
              style: const TextStyle(
                color: Color(0xff2563EB),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            phone,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),

          const SizedBox(height: 28),

          Text(
            amount.isEmpty ? "₹0" : "₹$amount",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Amount to Send",
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
