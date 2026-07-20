
import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/section_title.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/weekly_spending_chart.dart';
import '../widgets/card_carousel.dart';
import '../widgets/income_expense_card.dart';
import '../widgets/recent_payments.dart';
import '../widgets/bills_due_card.dart';
import '../widgets/spending_categories_card.dart';
import '../widgets/budget_tracker_card.dart';
import '../widgets/financial_goals_card.dart';
import '../widgets/investment_portfolio_card.dart';
import '../widgets/ai_finance_assistant_card.dart';
import '../widgets/smart_insights_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

final List<Map<String, dynamic>> quickActions = [
    {"title":"Send","icon":Icons.send_rounded,"color":Colors.blue},
    {"title":"Receive","icon":Icons.download_rounded,"color":Colors.green},
    {"title":"Scan","icon":Icons.qr_code_scanner_rounded,"color":Colors.orange},
    {"title":"Bills","icon":Icons.receipt_long_rounded,"color":Colors.red},
    {"title":"Bank","icon":Icons.account_balance_rounded,"color":Colors.indigo},
    {"title":"Recharge","icon":Icons.phone_android_rounded,"color":Colors.purple},
    {"title":"History","icon":Icons.history_rounded,"color":Colors.teal},
    {"title":"More","icon":Icons.grid_view_rounded,"color":Colors.black54},
  ];

final List<Map<String, dynamic>> transactions = [
    {"title":"Amazon","subtitle":"Today · 10:25 AM","amount":"- ₹2,499","icon":Icons.shopping_bag,"color":Colors.orange},
    {"title":"Salary","subtitle":"Yesterday","amount":"+ ₹55,000","icon":Icons.account_balance_wallet,"color":Colors.green},
    {"title":"Netflix","subtitle":"Yesterday","amount":"- ₹649","icon":Icons.movie,"color":Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FC),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 340,
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
                    padding: const EdgeInsets.fromLTRB(20,20,20,24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(radius:24,child:Icon(Icons.person)),
                            const SizedBox(width:12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text("Good Evening",style:TextStyle(color:Colors.white70)),
                                  SizedBox(height:4),
                                  Text("Om Kumar",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:22))
                                ],
                              ),
                            ),
                            IconButton(onPressed:(){},icon:const Icon(Icons.notifications_none,color:Colors.white)),
                          ],
                        ),
                        const Spacer(),
                        const BalanceCard(balance: "₹10,24,560.45"),
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
                  const SizedBox(height:16),
                  GridView.builder(
                    shrinkWrap:true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quickActions.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:4,
                      crossAxisSpacing:10,
                      mainAxisSpacing:10,
                      mainAxisExtent:100,
                    ),
                    itemBuilder:(context,index){
                      final item=quickActions[index];
                      return QuickActionButton(
                        title:item["title"] as String,
                        icon:item["icon"] as IconData,
                        color:item["color"] as Color,
                        onTap:(){},
                      );
                    },
                  ),
                 const SizedBox(height: 28),

const CardCarousel(),

const SizedBox(height: 28),

const IncomeExpenseCard(),

const SizedBox(height: 28),

const RecentPayments(),

const SizedBox(height: 28),

const BillsDueCard(),

const SizedBox(height: 28),

const SpendingCategoriesCard(),

const SizedBox(height: 28),

const BudgetTrackerCard(),

const SizedBox(height: 28),

const FinancialGoalsCard(),

const SizedBox(height: 28),

const InvestmentPortfolioCard(),

const SizedBox(height: 28),

const AIFinanceAssistantCard(),

const SizedBox(height: 28),

const SmartInsightsCard(),

const SizedBox(height: 28),


const WeeklySpendingChart(),

const SizedBox(height: 28),

const SectionTitle(title: "Recent Transactions"),
                  const SizedBox(height:12),
                  ListView.separated(
                    shrinkWrap:true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:transactions.length,
                    separatorBuilder:(_,__)=>const SizedBox(height:12),
                    itemBuilder:(context,index){
                      final t=transactions[index];
                      return TransactionTile(
                        title:t["title"] as String,
                        subtitle:t["subtitle"] as String,
                        amount:t["amount"] as String,
                        icon:t["icon"] as IconData,
                        color:t["color"] as Color,
                      );
                    },
                  ),
                  const SizedBox(height:32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(colors:[Color(0xff4F46E5),Color(0xff2563EB)]),
                    ),
                    child: const Row(
                      children:[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("PayFlow Premium",style:TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold)),
                              SizedBox(height:8),
                              Text("Earn cashback, rewards and exclusive offers.",style:TextStyle(color:Colors.white70)),
                            ],
                          ),
                        ),
                        Icon(Icons.workspace_premium,color:Colors.amber,size:56),
                      ],
                    ),
                  ),
                  const SizedBox(height:100),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex:selectedIndex,
        onDestinationSelected:(i)=>setState(()=>selectedIndex=i),
        destinations: const [
          NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:"Home"),
          NavigationDestination(icon:Icon(Icons.wallet_outlined),selectedIcon:Icon(Icons.wallet),label:"Wallet"),
          NavigationDestination(icon:Icon(Icons.qr_code_scanner_outlined),selectedIcon:Icon(Icons.qr_code_scanner),label:"Scan"),
          NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:"Profile"),
        ],
      ),
    );
  }
}
