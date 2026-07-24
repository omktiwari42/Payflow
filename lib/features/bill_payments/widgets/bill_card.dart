import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/bill_model.dart';

class BillCard extends StatelessWidget {
  final BillModel bill;
  final VoidCallback? onTap;
  final VoidCallback? onPay;

  const BillCard({super.key, required this.bill, this.onTap, this.onPay});

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

  Color _statusColor(BuildContext context) {
    switch (bill.status) {
      case BillStatus.pending:
        return Colors.orange;
      case BillStatus.paid:
        return Colors.green;
      case BillStatus.overdue:
        return Colors.red;
    }
  }

  String get _statusText {
    switch (bill.status) {
      case BillStatus.pending:
        return "Pending";
      case BillStatus.paid:
        return "Paid";
      case BillStatus.overdue:
        return "Overdue";
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
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
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          bill.accountNumber,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(context).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      _statusText,
                      style: TextStyle(
                        color: _statusColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 8),
                  Text(DateFormat('dd MMM yyyy').format(bill.dueDate)),
                  const Spacer(),
                  Text(
                    bill.formattedAmount,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),

              if (bill.autoPay) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.autorenew_rounded,
                      color: scheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "AutoPay Enabled",
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],

              if (!bill.isPaid) ...[
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onPay,
                    icon: const Icon(Icons.payments_rounded),
                    label: const Text("Pay Now"),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
