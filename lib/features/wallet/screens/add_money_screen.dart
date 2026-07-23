import 'package:flutter/material.dart';

import '../services/wallet_service.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _addMoney() async {
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

    WalletService.instance.addMoney(amount);

    if (!mounted) return;

    setState(() {
      _loading = false;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text("Money Added"),
          ],
        ),
        content: Text(
          "₹${amount.toStringAsFixed(2)} has been added to your wallet.",
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
    return Scaffold(
      appBar: AppBar(title: const Text("Add Money"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.account_balance_wallet,
            size: 90,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          const Text(
            "Add Money to Wallet",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              prefixText: "₹ ",
              labelText: "Amount",
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
              _quickAmount(5000),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 55,
            child: FilledButton.icon(
              onPressed: _loading ? null : _addMoney,
              icon: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add_circle),
              label: Text(_loading ? "Processing..." : "Add Money"),
            ),
          ),
        ],
      ),
    );
  }
}
