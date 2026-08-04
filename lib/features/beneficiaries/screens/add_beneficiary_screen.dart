import 'package:flutter/material.dart';

import '../services/beneficiary_api_service.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _upiController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _upiController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    try {
      await BeneficiaryApiService.instance.addBeneficiary(
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        upiId: _upiController.text.trim().isEmpty
            ? null
            : _upiController.text.trim(),
      );

      if (!mounted) return;

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
      appBar: AppBar(title: const Text("Add Beneficiary"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: input("Full Name", Icons.person),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "Enter full name";
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: input("Phone Number", Icons.phone),
              validator: (v) {
                if (v == null || v.length != 10) {
                  return "Enter valid phone number";
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _upiController,
              decoration: input(
                "UPI ID (Optional)",
                Icons.account_balance_wallet,
              ),
            ),

            const SizedBox(height: 35),

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
                label: Text(_loading ? "Saving..." : "Save Beneficiary"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
