import 'package:flutter/material.dart';

import '../models/investment_model.dart';
import '../services/investment_service.dart';

class InvestmentDetailsScreen extends StatelessWidget {
  final InvestmentModel investment;

  const InvestmentDetailsScreen({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    final service = InvestmentService.instance;

    final profitColor = investment.isProfit ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Investment Details"),
        actions: [
          IconButton(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete Investment"),
                    content: const Text(
                      "Are you sure you want to remove this investment?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                },
              );

              if (confirm == true) {
                service.removeInvestment(investment.id);

                if (context.mounted) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Investment deleted successfully."),
                    ),
                  );
                }
              }
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    child: Text(
                      investment.name.characters.first,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    investment.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Chip(label: Text(investment.typeName)),

                  const SizedBox(height: 20),

                  Text(
                    "₹${investment.currentValue.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: profitColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    investment.isProfit
                        ? "Portfolio is in Profit"
                        : "Portfolio is in Loss",
                    style: TextStyle(
                      color: profitColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          _infoTile(
            title: "Invested Amount",
            value: "₹${investment.investedAmount.toStringAsFixed(2)}",
            icon: Icons.account_balance_wallet_outlined,
          ),

          _infoTile(
            title: "Current Value",
            value: "₹${investment.currentValue.toStringAsFixed(2)}",
            icon: Icons.show_chart,
          ),

          _infoTile(
            title: "Profit / Loss",
            value: "₹${investment.profitLoss.toStringAsFixed(2)}",
            valueColor: profitColor,
            icon: investment.isProfit ? Icons.trending_up : Icons.trending_down,
          ),

          _infoTile(
            title: "Return",
            value: "${investment.profitLossPercentage.toStringAsFixed(2)}%",
            valueColor: profitColor,
            icon: Icons.percent,
          ),

          _infoTile(
            title: "Units",
            value: investment.units.toString(),
            icon: Icons.numbers,
          ),

          _infoTile(
            title: "Buy Price",
            value: "₹${investment.buyPrice.toStringAsFixed(2)}",
            icon: Icons.shopping_cart_outlined,
          ),

          _infoTile(
            title: "Current Price",
            value: "₹${investment.currentPrice.toStringAsFixed(2)}",
            icon: Icons.price_change_outlined,
          ),

          _infoTile(
            title: "Purchase Date",
            value:
                "${investment.purchaseDate.day}/${investment.purchaseDate.month}/${investment.purchaseDate.year}",
            icon: Icons.calendar_today_outlined,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _infoTile({
    required String title,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
        ),
      ),
    );
  }
}
