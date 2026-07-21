import 'package:flutter/material.dart';

class SmartWalletCard extends StatelessWidget {
  const SmartWalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
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
                  color: const Color(0xff06B6D4).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Color(0xff06B6D4),
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Smart Wallet",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "All your money in one place",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "Total Balance",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "₹3,48,520",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          const _WalletAccountTile(
            icon: Icons.account_balance,
            title: "HDFC Bank",
            subtitle: "Savings • **** 4281",
            amount: "₹1,82,450",
            color: Color(0xff2563EB),
          ),

          const SizedBox(height: 18),

          const _WalletAccountTile(
            icon: Icons.account_balance_wallet,
            title: "PayFlow Wallet",
            subtitle: "Main Wallet",
            amount: "₹32,670",
            color: Color(0xff10B981),
          ),

          const SizedBox(height: 18),

          const _WalletAccountTile(
            icon: Icons.credit_card,
            title: "Visa Platinum",
            subtitle: "Credit Card",
            amount: "₹1,33,400",
            color: Color(0xffF59E0B),
          ),
                    const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Asset Distribution",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.52,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(10),
                        valueColor: const AlwaysStoppedAnimation(
                          Color(0xff2563EB),
                        ),
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text("52%"),
                  ],
                ),

                const SizedBox(height: 16),

                const Text(
                  "52% Bank • 10% Wallet • 38% Cards",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff06B6D4),
                  Color(0xff2563EB),
                ],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.add_card_rounded,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 16),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Add Money",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Instant wallet top-up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xff2563EB),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletAccountTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color color;

  const _WalletAccountTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
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
              icon,
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
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}