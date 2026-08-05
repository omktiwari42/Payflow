import 'package:flutter/material.dart';

import '../services/send_money_api_service.dart';
import 'payment_success_screen.dart';

class PaymentReviewScreen extends StatefulWidget {
  final String recipientName;
  final String phone;
  final double amount;
  final String note;

  const PaymentReviewScreen({
    super.key,
    required this.recipientName,
    required this.phone,
    required this.amount,
    required this.note,
  });

  @override
  State<PaymentReviewScreen> createState() => _PaymentReviewScreenState();
}

class _PaymentReviewScreenState extends State<PaymentReviewScreen> {
  bool isLoading = false;

  Future<void> _confirmPayment() async {
    setState(() {
      isLoading = true;
    });

    try {
      await SendMoneyApiService.instance.sendMoney(
        phone: widget.phone,
        amount: widget.amount,
        note: widget.note,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentSuccessScreen(
            recipientName: widget.recipientName,
            amount: widget.amount,
          ),
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
          isLoading = false;
        });
      }
    }
  }

  Widget infoTile(
    String title,
    String value, {
    Color? valueColor,
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.black,
              fontSize: bold ? 18 : 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const fee = 0.0;
    final total = widget.amount + fee;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Review Payment",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: const Color(
                          0xff2563EB,
                        ).withOpacity(.10),
                        child: Text(
                          widget.recipientName.isEmpty
                              ? "?"
                              : widget.recipientName[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 28,
                            color: Color(0xff2563EB),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        widget.recipientName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        widget.phone,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),

                      const Divider(height: 36),

                      infoTile(
                        "Amount",
                        "₹${widget.amount.toStringAsFixed(2)}",
                        valueColor: Colors.green,
                      ),

                      infoTile("Transaction Fee", "₹0.00"),

                      infoTile("Payment Method", "Wallet"),

                      infoTile("Note", widget.note.isEmpty ? "-" : widget.note),

                      const Divider(height: 36),

                      infoTile(
                        "Total",
                        "₹${total.toStringAsFixed(2)}",
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified_user, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Your payment is protected with bank-grade encryption.",
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton.icon(
                  onPressed: isLoading ? null : _confirmPayment,
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.lock),
                  label: Text(
                    isLoading ? "Processing..." : "Confirm Payment",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
