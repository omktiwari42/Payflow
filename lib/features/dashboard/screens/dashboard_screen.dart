import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/animated_dashboard_card.dart';

import '../models/dashboard_model.dart';
import '../services/dashboard_api_service.dart';
import '../widgets/balance_card.dart';
import '../widgets/bills_due_card.dart';
import '../widgets/card_carousel.dart';
import '../widgets/cashback_offers_card.dart';
import '../widgets/dashboard_stats_card.dart';
import '../widgets/financial_services_card.dart';
import '../widgets/insurance_card.dart';
import '../widgets/live_recent_transactions.dart';
import '../widgets/loan_services_card.dart';
import '../widgets/manage_money_card.dart';
import '../widgets/multi_currency_card.dart';
import '../widgets/people_business_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/refer_earn_card.dart';
import '../widgets/rewards_cashback_card.dart';
import '../widgets/scan_pay_card.dart';
import '../widgets/section_title.dart';
import '../widgets/shopping_card.dart';
import '../widgets/smart_wallet_card.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/travel_booking_card.dart';
import '../widgets/upi_services_card.dart';
import '../widgets/weekly_spending_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  DashboardModel? dashboardData;

  bool isLoading = true;

  String? error;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> quickActions = [
    {"title": "Send", "icon": Icons.send_rounded, "color": Colors.blue},
    {"title": "Receive", "icon": Icons.download_rounded, "color": Colors.green},
    {
      "title": "Scan",
      "icon": Icons.qr_code_scanner_rounded,
      "color": Colors.orange,
    },
    {"title": "Bills", "icon": Icons.receipt_long_rounded, "color": Colors.red},
    {
      "title": "Bank",
      "icon": Icons.account_balance_rounded,
      "color": Colors.indigo,
    },
    {
      "title": "Recharge",
      "icon": Icons.phone_android_rounded,
      "color": Colors.purple,
    },
    {"title": "History", "icon": Icons.history_rounded, "color": Colors.teal},
    {"title": "More", "icon": Icons.grid_view_rounded, "color": Colors.black54},
  ];

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> refreshDashboard() async {
    await _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    try {
      final DashboardModel data = await DashboardApiService.instance
          .getDashboard();

      if (!mounted) return;

      setState(() {
        dashboardData = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xffF4F7FC),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 60),

            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(24),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: List.generate(
                4,
                (_) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ...List.generate(
              6,
              (_) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (error != null) {
      return Scaffold(body: Center(child: Text(error!)));
    }

    return Scaffold(
      backgroundColor: const Color(0xffF4F7FC),
      body: RefreshIndicator(
        onRefresh: _loadDashboard,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 430,
              elevation: 0,
              backgroundColor: const Color(0xff2563EB),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 24,
                                child: Icon(Icons.person),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Good Evening",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      dashboardData?.fullName ?? "User",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          BalanceCard(
                            balance:
                                "₹${dashboardData?.walletBalance.toStringAsFixed(2) ?? "0.00"}",
                            onAddMoney: () {},
                            onTransfer: () {},
                            onScanQR: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(title: "Quick Actions"),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: quickActions.length,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 18,
                            childAspectRatio: 0.92,
                          ),
                      itemBuilder: (context, index) {
                        final item = quickActions[index];

                        return QuickActionButton(
                          title: item["title"] as String,
                          icon: item["icon"] as IconData,
                          color: item["color"] as Color,
                          onTap: () {},
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 150),
                      child: const PeopleBusinessCard(),
                    ),

                    const SizedBox(height: 28),
                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 180),
                      child: const ScanPayCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(child: const CardCarousel()),

                    const SizedBox(height: 12),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 200),
                      child: Row(
                        children: [
                          DashboardStatsCard(
                            title: "Income",
                            amount: dashboardData?.totalReceived ?? 0,
                            icon: Icons.south_west,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 16),
                          DashboardStatsCard(
                            title: "Expense",
                            amount: dashboardData?.totalSent ?? 0,
                            icon: Icons.north_east,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 300),
                      child: LiveRecentTransactions(
                        transactions: dashboardData?.recentTransactions ?? [],
                      ),
                    ),
                    const SizedBox(height: 12),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 400),
                      child: const BillsDueCard(),
                    ),
                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 500),
                      child: const FinancialServicesCard(),
                    ),
                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 600),
                      child: const TravelBookingCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 700),
                      child: const CashbackOffersCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 800),
                      child: const UpiServicesCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 900),
                      child: const ShoppingCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 1000),
                      child: const ReferEarnCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 1100),
                      child: const InsuranceCard(),
                    ),

                    const SizedBox(height: 28),
                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 1200),
                      child: const LoanServicesCard(),
                    ),

                    const SizedBox(height: 28),
                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 1300),
                      child: const ManageMoneyCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 1400),
                      child: const SmartWalletCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 1500),
                      child: const MultiCurrencyCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 1600),
                      child: const RewardsCashbackCard(),
                    ),
                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 1700),
                      child: const WeeklySpendingChart(),
                    ),

                    const SizedBox(height: 28),

                    const SectionTitle(title: "Recent Transactions"),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dashboardData?.recentTransactions.length ?? 0,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final t =
                            dashboardData!.recentTransactions[index]
                                as Map<String, dynamic>;
                        return AnimatedDashboardCard(
                          delay: Duration(milliseconds: 1800 + (index * 100)),
                          child: TransactionTile(
                            title: "Transaction",
                            subtitle: t["created_at"]?.toString() ?? "",
                            amount:
                                "₹${double.tryParse(t["amount"].toString())?.toStringAsFixed(2) ?? "0.00"}",
                            icon: Icons.swap_horiz,
                            color: Colors.blue,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    AnimatedDashboardCard(
                      delay: const Duration(milliseconds: 2200),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            colors: [Color(0xff4F46E5), Color(0xff2563EB)],
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PayFlow Premium",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Earn cashback, rewards and exclusive offers.",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.workspace_premium,
                              color: Colors.amber,
                              size: 56,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
