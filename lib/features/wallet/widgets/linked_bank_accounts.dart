import 'package:flutter/material.dart';

class LinkedBankAccounts extends StatelessWidget {
  const LinkedBankAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Linked Bank Accounts",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 18),

        _BankAccountTile(
          bankName: "State Bank of India",
          accountNumber: "•••• 4589",
          balance: "₹82,450",
          icon: Icons.account_balance,
          color: Colors.blue,
        ),

        SizedBox(height: 14),

        _BankAccountTile(
          bankName: "HDFC Bank",
          accountNumber: "•••• 7721",
          balance: "₹31,600",
          icon: Icons.account_balance_wallet,
          color: Colors.deepPurple,
        ),

        SizedBox(height: 14),

        _BankAccountTile(
          bankName: "ICICI Bank",
          accountNumber: "•••• 9135",
          balance: "₹14,490",
          icon: Icons.savings,
          color: Colors.orange,
        ),
      ],
    );
  }
}

class _BankAccountTile extends StatelessWidget {
  final String bankName;
  final String accountNumber;
  final String balance;
  final IconData icon;
  final Color color;

  const _BankAccountTile({
    required this.bankName,
    required this.accountNumber,
    required this.balance,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bankName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  accountNumber,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Balance",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                balance,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
