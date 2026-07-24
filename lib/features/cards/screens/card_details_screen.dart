import 'package:flutter/material.dart';

import '../models/card_model.dart';
import '../services/card_service.dart';
import '../widgets/card_action_button.dart';
import '../widgets/card_settings_tile.dart';
import '../widgets/payment_card.dart';

class CardDetailsScreen extends StatefulWidget {
  final CardModel card;

  const CardDetailsScreen({super.key, required this.card});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final CardService _service = CardService.instance;

  late CardModel _card;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _card = widget.card;
  }

  Future<void> _toggleFreeze() async {
    setState(() => _loading = true);

    _service.toggleFreeze(_card.id);

    setState(() {
      _card = _card.copyWith(isFrozen: !_card.isFrozen);
      _loading = false;
    });
  }

  Future<void> _makeDefault() async {
    setState(() => _loading = true);

    _service.setDefaultCard(_card.id);

    if (!mounted) return;

    setState(() {
      _card = _card.copyWith(isDefault: true);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Card Details")),
      body: IgnorePointer(
        ignoring: _loading,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            PaymentCard(card: _card),

            const SizedBox(height: 24),

            Row(
              children: [
                CardActionButton(
                  icon: _card.isFrozen
                      ? Icons.lock_open_rounded
                      : Icons.lock_outline_rounded,
                  label: _card.isFrozen ? "Unfreeze" : "Freeze",
                  onTap: _toggleFreeze,
                ),

                const SizedBox(width: 12),

                CardActionButton(
                  icon: Icons.star_rounded,
                  label: _card.isDefault ? "Default" : "Set Default",
                  enabled: !_card.isDefault,
                  onTap: _makeDefault,
                ),

                const SizedBox(width: 12),

                CardActionButton(
                  icon: Icons.share_rounded,
                  label: "Share",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Share feature coming soon"),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Card Information",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            CardSettingsTile(
              icon: Icons.person_outline_rounded,
              title: "Card Holder",
              subtitle: _card.cardHolderName,
            ),

            CardSettingsTile(
              icon: Icons.credit_card_rounded,
              title: "Card Number",
              subtitle: _card.maskedCardNumber,
            ),

            CardSettingsTile(
              icon: Icons.calendar_month_rounded,
              title: "Expiry Date",
              subtitle: _card.expiryDate,
            ),

            CardSettingsTile(
              icon: Icons.account_balance_wallet_outlined,
              title: "Available Balance",
              subtitle: "₹${_card.balance.toStringAsFixed(2)}",
            ),

            CardSettingsTile(
              icon: Icons.security_rounded,
              title: "Security Status",
              subtitle: _card.isFrozen
                  ? "Card is currently frozen"
                  : "Card is active and secured",
            ),

            const SizedBox(height: 24),
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            CardSettingsTile(
              icon: Icons.receipt_long_rounded,
              title: "Transaction History",
              subtitle: "View all transactions made using this card",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Transaction history coming soon"),
                  ),
                );
              },
            ),

            CardSettingsTile(
              icon: Icons.notifications_active_outlined,
              title: "Spending Alerts",
              subtitle: "Manage card spending notifications",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Alerts settings coming soon")),
                );
              },
            ),

            CardSettingsTile(
              icon: Icons.pin_outlined,
              title: "Change PIN",
              subtitle: "Update your card PIN securely",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("PIN change coming soon")),
                );
              },
            ),

            CardSettingsTile(
              icon: Icons.block_outlined,
              title: "Block Card",
              subtitle: "Permanently block this card",
              iconColor: Colors.red,
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);

                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text("Block Card"),
                    content: const Text(
                      "Are you sure you want to permanently block this card?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: const Text("Cancel"),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(dialogContext, true),
                        child: const Text("Block"),
                      ),
                    ],
                  ),
                );

                if (!mounted) return;

                if (confirm == true) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text("Card blocked successfully")),
                  );
                }
              },
            ),

            const SizedBox(height: 32),
            if (_loading)
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
