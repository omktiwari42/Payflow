import 'package:flutter/material.dart';

class AmountKeypad extends StatelessWidget {
  final String amount;
  final ValueChanged<String> onChanged;
  final VoidCallback onContinue;

  const AmountKeypad({
    super.key,
    required this.amount,
    required this.onChanged,
    required this.onContinue,
  });

  void _press(String value) {
    if (value == "⌫") {
      if (amount.isNotEmpty) {
        onChanged(amount.substring(0, amount.length - 1));
      }
      return;
    }

    if (value == ".") {
      if (amount.contains(".")) return;

      if (amount.isEmpty) {
        onChanged("0.");
      } else {
        onChanged("$amount.");
      }

      return;
    }

    if (amount == "0") {
      onChanged(value);
    } else {
      onChanged(amount + value);
    }
  }

  Widget _button(String value) {
    final bool isBackspace = value == "⌫";

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => _press(value),
            child: SizedBox(
              height: 70,
              child: Center(
                child: isBackspace
                    ? const Icon(Icons.backspace_outlined, size: 28)
                    : Text(
                        value,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [_button("1"), _button("2"), _button("3")]),

        Row(children: [_button("4"), _button("5"), _button("6")]),

        Row(children: [_button("7"), _button("8"), _button("9")]),

        Row(children: [_button("."), _button("0"), _button("⌫")]),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            onPressed: amount.isEmpty || amount == "0" ? null : onContinue,
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
