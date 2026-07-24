import 'package:flutter/material.dart';

import '../services/investment_service.dart';

class PortfolioSummary extends StatelessWidget {
  final InvestmentService service;

  const PortfolioSummary({super.key, required this.service});

  Widget _summaryTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 14),
              Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profitColor = service.isProfit ? Colors.green : Colors.red;

    return Column(
      children: [
        Row(
          children: [
            _summaryTile(
              context: context,
              icon: Icons.account_balance_wallet,
              title: "Portfolio",
              value: "₹${service.totalCurrentValue.toStringAsFixed(2)}",
              color: Colors.blue,
            ),
            const SizedBox(width: 12),
            _summaryTile(
              context: context,
              icon: Icons.savings,
              title: "Invested",
              value: "₹${service.totalInvested.toStringAsFixed(2)}",
              color: Colors.orange,
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            _summaryTile(
              context: context,
              icon: service.isProfit ? Icons.trending_up : Icons.trending_down,
              title: "Profit / Loss",
              value: "₹${service.totalProfitLoss.toStringAsFixed(2)}",
              color: profitColor,
            ),
            const SizedBox(width: 12),
            _summaryTile(
              context: context,
              icon: Icons.percent,
              title: "Return",
              value: "${service.totalProfitLossPercentage.toStringAsFixed(2)}%",
              color: profitColor,
            ),
          ],
        ),
      ],
    );
  }
}
