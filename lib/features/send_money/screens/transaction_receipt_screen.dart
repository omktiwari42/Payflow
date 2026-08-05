import 'package:flutter/material.dart';

import '../services/receipt_service.dart';
import '../widgets/receipt_action_button.dart';
import '../widgets/receipt_detail_tile.dart';

class TransactionReceiptScreen extends StatelessWidget {
  final String receiverName;
  final String amount;
  final String upiId;
  final String transactionId;

  const TransactionReceiptScreen({
    super.key,
    required this.receiverName,
    required this.amount,
    required this.upiId,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final date =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

    final time =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Transaction Receipt",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 52),
              ),

              const SizedBox(height: 18),

              const Text(
                "Payment Successful",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                "₹$amount",
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    ReceiptDetailTile(
                      title: "Receiver",
                      value: receiverName,
                      icon: Icons.person,
                    ),

                    const Divider(height: 1),

                    ReceiptDetailTile(
                      title: "UPI ID",
                      value: upiId,
                      icon: Icons.account_balance_wallet,
                    ),

                    const Divider(height: 1),

                    ReceiptDetailTile(
                      title: "Transaction ID",
                      value: transactionId,
                      icon: Icons.receipt_long,
                    ),

                    const Divider(height: 1),

                    ReceiptDetailTile(
                      title: "Status",
                      value: "SUCCESS",
                      valueColor: Colors.green,
                      icon: Icons.verified,
                    ),

                    const Divider(height: 1),

                    ReceiptDetailTile(
                      title: "Payment Method",
                      value: "PayFlow Wallet",
                      icon: Icons.wallet,
                    ),

                    const Divider(height: 1),

                    ReceiptDetailTile(
                      title: "Date",
                      value: date,
                      icon: Icons.calendar_today,
                    ),

                    const Divider(height: 1),

                    ReceiptDetailTile(
                      title: "Time",
                      value: time,
                      icon: Icons.access_time,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  ReceiptActionButton(
                    icon: Icons.download,
                    title: "Download",
                    onTap: () {
                      ReceiptService.instance.downloadReceipt(
                        context,
                        receiverName: receiverName,
                        upiId: upiId,
                        amount: amount,
                        transactionId: transactionId,
                      );
                    },
                  ),
                  ReceiptActionButton(
                    icon: Icons.share,
                    title: "Share",
                    onTap: () {
                      ReceiptService.instance.shareReceipt(
                        context,
                        receiverName: receiverName,
                        upiId: upiId,
                        amount: amount,
                        transactionId: transactionId,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  ReceiptActionButton(
                    icon: Icons.save_alt,
                    title: "Save",
                    onTap: () {
                      ReceiptService.instance.saveReceipt(
                        context,
                        receiverName: receiverName,
                        upiId: upiId,
                        amount: amount,
                        transactionId: transactionId,
                      );
                    },
                  ),
                  ReceiptActionButton(
                    icon: Icons.print,
                    title: "Print",
                    onTap: () {
                      ReceiptService.instance.printReceipt(
                        context,
                        receiverName: receiverName,
                        upiId: upiId,
                        amount: amount,
                        transactionId: transactionId,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
