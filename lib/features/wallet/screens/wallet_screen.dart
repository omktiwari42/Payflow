import 'package:flutter/material.dart';

import '../widgets/wallet_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/my_cards.dart';
import '../widgets/linked_bank_accounts.dart';
import '../widgets/recent_transactions.dart';
import '../widgets/monthly_spending.dart';
import '../widgets/finance_insights.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "My Wallet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          WalletCard(),
          SizedBox(height: 24),

          QuickActions(),
          SizedBox(height: 30),

          MyCards(),
          SizedBox(height: 30),

          LinkedBankAccounts(),
          SizedBox(height: 30),

          RecentTransactions(),
          SizedBox(height: 30),

          MonthlySpending(),
          SizedBox(height: 30),

          FinanceInsights(),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
