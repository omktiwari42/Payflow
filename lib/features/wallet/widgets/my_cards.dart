import 'package:flutter/material.dart';

class MyCards extends StatelessWidget {
  const MyCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "My Cards",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 18),

        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _BankCard(
                title: "Visa Infinite",
                number: "**** 9034",
                holder: "OM KUMAR",
                expiry: "11/29",
                color: Color(0xFF7C3AED),
              ),
              SizedBox(width: 16),
              _BankCard(
                title: "Master Premium",
                number: "**** 7788",
                holder: "OM KUMAR",
                expiry: "03/31",
                color: Color(0xFF0F766E),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BankCard extends StatelessWidget {
  final String title;
  final String number;
  final String holder;
  final String expiry;
  final Color color;

  const _BankCard({
    required this.title,
    required this.number,
    required this.holder,
    required this.expiry,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(holder, style: const TextStyle(color: Colors.white70)),
              Text(expiry, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }
}
