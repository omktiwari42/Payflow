import 'package:flutter/material.dart';

import '../models/card_model.dart';
import '../services/card_service.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();

  final _holderController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _balanceController = TextEditingController();

  final CardService _service = CardService.instance;
  CardType _type = CardType.visa;

  String _cardColor = "blue";

  bool _saving = false;

  final List<String> _colors = ["blue", "black", "purple", "green", "red"];

  @override
  void dispose() {
    _holderController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  Future<void> _saveCard() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _saving = true);
    final card = CardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cardHolderName: _holderController.text.trim(),
      cardNumber: _numberController.text.replaceAll(' ', ''),
      expiryDate: _expiryController.text.trim(),
      cvv: _cvvController.text.trim(),
      balance: double.tryParse(_balanceController.text.trim()) ?? 0,
      type: _type,
      cardColor: _cardColor,
      isDefault: false,
      isFrozen: false,
    );

    _service.addCard(card);

    if (!mounted) return;

    setState(() => _saving = false);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Card")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _holderController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Card Holder Name",
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter card holder name";
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Card Number",
                prefixIcon: Icon(Icons.credit_card),
              ),
              validator: (value) {
                if (value == null || value.replaceAll(' ', '').length < 16) {
                  return "Enter a valid card number";
                }
                return null;
              },
            ),

            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _expiryController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: "Expiry (MM/YY)",
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "CVV",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 3) {
                        return "Invalid";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _balanceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Initial Balance",
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter balance";
                }

                if (double.tryParse(value) == null) {
                  return "Invalid amount";
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            const Text(
              "Card Type",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<CardType>(
              initialValue: _type,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: CardType.visa, child: Text("Visa")),
                DropdownMenuItem(
                  value: CardType.mastercard,
                  child: Text("MasterCard"),
                ),
                DropdownMenuItem(value: CardType.rupay, child: Text("RuPay")),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _type = value);
                }
              },
            ),

            const SizedBox(height: 24),
            const Text(
              "Card Color",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() => _cardColor = color);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: switch (color) {
                        "blue" => Colors.blue,
                        "black" => Colors.black,
                        "purple" => Colors.deepPurple,
                        "green" => Colors.green,
                        "red" => Colors.red,
                        _ => Colors.blue,
                      },
                      border: Border.all(
                        color: _cardColor == color
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: _cardColor == color
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 36),

            SizedBox(
              height: 56,
              child: FilledButton(
                onPressed: _saving ? null : _saveCard,
                child: _saving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    : const Text(
                        "Add Card",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
