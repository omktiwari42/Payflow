import 'package:flutter/material.dart';

import '../services/request_money_api_service.dart';

class RequestMoneyScreen extends StatefulWidget {
  const RequestMoneyScreen({super.key});

  @override
  State<RequestMoneyScreen> createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final _formKey = GlobalKey<FormState>();

  final _receiverIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _receiverIdController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _requestMoney() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    try {
      await RequestMoneyApiService.instance.requestMoney(
        receiverId: int.parse(_receiverIdController.text.trim()),
        amount: double.parse(_amountController.text.trim()),
        note: _noteController.text.trim(),
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text("Request Sent"),
            ],
          ),
          content: const Text("Your money request has been sent successfully."),
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
          _loading = false;
        });
      }
    }
  }

  InputDecoration decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Request Money"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _receiverIdController,
              keyboardType: TextInputType.number,
              decoration: decoration("Receiver ID", Icons.person),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter receiver ID";
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: decoration("Amount", Icons.currency_rupee),
              validator: (value) {
                final amount = double.tryParse(value ?? "");

                if (amount == null || amount <= 0) {
                  return "Enter a valid amount";
                }

                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _noteController,
              maxLines: 3,
              decoration: decoration("Note (Optional)", Icons.notes),
            ),

            const SizedBox(height: 32),

            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: _loading ? null : _requestMoney,
                icon: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.request_page),
                label: Text(_loading ? "Sending..." : "Request Money"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
