import 'package:flutter/material.dart';

import '../models/card_model.dart';
import '../services/card_service.dart';
import '../skeletons/cards_skeleton.dart';
import '../widgets/card_action_button.dart';
import '../widgets/card_settings_tile.dart';
import '../widgets/empty_cards_widget.dart';
import '../widgets/payment_card.dart';
import 'add_card_screen.dart';
import 'card_details_screen.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final CardService _service = CardService.instance;

  bool _loading = true;

  List<CardModel> _cards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    setState(() {
      _loading = true;
    });

    _cards = _service.cards;

    if (!mounted) return;

    setState(() {
      _loading = false;
    });
  }

  CardModel? get _defaultCard {
    try {
      return _cards.firstWhere((e) => e.isDefault);
    } catch (_) {
      return _cards.isEmpty ? null : _cards.first;
    }
  }

  Future<void> _openAddCard() async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddCardScreen()),
    );

    if (created == true) {
      _loadCards();
    }
  }

  Future<void> _openDetails(CardModel card) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CardDetailsScreen(card: card)),
    );

    _loadCards();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const CardsSkeleton();
    }

    if (_cards.isEmpty) {
      return EmptyCardsWidget(onAddCard: _openAddCard);
    }

    final card = _defaultCard!;

    return RefreshIndicator(
      onRefresh: _loadCards,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          PaymentCard(card: card, onTap: () => _openDetails(card)),

          const SizedBox(height: 24),

          Row(
            children: [
              CardActionButton(
                icon: Icons.send_rounded,
                label: "Transfer",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Transfer coming soon")),
                  );
                },
              ),

              const SizedBox(width: 12),

              CardActionButton(
                icon: Icons.lock_outline_rounded,
                label: card.isFrozen ? "Unfreeze" : "Freeze",
                onTap: () async {
                  _service.toggleFreeze(card.id);

                  if (!mounted) return;

                  _loadCards();
                },
              ),

              const SizedBox(width: 12),

              CardActionButton(
                icon: Icons.add_card_rounded,
                label: "Add Card",
                onTap: _openAddCard,
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "Card Settings",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          CardSettingsTile(
            icon: Icons.credit_card,
            title: "Card Details",
            subtitle: "View complete card information",
            onTap: () => _openDetails(card),
          ),

          CardSettingsTile(
            icon: Icons.swap_horiz_rounded,
            title: "Set as Default",
            subtitle: card.isDefault
                ? "This is your default payment card"
                : "Use this card for future payments",
            enabled: !card.isDefault,
            onTap: () async {
              _service.setDefaultCard(card.id);

              if (!mounted) return;

              _loadCards();
            },
          ),

          CardSettingsTile(
            icon: Icons.security_rounded,
            title: "Security",
            subtitle: card.isFrozen
                ? "Card is currently frozen"
                : "Your card is protected",
          ),

          CardSettingsTile(
            icon: Icons.receipt_long_outlined,
            title: "Transaction History",
            subtitle: "View recent transactions",
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Coming soon")));
            },
          ),

          const SizedBox(height: 24),
          const Text(
            "My Cards",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          ..._cards.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: PaymentCard(
                card: item,
                showBalance: false,
                onTap: () => _openDetails(item),
              ),
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: _openAddCard,
            icon: const Icon(Icons.add_card_rounded),
            label: const Text("Add Another Card"),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
