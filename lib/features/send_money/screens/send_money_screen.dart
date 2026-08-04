import 'package:flutter/material.dart';

import '../services/send_money_api_service.dart';

class SendMoneyScreen extends StatefulWidget {
  final String? recipientName;
  final String? phone;
  final String? upiId;
  final double? amount;

  const SendMoneyScreen({
    super.key,
    this.recipientName,
    this.phone,
    this.upiId,
    this.amount,
  });

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedMethod = "Wallet";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.amount != null && widget.amount! > 0) {
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
      ).showSnackBar(const SnackBar(content: Text("Enter a valid amount")));
      return;
    }

    if (widget.phone == null || widget.phone!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Recipient phone not found.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await SendMoneyApiService.instance.sendMoney(
        phone: widget.phone!,
        amount: amount,
        note: _noteController.text,
      );

      if (!mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text("Payment Successful"),
            ],
          ),
          content: Text("₹${amount.toStringAsFixed(2)} sent successfully."),
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
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget paymentMethod(String title, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio<String>(
        value: title,
        groupValue: _selectedMethod,
        onChanged: (value) {
          if (value == null) return;

          setState(() {
            _selectedMethod = value;
          });
        },
      ),
      title: Text(title),
      trailing: Icon(icon),
      onTap: () {
        setState(() {
          _selectedMethod = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send Money"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    child: Icon(Icons.person, size: 35),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.recipientName ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.phone ?? widget.upiId ?? ""),
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
              labelText: "Amount",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _noteController,
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
          paymentMethod("Wallet", Icons.account_balance_wallet),
          paymentMethod("Bank Account", Icons.account_balance),
          paymentMethod("Credit Card", Icons.credit_card),
          const SizedBox(height: 30),
          SizedBox(
            height: 56,
            child: FilledButton.icon(
              onPressed: _isLoading ? null : _sendMoney,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.send),
              label: Text(_isLoading ? "Sending..." : "Send Money"),
            ),
          ),
        ],
      ),
    );
  }
}
