import 'package:flutter/material.dart';

import '../models/bill_model.dart';

class UpcomingBillTile extends StatelessWidget {
  final BillModel bill;
  final VoidCallback? onTap;

  const UpcomingBillTile({super.key, required this.bill, this.onTap});

  IconData get _icon {
    switch (bill.category) {
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

  int get _daysLeft {
    final difference = bill.dueDate.difference(DateTime.now()).inDays;
    return difference < 0 ? 0 : difference;
  }

  String get _dueText {
    if (bill.isPaid) {
      return "Paid";
    }

    if (_daysLeft == 0) {
      return "Due Today";
    }

    if (_daysLeft == 1) {
      return "Due Tomorrow";
    }

    return "Due in $_daysLeft days";
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: scheme.primaryContainer,
                child: Icon(_icon, color: scheme.primary),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _dueText,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    bill.formattedAmount,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (bill.autoPay)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.autorenew_rounded,
                          size: 16,
                          color: scheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "AutoPay",
                          style: TextStyle(
                            color: scheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
