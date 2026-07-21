import 'package:flutter/material.dart';

class RewardsCashbackCard extends StatelessWidget {
  const RewardsCashbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color(0xffFFF7ED),
            Color(0xffFFFFFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: const Color(0xffF59E0B).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.card_giftcard_rounded,
                  color: Color(0xffF59E0B),
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Rewards & Cashback",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Save more with every payment",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                  ],
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.workspace_premium),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffF59E0B),
                  Color(0xffF97316),
                ],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Available Cashback",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "₹4,860",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Gold Rewards Member",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const _RewardOffer(
            title: "10% Cashback",
            subtitle: "Amazon Shopping",
            expiry: "Expires in 2 days",
            color: Color(0xff2563EB),
          ),

          const SizedBox(height: 16),

          const _RewardOffer(
            title: "₹500 Bonus",
            subtitle: "Travel Booking",
            expiry: "Expires in 5 days",
            color: Color(0xff10B981),
          ),

          const SizedBox(height: 16),

          const _RewardOffer(
            title: "Scratch & Win",
            subtitle: "Guaranteed Reward",
            expiry: "Available Today",
            color: Color(0xff8B5CF6),
          ),
                    const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xffFEF3C7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Color(0xffF59E0B),
                  child: Icon(
                    Icons.redeem_rounded,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 16),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scratch Card",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "You have 3 scratch cards waiting to be opened.",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF59E0B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text("Open"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: _RewardStat(
                  title: "Points",
                  value: "12,450",
                  icon: Icons.stars_rounded,
                  color: Color(0xff2563EB),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _RewardStat(
                  title: "Coupons",
                  value: "18",
                  icon: Icons.confirmation_number_rounded,
                  color: Color(0xff10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardOffer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String expiry;
  final Color color;

  const _RewardOffer({
    required this.title,
    required this.subtitle,
    required this.expiry,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(
              Icons.local_offer_rounded,
              color: color,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  expiry,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardStat extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _RewardStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}