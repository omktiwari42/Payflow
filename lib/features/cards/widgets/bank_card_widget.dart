import 'package:flutter/material.dart';

import '../models/bank_card_model.dart';

class BankCardWidget extends StatelessWidget {
  final BankCardModel card;
  final bool showNumber;
  final VoidCallback? onTap;

  const BankCardWidget({
    super.key,
    required this.card,
    this.showNumber = false,
    this.onTap,
  });

  Color _cardColor() {
    switch (card.cardColor.toLowerCase()) {
      case "black":
        return Colors.black87;
      case "purple":
        return Colors.deepPurple;
      case "green":
        return Colors.green;
      case "red":
        return Colors.redAccent;
      default:
        return Colors.indigo;
    }
  }

  String _brandName() {
    switch (card.type) {
      case CardType.visa:
        return "VISA";
      case CardType.mastercard:
        return "Mastercard";
      case CardType.rupay:
        return "RuPay";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [_cardColor(), _cardColor().withValues(alpha: .75)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _cardColor().withValues(alpha: .35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: .08),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.credit_card, color: Colors.white),
                      const Spacer(),
                      Text(
                        _brandName(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const Icon(Icons.sim_card, color: Colors.amber, size: 42),

                  const SizedBox(height: 22),

                  Text(
                    showNumber ? card.cardNumber : card.maskedCardNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "CARD HOLDER",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              card.cardHolderName.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "EXPIRES",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            card.expiryDate,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (card.isFrozen)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .55),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock, size: 48, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        "CARD FROZEN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
