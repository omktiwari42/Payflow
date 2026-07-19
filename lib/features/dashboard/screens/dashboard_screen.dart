import 'package:flutter/material.dart';

import '../widgets/balance_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/section_title.dart';
import '../widgets/transaction_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

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
      "title": "QR Pay",
      "icon": Icons.qr_code_scanner_rounded,
      "color": Colors.orange,
    },
    {
      "title": "Recharge",
      "icon": Icons.phone_android_rounded,
      "color": Colors.purple,
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
      "title": "History",
      "icon": Icons.history_rounded,
      "color": Colors.teal,
    },
    {
      "title": "More",
      "icon": Icons.grid_view_rounded,
      "color": Colors.black87,
    },
  ];

  final List<Map<String, dynamic>> transactions = [
    {
      "name": "Amazon",
      "time": "Today • 10:25 AM",
      "amount": "- ₹2,499",
      "icon": Icons.shopping_bag,
      "color": Colors.orange,
    },
    {
      "name": "Salary",
      "time": "Yesterday",
      "amount": "+ ₹55,000",
      "icon": Icons.account_balance_wallet,
      "color": Colors.green,
    },
    {
      "name": "Netflix",
      "time": "Yesterday",
      "amount": "- ₹649",
      "icon": Icons.movie,
      "color": Colors.red,
    },
    {
      "name": "Electricity",
      "time": "2 Days Ago",
      "amount": "- ₹1,240",
      "icon": Icons.bolt,
      "color": Colors.amber,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              elevation: 0,
              backgroundColor: const Color(0xff2563EB),

              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff2563EB),
                        Color(0xff1D4ED8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      55,
                      20,
                      20,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                color: Color(0xff2563EB),
                              ),
                            ),

                            const SizedBox(width: 14),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    "Good Evening 👋",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    "Om Kumar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeight.bold,
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

                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.qr_code_scanner,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        const BalanceCard(
                          balance: "₹1,24,560.45",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const SectionTitle(
                      title: "Quick Actions",
                    ),

                    const SizedBox(height: 20),

                    GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: quickActions.length,

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: .82,
                      ),

                      itemBuilder: (context, index) {

                        final item =
                            quickActions[index];

                        return QuickActionButton(
                          title: item["title"],
                          icon: item["icon"],
                          color: item["color"],
                          onTap: () {},
                        );
                      },
                    ),

                    const SizedBox(height: 35),

                    const SectionTitle(
                      title: "Recent Transactions",
                    ),

                    const SizedBox(height: 15),
                                        ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactions.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final item = transactions[index];

                        return TransactionTile(
                          title: item["name"],
                          subtitle: item["time"],
                          amount: item["amount"],
                          icon: item["icon"],
                          color: item["color"],
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff2563EB),
                            Color(0xff1D4ED8),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "PayFlow Rewards",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Earn cashback on every payment and unlock exclusive rewards.",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Icon(
                            Icons.workspace_premium_rounded,
                            color: Colors.amber,
                            size: 60,
                          ),
                        ],
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

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: "Wallet",
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner_outlined),
            selectedIcon: Icon(Icons.qr_code_scanner),
            label: "Scan",
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: "History",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}