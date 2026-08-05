import 'package:flutter/material.dart';

class PayflowBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PayflowBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color primary = Color(0xff2563EB);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .08),
              blurRadius: 20,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            _item(icon: Icons.home_rounded, label: "Home", index: 0),

            _item(
              icon: Icons.account_balance_wallet_rounded,
              label: "Wallet",
              index: 1,
            ),

            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () => onTap(2),
                  borderRadius: BorderRadius.circular(40),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xff00B4FF), Color(0xff2563EB)],
                      ),
                      boxShadow: currentIndex == 2
                          ? [
                              BoxShadow(
                                color: primary.withValues(alpha: .35),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),

            _item(icon: Icons.search_rounded, label: "Search", index: 3),

            _item(icon: Icons.person_rounded, label: "Profile", index: 4),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool selected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: selected ? primary : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                color: selected ? primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
