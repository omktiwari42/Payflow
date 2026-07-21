import 'package:flutter/material.dart';

class WithdrawMoneyScreen extends StatefulWidget {
  const WithdrawMoneyScreen({super.key});

  @override
  State<WithdrawMoneyScreen> createState() => _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends State<WithdrawMoneyScreen> {
  final TextEditingController amountController = TextEditingController();

  String selectedBank = "HDFC Bank ••••4582";

  final List<String> banks = [
    "HDFC Bank ••••4582",
    "ICICI Bank ••••7814",
    "State Bank of India ••••9874",
    "Axis Bank ••••2148",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Withdraw Money",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                Text(
                  "Available Balance",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "₹18,540",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Withdraw Amount",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.currency_rupee),
              hintText: "Enter amount",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _quickAmount("500"),
              _quickAmount("1000"),
              _quickAmount("2000"),
              _quickAmount("5000"),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "Select Bank",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: selectedBank,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            items: banks.map((bank) {
              return DropdownMenuItem(value: bank, child: Text(bank));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedBank = value!;
              });
            },
          ),

          const SizedBox(height: 40),

          SizedBox(
            height: 58,
            child: ElevatedButton.icon(
              onPressed: () {
                if (amountController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter an amount")),
                  );
                  return;
                }

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Withdrawal Successful"),
                    content: Text(
                      "₹${amountController.text} has been transferred to\n$selectedBank",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.account_balance),
              label: const Text("Withdraw Now", style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAmount(String amount) {
    return ActionChip(
      label: Text("₹$amount"),
      onPressed: () {
        amountController.text = amount;
      },
    );
  }
}
