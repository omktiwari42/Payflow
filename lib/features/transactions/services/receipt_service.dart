import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptService {
  ReceiptService._();

  static final ReceiptService instance = ReceiptService._();

  Future<File> generateReceipt(Map<String, dynamic> tx,) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "PAYFLOW",
                style: pw.TextStyle(
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "Transaction Receipt",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.Divider(),

              pw.Text("Transaction ID : ${tx["id"]}"),
              pw.Text("Amount : ₹${tx["amount"]}"),
              pw.Text("Status : ${tx["status"]}"),
              pw.Text("Type : ${tx["transaction_type"]}"),
              pw.Text("Sender : ${tx["sender_name"]}"),
              pw.Text("Receiver : ${tx["receiver_name"]}"),
              pw.Text("Note : ${tx["note"] ?? ""}"),
              pw.Text("Date : ${tx["created_at"]}"),

              pw.SizedBox(height: 40),

              pw.Center(
                child: pw.Text(
                  "Thank you for using PayFlow",
                ),
              ),
            ],
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final file = File(
      "${dir.path}/receipt_${tx["id"]}.pdf",
    );

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  Future<void> printReceipt(Map<String, dynamic> tx,) async {
    final file = await generateReceipt(tx);

    await Printing.layoutPdf(
      onLayout: (_) => file.readAsBytes(),
    );
  }

  Future<void> shareReceipt(Map<String, dynamic> tx,) async {
    final file = await generateReceipt(tx);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: "PayFlow Receipt",
    );
  }
}