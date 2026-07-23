import 'package:flutter/material.dart';

import '../services/wallet_service.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _withdraw() async {
    final amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter a valid amount")));
      return;
    }

    setState(() {
      _loading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final success = WalletService.instance.withdrawMoney(amount);

    if (!mounted) return;

    setState(() {
      _loading = false;
    });

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Insufficient wallet balance")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text("Withdrawal Successful"),
          ],
        ),
        content: Text(
          "₹${amount.toStringAsFixed(2)} has been withdrawn successfully.",
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  Widget _quickAmount(double amount) {
    return OutlinedButton(
      onPressed: () {
        _amountController.text = amount.toStringAsFixed(0);
      },
      child: Text("₹${amount.toStringAsFixed(0)}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final balance = WalletService.instance.balance;

    return Scaffold(
      appBar: AppBar(title: const Text("Withdraw Money"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Available Balance",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "₹${balance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              prefixText: "₹ ",
              labelText: "Withdraw Amount",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _quickAmount(100),
              _quickAmount(500),
              _quickAmount(1000),
              _quickAmount(2000),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 55,
            child: FilledButton.icon(
              onPressed: _loading ? null : _withdraw,
              icon: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.account_balance_wallet),
              label: Text(_loading ? "Processing..." : "Withdraw Money"),
            ),
          ),
        ],
      ),
    );
  }
}
