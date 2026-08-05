import 'package:flutter/material.dart';

import 'receipt_pdf_service.dart';

class ReceiptService {
  ReceiptService._();

  static final ReceiptService instance = ReceiptService._();

  Future<void> downloadReceipt(
    BuildContext context, {
    required String receiverName,
    required String upiId,
    required String amount,
    required String transactionId,
  }) async {
    try {
      await ReceiptPdfService.instance.saveReceipt(
        receiverName: receiverName,
        upiId: upiId,
        amount: amount,
        transactionId: transactionId,
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Receipt downloaded successfully.")),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Download failed: $e")));
    }
  }

  Future<void> shareReceipt(
    BuildContext context, {
    required String receiverName,
    required String upiId,
    required String amount,
    required String transactionId,
  }) async {
    try {
      await ReceiptPdfService.instance.shareReceipt(
        receiverName: receiverName,
        upiId: upiId,
        amount: amount,
        transactionId: transactionId,
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Share failed: $e")));
    }
  }

  Future<void> saveReceipt(
    BuildContext context, {
    required String receiverName,
    required String upiId,
    required String amount,
    required String transactionId,
  }) async {
    try {
      await ReceiptPdfService.instance.saveReceipt(
        receiverName: receiverName,
        upiId: upiId,
        amount: amount,
        transactionId: transactionId,
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Receipt saved successfully.")),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Save failed: $e")));
    }
  }

  Future<void> printReceipt(
    BuildContext context, {
    required String receiverName,
    required String upiId,
    required String amount,
    required String transactionId,
  }) async {
    try {
      await ReceiptPdfService.instance.printReceipt(
        receiverName: receiverName,
        upiId: upiId,
        amount: amount,
        transactionId: transactionId,
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Print failed: $e")));
    }
  }
}
