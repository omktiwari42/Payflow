import 'package:flutter/material.dart';

import '../models/bill_model.dart';

class BillCategoryWidget extends StatelessWidget {
  final BillCategory category;
  final VoidCallback? onTap;
  final bool selected;

  const BillCategoryWidget({
    super.key,
    required this.category,
    this.onTap,
    this.selected = false,
  });

  IconData get _icon {
    switch (category) {
      case BillCategory.electricity:
        return Icons.electric_bolt_rounded;
      case BillCategory.water:
        return Icons.water_drop_rounded;
      case BillCategory.gas:
        return Icons.local_fire_department_rounded;
      case BillCategory.mobile:
        return Icons.smartphone_rounded;
      case BillCategory.broadband:
        return Icons.wifi_rounded;
      case BillCategory.dth:
        return Icons.tv_rounded;
      case BillCategory.insurance:
        return Icons.shield_rounded;
      case BillCategory.creditCard:
        return Icons.credit_card_rounded;
      case BillCategory.fastag:
        return Icons.directions_car_rounded;
      case BillCategory.education:
        return Icons.school_rounded;
    }
  }

  String get _title {
    switch (category) {
      case BillCategory.electricity:
        return "Electricity";
      case BillCategory.water:
        return "Water";
      case BillCategory.gas:
        return "Gas";
      case BillCategory.mobile:
        return "Mobile";
      case BillCategory.broadband:
        return "Broadband";
      case BillCategory.dth:
        return "DTH";
      case BillCategory.insurance:
        return "Insurance";
      case BillCategory.creditCard:
        return "Credit Card";
      case BillCategory.fastag:
        return "FASTag";
      case BillCategory.education:
        return "Education";
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: selected
                  ? scheme.primaryContainer
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected
                    ? scheme.primary
                    : scheme.outline.withValues(alpha: 0.25),
                width: selected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: selected
                      ? scheme.primary
                      : scheme.primaryContainer,
                  child: Icon(
                    _icon,
                    color: selected ? scheme.onPrimary : scheme.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  _title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
