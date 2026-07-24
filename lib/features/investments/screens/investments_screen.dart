import 'package:flutter/material.dart';

import '../models/investment_model.dart';
import '../services/investment_service.dart';
import '../skeletons/investments_skeleton.dart';
import '../widgets/investment_card.dart';
import '../widgets/performance_chart.dart';
import '../widgets/portfolio_summary.dart';
import 'investment_details_screen.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  final InvestmentService service = InvestmentService.instance;

  bool _loading = true;
  InvestmentType? selectedType;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      _loading = false;
    });
  }

  Future<void> _refresh() async {
    setState(() => _loading = true);

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() => _loading = false);
  }

  List<InvestmentModel> get filteredInvestments {
    final query = searchController.text.trim().toLowerCase();

    return service.investments.where((investment) {
      final matchesSearch = investment.name.toLowerCase().contains(query);

      final matchesType =
          selectedType == null || investment.type == selectedType;

      return matchesSearch && matchesType;
    }).toList();
  }

  List<double> get chartValues =>
      filteredInvestments.map((e) => e.currentValue).toList();

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const InvestmentsSkeleton();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Add Investment feature coming soon."),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              "Investments",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 20),

            PortfolioSummary(service: service),

            const SizedBox(height: 24),

            PerformanceChart(values: chartValues),

            const SizedBox(height: 24),

            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search investments...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text("All"),
                    selected: selectedType == null,
                    onSelected: (_) {
                      setState(() {
                        selectedType = null;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ...InvestmentType.values.map(
                    (type) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(type.name),
                        selected: selectedType == type,
                        onSelected: (_) {
                          setState(() {
                            selectedType = type;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (filteredInvestments.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 72,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No investments found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Try changing your search or filter.",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            else
              ...filteredInvestments.map(
                (investment) => InvestmentCard(
                  investment: investment,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            InvestmentDetailsScreen(investment: investment),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
