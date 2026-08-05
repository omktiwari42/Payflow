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
      final page = _controller.page?.round() ?? 0;

      if (page != currentPage && mounted) {
        setState(() {
          currentPage = page;
        });
      }
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
          height: 210,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (_, index) {
              final banner = banners[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: List<Color>.from(banner["colors"]),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(banner["icon"], color: Colors.white, size: 28),

                            const SizedBox(height: 12),

                            Text(
                              banner["title"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              banner["subtitle"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),

                            const Spacer(),

                            SizedBox(
                              height: 42,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  banner["button"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: Center(
                          child: Container(
                            width: 86,
                            height: 86,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(
                              banner["icon"],
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            final selected = currentPage == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: selected ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xff2563EB)
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
        ),
      ],
    );
  }
}
