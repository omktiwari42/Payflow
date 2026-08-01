import 'package:flutter/material.dart';

import '../models/bill_model.dart';
import '../services/bill_service.dart';

enum PaymentMethod { wallet, bank, debitCard, creditCard, upi }

class PayBillScreen extends StatefulWidget {
  final BillModel bill;

  const PayBillScreen({super.key, required this.bill});

  @override
  State<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen> {
  final BillService _service = BillService.instance;

  PaymentMethod _selectedMethod = PaymentMethod.upi;

  bool _processing = false;

  Widget _infoTile(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _methodTile(
    PaymentMethod method,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      leading: Radio<PaymentMethod>(
        value: method,
        groupValue: _selectedMethod,
        onChanged: (value) {
          if (value == null) return;

          setState(() {
            _selectedMethod = value;
          });
        },
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(icon),
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
    );
  }

  Widget _billCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              child: const Icon(Icons.receipt_long, size: 30),
            ),

            const SizedBox(height: 18),

            Text(
              widget.bill.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              widget.bill.accountNumber,
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const Divider(height: 32),

            _infoTile(
              Icons.currency_rupee,
              "Bill Amount",
              "₹${widget.bill.amount.toStringAsFixed(2)}",
            ),

            _infoTile(
              Icons.calendar_today,
              "Due Date",
              "${widget.bill.dueDate.day}/${widget.bill.dueDate.month}/${widget.bill.dueDate.year}",
            ),

            _infoTile(Icons.category, "Category", widget.bill.categoryName),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethods() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _methodTile(
              PaymentMethod.upi,
              Icons.qr_code_2,
              "UPI",
              "Google Pay, PhonePe, Paytm",
            ),
            _methodTile(
              PaymentMethod.wallet,
              Icons.account_balance_wallet,
              "Wallet",
              "PayFlow Wallet",
            ),
            _methodTile(
              PaymentMethod.bank,
              Icons.account_balance,
              "Bank Account",
              "Net Banking",
            ),
            _methodTile(
              PaymentMethod.debitCard,
              Icons.credit_card,
              "Debit Card",
              "Visa, RuPay, Mastercard",
            ),
            _methodTile(
              PaymentMethod.creditCard,
              Icons.credit_card_outlined,
              "Credit Card",
              "Visa, RuPay, Mastercard",
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay Bill"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _billCard(),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment Method",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 12),

            _paymentMethods(),

            const SizedBox(height: 20),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Payment Summary",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "₹${widget.bill.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 28),

                    Row(
                      children: [
                        const Text("Bill Amount"),
                        const Spacer(),
                        Text("₹${widget.bill.amount.toStringAsFixed(2)}"),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Row(
                      children: [
                        Text("Convenience Fee"),
                        Spacer(),
                        Text("₹0.00"),
                      ],
                    ),

                    const Divider(height: 28),

                    Row(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          "₹${widget.bill.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _processing
                    ? null
                    : () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text("Confirm Payment"),
                              content: Text(
                                "Pay ₹${widget.bill.amount.toStringAsFixed(2)} for ${widget.bill.title}?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext, false);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext, true);
                                  },
                                  child: const Text("Pay"),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm != true) return;

                        setState(() {
                          _processing = true;
                        });
                        await Future.delayed(const Duration(seconds: 2));

                        _service.payBill(widget.bill.id);

                        if (!mounted) return;

                        final messenger = ScaffoldMessenger.of(context);
                        final navigator = Navigator.of(context);

                        setState(() {
                          _processing = false;
                        });

                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text("Bill paid successfully."),
                          ),
                        );

                        navigator.pop();
                      },
                icon: _processing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.payments_rounded),
                label: Text(
                  _processing
                      ? "Processing..."
                      : "Pay ₹${widget.bill.amount.toStringAsFixed(2)}",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
