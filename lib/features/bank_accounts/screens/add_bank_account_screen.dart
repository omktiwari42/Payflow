import 'package:flutter/material.dart';

import '../services/bank_account_api_service.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({super.key});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final _bankController = TextEditingController();
  final _holderController = TextEditingController();
  final _accountController = TextEditingController();
  final _ifscController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _bankController.dispose();
    _holderController.dispose();
    _accountController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    try {
      await BankAccountApiService.instance.addBankAccount(
        bankName: _bankController.text.trim(),
        accountHolderName: _holderController.text.trim(),
        accountNumber: _accountController.text.trim(),
        ifscCode: _ifscController.text.trim().toUpperCase(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bank account added successfully.")),
      );

      Navigator.pop(context, true);
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

  InputDecoration input(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
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
            TextFormField(
              controller: _bankController,
              decoration: input("Bank Name", Icons.account_balance),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter bank name";
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _holderController,
              decoration: input("Account Holder", Icons.person),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter account holder name";
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _accountController,
              keyboardType: TextInputType.number,
              decoration: input("Account Number", Icons.credit_card),
              validator: (value) {
                if (value == null || value.trim().length < 8) {
                  return "Enter valid account number";
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _ifscController,
              textCapitalization: TextCapitalization.characters,
              decoration: input("IFSC Code", Icons.code),
              validator: (value) {
                if (value == null || value.trim().length < 11) {
                  return "Enter valid IFSC";
                }
                return null;
              },
            ),

            const SizedBox(height: 32),

            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: _loading ? null : _save,
                icon: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Text(_loading ? "Saving..." : "Add Bank Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
