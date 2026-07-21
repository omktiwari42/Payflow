import 'package:flutter/material.dart';

class MultiCurrencyCard extends StatelessWidget {
  const MultiCurrencyCard({super.key});

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
                  color: const Color(0xff8B5CF6).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.currency_exchange,
                  color: Color(0xff8B5CF6),
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Multi-Currency",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Manage global currencies",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.public),
              ),
            ],
          ),

          const SizedBox(height: 28),

          const _CurrencyTile(
            flag: "🇮🇳",
            code: "INR",
            name: "Indian Rupee",
            balance: "₹1,25,430",
            rate: "Base Currency",
            color: Color(0xff2563EB),
          ),

          const SizedBox(height: 16),

          const _CurrencyTile(
            flag: "🇺🇸",
            code: "USD",
            name: "US Dollar",
            balance: "\$4,250",
            rate: "₹87.34",
            color: Color(0xff10B981),
          ),

          const SizedBox(height: 16),

          const _CurrencyTile(
            flag: "🇪🇺",
            code: "EUR",
            name: "Euro",
            balance: "€1,180",
            rate: "₹101.52",
            color: Color(0xffF59E0B),
          ),
                    const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.currency_exchange_rounded,
                  color: Color(0xff8B5CF6),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Live Exchange: 1 USD = ₹87.34 • 1 EUR = ₹101.52 • Rates updated 2 minutes ago.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff8B5CF6),
                  Color(0xff6D28D9),
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
                    Icons.flight_takeoff_rounded,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 16),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Travel Mode",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Enable for automatic currency conversion",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                Switch(
                  value: true,
                  onChanged: null,
                  activeColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyTile extends StatelessWidget {
  final String flag;
  final String code;
  final String name;
  final String balance;
  final String rate;
  final Color color;

  const _CurrencyTile({
    required this.flag,
    required this.code,
    required this.name,
    required this.balance,
    required this.rate,
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
          Text(
            flag,
            style: const TextStyle(fontSize: 30),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                balance,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                rate,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}