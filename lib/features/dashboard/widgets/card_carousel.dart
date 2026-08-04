import 'package:flutter/material.dart';

class CardCarousel extends StatefulWidget {
  const CardCarousel({super.key});

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.92);

  int currentPage = 0;

  final List<Map<String, dynamic>> banners = [
    {
      "title": "Pay & Win",
      "subtitle": "Get up to ₹500 Cashback\non your first transfer.",
      "button": "Pay Now",
      "colors": [Color(0xff059669), Color(0xff10B981)],
      "icon": Icons.account_balance_wallet_outlined,
    },
    {
      "title": "Invite Friends",
      "subtitle": "Earn ₹100 for every\nsuccessful referral.",
      "button": "Invite",
      "colors": [Color(0xff2563EB), Color(0xff3B82F6)],
      "icon": Icons.group_add,
    },
    {
      "title": "Pay Bills",
      "subtitle": "Electricity • Mobile\nFASTag • DTH",
      "button": "Explore",
      "colors": [Color(0xffEA580C), Color(0xffF97316)],
      "icon": Icons.receipt_long,
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        currentPage = (_controller.page ?? 0).round();
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
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (_, index) {
              final banner = banners[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: List<Color>.from(banner["colors"]),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.10),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(banner["icon"], color: Colors.white, size: 28),

                            const SizedBox(height: 10),

                            Text(
                              banner["title"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              banner["subtitle"],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 6),

                            SizedBox(
                              height: 36,
                              child: FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(banner["button"]),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 18),

                      Container(
                        width: 78,
                        height: 78,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.15),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Icon(
                          banner["icon"],
                          color: Colors.white70,
                          size: 42,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentPage == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? const Color(0xff2563EB)
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
