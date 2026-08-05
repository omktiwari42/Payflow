import 'package:flutter/material.dart';

import '../services/send_money_api_service.dart';
import '../widgets/amount_card.dart';
import '../widgets/amount_keypad.dart';

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
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

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
        note: _noteController.text.trim(),
      );

      if (!mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
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
                  Navigator.pop(context, true);
                },
                child: const Text("Done"),
              ),
            ],
          );
        },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Send Money",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            AmountCard(
              name: widget.recipientName ?? "Unknown User",
              phone: widget.phone ?? widget.upiId ?? "",
              amount: _amountController.text,
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: "Add a note (Optional)",
                  prefixIcon: const Icon(Icons.edit_note_rounded),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: AbsorbPointer(
                absorbing: _isLoading,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AmountKeypad(
                      amount: _amountController.text,
                      onChanged: (value) {
                        setState(() {
                          _amountController.text = value;
                        });
                      },
                      onContinue: _sendMoney,
                    ),

                    if (_isLoading)
                      Container(
                        height: 330,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
