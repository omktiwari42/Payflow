import 'package:flutter/material.dart';

import '../models/bank_account_model.dart';
import '../services/bank_account_service.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({super.key});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final _holderController = TextEditingController();
  final _accountController = TextEditingController();
  final _ifscController = TextEditingController();

  final List<String> _banks = [
    "State Bank of India",
    "HDFC Bank",
    "ICICI Bank",
    "Axis Bank",
    "Punjab National Bank",
    "Canara Bank",
    "Bank of Baroda",
    "Union Bank",
    "Kotak Mahindra Bank",
    "IndusInd Bank",
  ];

  String _selectedBank = "State Bank of India";

  bool _loading = false;

  @override
  void dispose() {
    _holderController.dispose();
    _accountController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  Future<void> _saveAccount() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final account = BankAccountModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      bankName: _selectedBank,
      accountHolderName: _holderController.text.trim(),
      accountNumber: _accountController.text.trim(),
      ifscCode: _ifscController.text.trim().toUpperCase(),
    );

    BankAccountService.instance.addAccount(account);

    if (!mounted) return;

    setState(() {
      _loading = false;
    });

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Bank Account"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DropdownButtonFormField<String>(
              value: _selectedBank,
              decoration: const InputDecoration(
                labelText: "Bank",
                border: OutlineInputBorder(),
              ),
              items: _banks
                  .map(
                    (bank) => DropdownMenuItem(value: bank, child: Text(bank)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedBank = value;
                });
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _holderController,
              decoration: const InputDecoration(
                labelText: "Account Holder Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter account holder name";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _accountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Account Number",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.length < 8) {
                  return "Enter a valid account number";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _ifscController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: "IFSC Code",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().length < 11) {
                  return "Enter a valid IFSC code";
                }
                return null;
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: _loading ? null : _saveAccount,
                icon: _loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.account_balance),
                label: Text(_loading ? "Saving..." : "Add Bank Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
