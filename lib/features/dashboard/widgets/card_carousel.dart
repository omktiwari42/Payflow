import 'package:flutter/material.dart';

class CardCarousel extends StatefulWidget {
  const CardCarousel({super.key});

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.9);

  double currentPage = 0;

  final List<Map<String, dynamic>> cards = [
    {
      "bank": "PayFlow Black",
      "holder": "OM KUMAR",
      "number": "5245 •••• •••• 4532",
      "expiry": "08/29",
      "balance": "₹10,24,560",
      "gradient": const [
        Color(0xff111827),
        Color(0xff1F2937),
        Color(0xff374151),
      ],
      "logo": "VISA",
    },
    {
      "bank": "PayFlow Platinum",
      "holder": "OM KUMAR",
      "number": "4589 •••• •••• 9821",
      "expiry": "11/30",
      "balance": "₹4,85,200",
      "gradient": const [
        Color(0xff2563EB),
        Color(0xff1D4ED8),
        Color(0xff3B82F6),
      ],
      "logo": "MASTER",
    },
    {
      "bank": "PayFlow Gold",
      "holder": "OM KUMAR",
      "number": "4012 •••• •••• 7812",
      "expiry": "02/31",
      "balance": "₹18,90,000",
      "gradient": const [
        Color(0xffF59E0B),
        Color(0xffD97706),
        Color(0xffB45309),
      ],
      "logo": "VISA",
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 235,
          child: PageView.builder(
            controller: _controller,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];

              final scale =
                  (1 - (currentPage - index).abs() * 0.08).clamp(0.9, 1.0);

              return Transform.scale(
                scale: scale,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: List<Color>.from(card["gradient"]),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 22,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              card["bank"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.contactless,
                              color: Colors.white70,
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        Row(
                          children: [
                            Container(
                              width: 52,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              card["logo"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),
                                                Text(
                          card["number"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
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
                                      color: Colors.white54,
                                      fontSize: 10,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    card["holder"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "EXPIRES",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    card["expiry"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "BALANCE",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    card["balance"],
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 18),
                Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            cards.length,
            (index) {
              final bool active = currentPage.round() == index;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xff2563EB)
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}