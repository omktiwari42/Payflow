import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String phone;

  const CompleteProfileScreen({super.key, required this.phone});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await AuthService.instance.completeProfile(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        "/dashboard",
        (route) => false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                widget.phone,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your full name";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email (Optional)",
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _continue,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
