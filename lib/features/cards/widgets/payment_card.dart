import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/card_model.dart';

class PaymentCard extends StatefulWidget {
  final CardModel card;
  final bool showBalance;
  final VoidCallback? onTap;

  const PaymentCard({
    super.key,
    required this.card,
    this.showBalance = true,
    this.onTap,
  });

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  bool _showNumber = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> get _colors {
    switch (widget.card.cardColor.toLowerCase()) {
      case "black":
        return const [Color(0xff101010), Color(0xff3d3d3d)];

      case "purple":
        return const [Color(0xff6A11CB), Color(0xff2575FC)];

      case "green":
        return const [Color(0xff11998E), Color(0xff38EF7D)];

      case "red":
        return const [Color(0xffCB2D3E), Color(0xffEF473A)];

      default:
        return const [Color(0xff396AFD), Color(0xff2948FF)];
    }
  }

  String get _brand {
    switch (widget.card.type) {
      case CardType.visa:
        return "VISA";
      case CardType.mastercard:
        return "MASTERCARD";
      case CardType.rupay:
        return "RUPAY";
    }
  }

  IconData get _brandIcon {
    switch (widget.card.type) {
      case CardType.visa:
      case CardType.mastercard:
        return Icons.credit_card;
      case CardType.rupay:
        return Icons.account_balance_wallet;
    }
  }

  String get _displayNumber {
    if (_showNumber) {
      return widget.card.cardNumber
          .replaceAllMapped(RegExp(r".{4}"), (m) => "${m.group(0)} ")
          .trim();
    }

    return widget.card.maskedCardNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "card_${widget.card.id}",
      child: FadeTransition(
        opacity: _fade,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AspectRatio(
            aspectRatio: 1.58,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _colors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _colors.last.withValues(alpha: .35),
                    blurRadius: 28,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Stack(
                  children: [
                    Positioned(
                      top: -70,
                      right: -40,
                      child: Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: .08),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -60,
                      left: -60,
                      child: Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: .05),
                        ),
                      ),
                    ),

                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        color: Colors.white.withValues(alpha: .03),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(_brandIcon, color: Colors.white, size: 30),
                              const Spacer(),
                              Text(
                                _brand,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 28),
                          if (widget.showBalance) ...[
                            const Text(
                              "Available Balance",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 8),

                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                "₹${widget.card.balance.toStringAsFixed(2)}",
                                key: ValueKey(widget.card.balance),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),
                          ],

                          const Spacer(),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _displayNumber,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),

                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  setState(() {
                                    _showNumber = !_showNumber;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: .12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _showNumber
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          Row(
                            children: [
                              Container(
                                width: 55,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: .15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: const Icon(
                                  Icons.memory,
                                  color: Color(0xFFFFD54F),
                                  size: 28,
                                ),
                              ),

                              const Spacer(),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "VALID THRU",
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 10,
                                      letterSpacing: 1,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    widget.card.expiryDate,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "CARD HOLDER",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 10,
                                        letterSpacing: 1,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      widget.card.cardHolderName.toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (widget.card.isDefault)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: .15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "DEFAULT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.shield_outlined,
                                  color: Colors.white70,
                                  size: 18,
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    widget.card.isFrozen
                                        ? "This card is currently frozen."
                                        : "Protected with bank-level security.",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (widget.card.isFrozen)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.lock, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    "CARD FROZEN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
