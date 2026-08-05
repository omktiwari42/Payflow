import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptPdfService {
  ReceiptPdfService._();

  static final ReceiptPdfService instance = ReceiptPdfService._();

  Future<File> generateReceipt({
    required String receiverName,
    required String upiId,
    required String amount,
    required String transactionId,
  }) async {
    final pdf = pw.Document();

    final ByteData imageData = await rootBundle.load(
      "assets/images/payflow_logo.png",
    );

    final Uint8List logoBytes = imageData.buffer.asUint8List();

    final logo = pw.MemoryImage(logoBytes);

    final now = DateTime.now();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (_) => [
          pw.Container(
            padding: const pw.EdgeInsets.all(22),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue700,
              borderRadius: pw.BorderRadius.circular(18),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 70,
                  height: 70,
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.white,
                    borderRadius: pw.BorderRadius.circular(14),
                  ),
                  child: pw.Image(logo),
                ),

                pw.SizedBox(width: 20),

                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "PayFlow",
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.SizedBox(height: 5),

                    pw.Text(
                      "Digital Payment Receipt",
                      style: const pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 30),

          pw.Center(
            child: pw.Column(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.green100,
                    borderRadius: pw.BorderRadius.circular(30),
                  ),
                  child: pw.Text(
                    "PAYMENT SUCCESSFUL",
                    style: pw.TextStyle(
                      color: PdfColors.green800,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 20),

                pw.Text(
                  "₹$amount",
                  style: pw.TextStyle(
                    fontSize: 38,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 30),

          pw.Container(
            padding: const pw.EdgeInsets.all(18),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Column(
              children: [
                _row("Receiver", receiverName),
                _row("UPI ID", upiId),
                _row("Transaction ID", transactionId),
                _row("Status", "SUCCESS"),
                _row("Payment Method", "PayFlow Wallet"),
                _row("Date", "${now.day}/${now.month}/${now.year}"),
                _row(
                  "Time",
                  "${now.hour}:${now.minute.toString().padLeft(2, "0")}",
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 30),

          pw.Center(
            child: pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data:
                  """
PayFlow Receipt

Receiver : $receiverName
UPI ID   : $upiId
Amount   : ₹$amount
Txn ID   : $transactionId
""",
              width: 150,
              height: 150,
            ),
          ),

          pw.SizedBox(height: 35),

          pw.Divider(),

          pw.Center(
            child: pw.Column(
              children: [
                pw.Text(
                  "Generated securely by PayFlow",
                  style: pw.TextStyle(
                    color: PdfColors.blue700,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 5),

                pw.Text(
                  "Fast • Secure • Smart",
                  style: pw.TextStyle(color: PdfColors.grey700),
                ),

                pw.SizedBox(height: 5),

                pw.Text(
                  "support@payflow.app",
                  style: pw.TextStyle(color: PdfColors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final file = File("${dir.path}/PayFlow_Receipt_$transactionId.pdf");

    await file.writeAsBytes(await pdf.save());

    await OpenFilex.open(file.path);

    return file;
  }

  Future<void> printReceipt({
    required String receiverName,
    required String upiId,
    required String amount,
    required String transactionId,
  }) async {
    final file = await generateReceipt(
      receiverName: receiverName,
      upiId: upiId,
      amount: amount,
      transactionId: transactionId,
    );

    await Printing.layoutPdf(onLayout: (_) => file.readAsBytes());
  }

  Future<void> shareReceipt({
    required String receiverName,
    required String upiId,
    required String amount,
    required String transactionId,
  }) async {
    final file = await generateReceipt(
      receiverName: receiverName,
      upiId: upiId,
      amount: amount,
      transactionId: transactionId,
    );
    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[XFile(file.path)],
        title: "PayFlow Receipt",
        subject: "PayFlow Receipt",
        text: "PayFlow Payment Receipt",
      ),
    );
  }

  Future<File> saveReceipt({
    required String receiverName,
    required String upiId,
    required String amount,
    required String transactionId,
  }) async {
    return generateReceipt(
      receiverName: receiverName,
      upiId: upiId,
      amount: amount,
      transactionId: transactionId,
    );
  }

  static pw.Widget _row(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(title, style: pw.TextStyle(color: PdfColors.grey)),
          ),
          pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }
}
