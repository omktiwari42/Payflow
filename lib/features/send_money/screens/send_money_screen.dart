import 'package:flutter/material.dart';

class SendMoneyScreen extends StatefulWidget {
  final String? recipientName;
  final String? upiId;
  final double? amount;

  const SendMoneyScreen({
    super.key,
    this.recipientName,
    this.upiId,
    this.amount,
  });

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _selectedMethod = "Wallet";

  @override
  void initState() {
    super.initState();

    if (widget.amount != null) {
      _amountController.text = widget.amount!.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _sendMoney() async {
    final amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter a valid amount.")));
      return;
    }

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text("Payment Successful"),
          ],
        ),
        content: Text(
          "₹${amount.toStringAsFixed(2)} has been sent successfully.",
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  Widget _methodTile(String title, IconData icon) {
    return RadioListTile<String>(
      value: title,
      groupValue: _selectedMethod,
      activeColor: Colors.blue,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _selectedMethod = value);
      },
      title: Text(title),
      secondary: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipient = widget.recipientName ?? "Unknown Recipient";
    final upi = widget.upiId ?? "No UPI ID";

    return Scaffold(
      appBar: AppBar(title: const Text("Send Money"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    child: Icon(Icons.person, size: 34),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    recipient,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(upi, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "Amount",
              prefixText: "₹ ",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: _noteController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: "Payment Note",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Payment Method",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Card(
            child: Column(
              children: [
                _methodTile("Wallet", Icons.account_balance_wallet),
                _methodTile("Bank Account", Icons.account_balance),
                _methodTile("Credit Card", Icons.credit_card),
              ],
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 56,
            child: FilledButton.icon(
              onPressed: _sendMoney,
              icon: const Icon(Icons.send),
              label: const Text("Send Money", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
