import 'package:flutter/material.dart';

class CashbackOffersCard extends StatelessWidget {
  const CashbackOffersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      {
        "title": "Flat ₹100 Cashback",
        "subtitle": "On Mobile Recharge",
        "color": Color(0xff2563EB),
      },
      {
        "title": "20% OFF",
        "subtitle": "Electricity Bill",
        "color": Color(0xff10B981),
      },
      {
        "title": "Movie Offer",
        "subtitle": "Buy 1 Get 1",
        "color": Color(0xffF59E0B),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cashback & Offers",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 135,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, index) {
                final offer = offers[index];

                return Container(
                  width: 240,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: offer["color"] as Color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.local_offer,
                        color: Colors.white,
                        size: 30,
                      ),
                      const Spacer(),
                      Text(
                        offer["title"] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer["subtitle"] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
