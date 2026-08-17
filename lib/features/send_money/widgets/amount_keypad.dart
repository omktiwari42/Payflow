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

  // ============================================================
  // PRESS KEY
  // ============================================================

  void _press(String value) {
    if (value == "⌫") {
      if (amount.isEmpty) return;

      onChanged(amount.substring(0, amount.length - 1));
      return;
    }

    if (value == ".") {
      if (amount.contains(".")) return;

      onChanged(amount.isEmpty ? "0." : "$amount.");
      return;
    }

    if (amount == "0") {
      onChanged(value);
      return;
    }

    // Prevent unnecessarily long numeric values.
    final parts = amount.split(".");

    if (parts.length == 2 && parts[1].length >= 2) {
      return;
    }

    onChanged("$amount$value");
  }

  // ============================================================
  // BUTTON
  // ============================================================

  Widget _button(String value, double height) {
    final isBackspace = value == "⌫";

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _press(value),
            child: SizedBox(
              height: height,
              child: Center(
                child: isBackspace
                    ? Icon(
                        Icons.backspace_outlined,
                        size: height < 56 ? 22 : 26,
                      )
                    : Text(
                        value,
                        style: TextStyle(
                          fontSize: height < 56 ? 23 : 28,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        final availableHeight = MediaQuery.sizeOf(context).height;

        final isCompact = availableHeight < 760;

        final buttonHeight = isCompact ? 54.0 : 62.0;

        final gap = isCompact ? 12.0 : 16.0;

        final continueHeight = isCompact ? 50.0 : 54.0;

        return Column(
          children: [
            // ======================================================
            // ROW 1
            // ======================================================
            Row(
              children: [
                _button("1", buttonHeight),
                _button("2", buttonHeight),
                _button("3", buttonHeight),
              ],
            ),

            // ======================================================
            // ROW 2
            // ======================================================
            Row(
              children: [
                _button("4", buttonHeight),
                _button("5", buttonHeight),
                _button("6", buttonHeight),
              ],
            ),

            // ======================================================
            // ROW 3
            // ======================================================
            Row(
              children: [
                _button("7", buttonHeight),
                _button("8", buttonHeight),
                _button("9", buttonHeight),
              ],
            ),

            // ======================================================
            // ROW 4
            // ======================================================
            Row(
              children: [
                _button(".", buttonHeight),
                _button("0", buttonHeight),
                _button("⌫", buttonHeight),
              ],
            ),

            SizedBox(height: gap),

            // ======================================================
            // CONTINUE
            // ======================================================
            SizedBox(
              width: double.infinity,
              height: continueHeight,
              child: FilledButton(
                onPressed: amount.isEmpty || amount == "0" || amount == "0."
                    ? null
                    : onContinue,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: isCompact ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
