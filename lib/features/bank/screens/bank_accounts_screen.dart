import 'package:flutter/material.dart';

class BankAccountsScreen extends StatelessWidget {
  const BankAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banks = [
      {
        "name": "State Bank of India",
        "account": "•••• 4582",
        "type": "Savings Account",
        "color": Colors.blue,
      },
      {
        "name": "HDFC Bank",
        "account": "•••• 1296",
        "type": "Salary Account",
        "color": Colors.red,
      },
      {
        "name": "ICICI Bank",
        "account": "•••• 7814",
        "type": "Current Account",
        "color": Colors.orange,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Linked Bank Accounts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Add Bank"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: banks.length,
        itemBuilder: (context, index) {
          final bank = banks[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.all(18),
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
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: (bank["color"] as Color).withValues(alpha: 0.15),
                  child: Icon(
                    Icons.account_balance,
                    color: bank["color"] as Color,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bank["name"] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        bank["account"] as String,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        bank["type"] as String,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "default",
                      child: Text("Set as Default"),
                    ),
                    PopupMenuItem(value: "remove", child: Text("Remove")),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
