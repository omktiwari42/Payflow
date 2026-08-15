import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/animated_dashboard_card.dart';

import '../../notifications/screens/notifications_screen.dart';
import '../../notifications/services/notification_api_service.dart';
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
import '../widgets/notification_center_card.dart';
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
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  DashboardModel? dashboardData;

  bool isLoading = true;
  String? error;

  int unreadNotificationCount = 0;

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Send",
      "icon": Icons.send_rounded,
      "color": Colors.blue,
    },
    {
      "title": "Receive",
      "icon": Icons.download_rounded,
      "color": Colors.green,
    },
    {
      "title": "Scan",
      "icon": Icons.qr_code_scanner_rounded,
      "color": Colors.orange,
    },
    {
      "title": "Bills",
      "icon": Icons.receipt_long_rounded,
      "color": Colors.red,
    },
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
    {
      "title": "History",
      "icon": Icons.history_rounded,
      "color": Colors.teal,
    },
    {
      "title": "More",
      "icon": Icons.grid_view_rounded,
      "color": Colors.black54,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeDashboard();
  }

  // ============================================================
  // INITIAL LOAD
  // ============================================================

  Future<void> _initializeDashboard() async {
    await Future.wait([
      _loadDashboard(),
      _loadUnreadNotificationCount(),
    ]);
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> refreshDashboard() async {
    await _initializeDashboard();
  }

  // ============================================================
  // LOAD DASHBOARD
  // ============================================================

  Future<void> _loadDashboard() async {
    try {
      final data =
      await DashboardApiService.instance.getDashboard();

      if (!mounted) return;

      setState(() {
        dashboardData = data;
        error = null;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = _cleanError(e);
        isLoading = false;
      });
    }
  }

  // ============================================================
  // LOAD UNREAD NOTIFICATIONS
  // ============================================================

  Future<void> _loadUnreadNotificationCount() async {
    try {
      final count =
      await NotificationApiService.instance.getUnreadCount();

      if (!mounted) return;

      setState(() {
        unreadNotificationCount = count;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        unreadNotificationCount = 0;
      });
    }
  }

  // ============================================================
  // OPEN NOTIFICATIONS
  // ============================================================

  Future<void> _openNotifications() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NotificationsScreen(),
      ),
    );

    if (!mounted) return;

    await _loadUnreadNotificationCount();
  }

  // ============================================================
  // ERROR
  // ============================================================

  String _cleanError(Object error) {
    return error
        .toString()
        .replaceFirst("Exception: ", "");
  }

  // ============================================================
  // NOTIFICATION BELL
  // ============================================================

  Widget _buildNotificationBell() {
    return IconButton(
      onPressed: _openNotifications,
      tooltip: "Notifications",
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 27,
          ),
          if (unreadNotificationCount > 0)
            Positioned(
              right: -5,
              top: -5,
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  unreadNotificationCount > 99
                      ? "99+"
                      : unreadNotificationCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const _DashboardSkeleton();
    }

    if (error != null) {
      return Scaffold(
        backgroundColor: const Color(0xffF4F7FC),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_off_rounded,
                    size: 52,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Unable to load dashboard",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _initializeDashboard,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF4F7FC),
      body: RefreshIndicator(
        onRefresh: refreshDashboard,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // ========================================================
            // HEADER
            // ========================================================

            SliverAppBar(
              pinned: true,
              expandedHeight: 430,
              elevation: 0,
              backgroundColor: const Color(0xff2563EB),
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff2563EB),
                        Color(0xff1D4ED8),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        20,
                        20,
                        12,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Good Evening",
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      dashboardData?.fullName ??
                                          "User",
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _buildNotificationBell(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          BalanceCard(
                            balance:
                            "₹${dashboardData?.walletBalance.toStringAsFixed(
                                2) ?? "0.00"}",
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

            // ========================================================
            // BODY
            // ========================================================

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // ==================================================
                    // QUICK ACTIONS
                    // ==================================================

                    const SectionTitle(
                      title: "Quick Actions",
                    ),
                    const SizedBox(height: 16),

                    GridView.builder(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: quickActions.length,
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

                    const SizedBox(height: 24),

                    // ==================================================
                    // NOTIFICATION CENTER
                    // ==================================================

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 120),
                      child:
                      const NotificationCenterCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 150),
                      child: const PeopleBusinessCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 180),
                      child: const ScanPayCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      child: const CardCarousel(),
                    ),

                    const SizedBox(height: 12),

                    // ==================================================
                    // STATS
                    // ==================================================

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 200),
                      child: Row(
                        children: [
                          Expanded(
                            child: DashboardStatsCard(
                              title: "Income",
                              amount:
                              dashboardData
                                  ?.totalReceived ??
                                  0,
                              icon:
                              Icons.south_west,
                              color:
                              Colors.green,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DashboardStatsCard(
                              title: "Expense",
                              amount:
                              dashboardData
                                  ?.totalSent ??
                                  0,
                              icon:
                              Icons.north_east,
                              color:
                              Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ==================================================
                    // RECENT TRANSACTIONS
                    // ==================================================

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 300),
                      child: LiveRecentTransactions(
                        transactions:
                        dashboardData
                            ?.recentTransactions ??
                            const [],
                      ),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 400),
                      child: const BillsDueCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 500),
                      child:
                      const FinancialServicesCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 600),
                      child: const TravelBookingCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 700),
                      child: const CashbackOffersCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 800),
                      child: const UpiServicesCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 900),
                      child: const ShoppingCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 1000),
                      child: const ReferEarnCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 1100),
                      child: const InsuranceCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 1200),
                      child: const LoanServicesCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 1300),
                      child: const ManageMoneyCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 1400),
                      child: const SmartWalletCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 1500),
                      child: const MultiCurrencyCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 1600),
                      child:
                      const RewardsCashbackCard(),
                    ),

                    const SizedBox(height: 28),

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 1700),
                      child:
                      const WeeklySpendingChart(),
                    ),

                    const SizedBox(height: 28),

                    // ==================================================
                    // TRANSACTION HISTORY
                    // ==================================================

                    const SectionTitle(
                      title: "Recent Transactions",
                    ),
                    const SizedBox(height: 12),

                    _buildTransactionList(),

                    const SizedBox(height: 32),

                    // ==================================================
                    // PREMIUM
                    // ==================================================

                    AnimatedDashboardCard(
                      delay:
                      const Duration(milliseconds: 2200),
                      child: Container(
                        padding:
                        const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(24),
                          gradient:
                          const LinearGradient(
                            colors: [
                              Color(0xff4F46E5),
                              Color(0xff2563EB),
                            ],
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    "PayFlow Premium",
                                    style: TextStyle(
                                      color:
                                      Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Earn cashback, rewards and exclusive offers.",
                                    style: TextStyle(
                                      color:
                                      Colors.white70,
                                    ),
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

  // ============================================================
  // TRANSACTION LIST
  // ============================================================

  Widget _buildTransactionList() {
    final transactions =
        dashboardData?.recentTransactions ?? const [];

    if (transactions.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          "No recent transactions.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final rawTransaction = transactions[index];

        if (rawTransaction
        is! Map<String, dynamic>) {
          return const SizedBox.shrink();
        }

        final amount =
            double.tryParse(
              rawTransaction["amount"]
                  ?.toString() ??
                  "",
            ) ??
                0.0;

        return AnimatedDashboardCard(
          delay: Duration(
            milliseconds:
            1800 + (index * 100),
          ),
          child: TransactionTile(
            title:
            rawTransaction["title"]
                ?.toString() ??
                "Transaction",
            subtitle:
            rawTransaction["created_at"]
                ?.toString() ??
                "",
            amount:
            "₹${amount.toStringAsFixed(2)}",
            icon:
            Icons.swap_horiz,
            color:
            Colors.blue,
          ),
        );
      },
    );
  }
}

// ============================================================
// DASHBOARD SKELETON
// ============================================================

class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xffF4F7FC),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 60),

          _SkeletonBox(
            height: 180,
            radius: 24,
          ),

          const SizedBox(height: 20),

          Row(
            children: List.generate(
              4,
                  (_) =>
              const Expanded(
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  child: _SkeletonBox(
                    height: 80,
                    radius: 18,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          ...List.generate(
            7,
                (_) =>
            const Padding(
              padding:
              EdgeInsets.only(bottom: 16),
              child: _SkeletonBox(
                height: 90,
                radius: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double height;
  final double radius;

  const _SkeletonBox({
    required this.height,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius:
        BorderRadius.circular(radius),
      ),
    );
  }
}