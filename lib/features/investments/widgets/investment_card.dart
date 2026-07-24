import 'package:flutter/material.dart';

import '../models/investment_model.dart';

class InvestmentCard extends StatelessWidget {
  final InvestmentModel investment;
  final VoidCallback? onTap;

  const InvestmentCard({super.key, required this.investment, this.onTap});

  IconData get _icon {
    switch (investment.type) {
      case InvestmentType.stock:
        return Icons.show_chart_rounded;
      case InvestmentType.mutualFund:
        return Icons.account_balance_rounded;
      case InvestmentType.crypto:
        return Icons.currency_bitcoin_rounded;
      case InvestmentType.gold:
        return Icons.workspace_premium_rounded;
      case InvestmentType.etf:
        return Icons.stacked_line_chart_rounded;
      case InvestmentType.fixedDeposit:
        return Icons.savings_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final profitColor = investment.isProfit ? Colors.green : Colors.red;

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
                    radius: 28,
                    backgroundColor: scheme.primaryContainer,
                    child: Icon(_icon, color: scheme.primary),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investment.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          investment.typeName,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${investment.units} Units",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${investment.currentValue.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: _infoTile(
                      "Invested",
                      "₹${investment.investedAmount.toStringAsFixed(2)}",
                    ),
                  ),

                  Expanded(
                    child: _infoTile(
                      "Current",
                      "₹${investment.currentValue.toStringAsFixed(2)}",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: profitColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(
                      investment.isProfit
                          ? Icons.trending_up
                          : Icons.trending_down,
                      color: profitColor,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        investment.isProfit ? "Profit" : "Loss",
                        style: TextStyle(
                          color: profitColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      "₹${investment.profitLoss.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: profitColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "(${investment.profitLossPercentage.toStringAsFixed(2)}%)",
                      style: TextStyle(
                        color: profitColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
