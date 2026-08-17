import 'package:flutter/material.dart';

import '../services/send_money_api_service.dart';
import '../widgets/amount_card.dart';
import '../widgets/amount_keypad.dart';
import 'payment_review_screen.dart';

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

    final initialAmount = widget.amount;

    if (initialAmount != null && initialAmount > 0) {
      _amountController.text = initialAmount.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEND MONEY
  // ============================================================

  Future<void> _sendMoney() async {
    final amount = double.tryParse(_amountController.text.trim());

    if (amount == null || amount <= 0) {
      _showMessage("Enter a valid amount.");
      return;
    }

    final phone = widget.phone?.trim();

    if (phone == null || phone.isEmpty) {
      _showMessage("Recipient phone not found.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await SendMoneyApiService.instance.sendMoney(
        phone: phone,
        amount: amount,
        note: _noteController.text.trim(),
      );

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Expanded(child: Text("Payment Successful")),
              ],
            ),
            content: Text(
              "₹${amount.toStringAsFixed(2)} "
              "has been sent successfully.",
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("Done"),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;

      _showMessage(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  // ============================================================
  // CONTINUE TO REVIEW
  // ============================================================

  void _continueToReview() {
    final amount = double.tryParse(_amountController.text.trim());

    if (amount == null || amount <= 0) {
      _showMessage("Enter a valid amount.");
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentReviewScreen(
          recipientName: widget.recipientName ?? "Unknown User",
          phone: widget.phone ?? "",
          amount: amount,
          note: _noteController.text.trim(),
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Send Money",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),

                    // ==================================================
                    // RECIPIENT / AMOUNT
                    // ==================================================
                    AmountCard(
                      name: widget.recipientName ?? "Unknown User",
                      phone: widget.phone ?? widget.upiId ?? "",
                      amount: _amountController.text,
                    ),

                    const SizedBox(height: 16),

                    // ==================================================
                    // NOTE
                    // ==================================================
                    TextField(
                      controller: _noteController,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: "Add a note (Optional)",
                        prefixIcon: const Icon(Icons.edit_note_rounded),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ==================================================
                    // KEYPAD
                    // ==================================================
                    AbsorbPointer(
                      absorbing: _isLoading,
                      child: Stack(
                        children: [
                          AmountKeypad(
                            amount: _amountController.text,
                            onChanged: (value) {
                              setState(() {
                                _amountController.text = value;

                                _amountController.selection =
                                    TextSelection.fromPosition(
                                      TextPosition(offset: value.length),
                                    );
                              });
                            },
                            onContinue: _continueToReview,
                          ),

                          if (_isLoading)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.72),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ==================================================
                    // DIRECT SEND
                    // ==================================================
                    SizedBox(
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: _isLoading ? null : _sendMoney,
                        icon: const Icon(Icons.send_rounded),
                        label: const Text("Send Directly"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
