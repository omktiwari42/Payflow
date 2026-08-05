import 'package:flutter/material.dart';

class ReceiptService {
  ReceiptService._();

  static final ReceiptService instance = ReceiptService._();

  Future<void> downloadReceipt(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Download feature coming soon.")),
    );
  }

  Future<void> shareReceipt(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Share feature coming soon.")));
  }

  Future<void> saveReceipt(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Receipt saved successfully.")),
    );
  }

  Future<void> printReceipt(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Print feature coming soon.")));
  }
}
