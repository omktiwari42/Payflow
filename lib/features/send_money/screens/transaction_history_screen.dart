import 'package:flutter/material.dart';
import 'transaction_details_screen.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        "name": "Rahul Sharma",
        "amount": "- ₹2,500",
        "date": "Today • 10:45 AM",
        "icon": Icons.person,
        "color": Colors.blue,
      },
      {
        "name": "Salary",
        "amount": "+ ₹45,000",
        "date": "Yesterday • 09:00 AM",
        "icon": Icons.account_balance_wallet,
        "color": Colors.green,
      },
      {
        "name": "Amazon",
        "amount": "- ₹1,899",
        "date": "20 Jul • 06:15 PM",
        "icon": Icons.shopping_bag,
        "color": Colors.orange,
      },
      {
        "name": "Electricity Bill",
        "amount": "- ₹1,250",
        "date": "19 Jul • 11:20 AM",
        "icon": Icons.bolt,
        "color": Colors.amber,
      },
      {
        "name": "Netflix",
        "amount": "- ₹649",
        "date": "18 Jul • 08:30 PM",
        "icon": Icons.movie,
        "color": Colors.red,
      },
      {
        "name": "Cashback",
        "amount": "+ ₹150",
        "date": "17 Jul • 03:45 PM",
        "icon": Icons.card_giftcard,
        "color": Colors.purple,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Transaction History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];

          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TransactionDetailsScreen(
                    receiverName: tx["name"] as String,
                    amount: (tx["amount"] as String).replaceAll(
                      RegExp(r'[^\d,]'),
                      '',
                    ),
                    transactionId: "#TXN94839284",
                    date: tx["date"] as String,
                    status: "Completed",
                    paymentMethod: "PayFlow Wallet",
                    upiId: "rahul@upi",
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: (tx["color"] as Color).withValues(alpha: 0.15),
                    child: Icon(
                      tx["icon"] as IconData,
                      color: tx["color"] as Color,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tx["name"] as String,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tx["date"] as String,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    tx["amount"] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: (tx["amount"] as String).startsWith("+")
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
