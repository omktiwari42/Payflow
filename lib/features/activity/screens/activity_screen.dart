import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../services/activity_api_service.dart';
import '../widgets/activity_empty_state.dart';
import '../widgets/activity_filter_chips.dart';
import '../widgets/activity_header.dart';
import '../widgets/activity_loading_skeleton.dart';
import '../widgets/activity_transaction_card.dart';
import 'transaction_details_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool isLoading = true;

  String? error;

  String selectedFilter = "All";

  final List<String> filters = ["All", "Sent", "Received", "Pending", "Failed"];

  List<ActivityModel> transactions = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      transactions = await ActivityApiService.instance.getTransactions();
    } catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = selectedFilter == "All"
        ? transactions
        : transactions.where((e) => e.type == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: Column(
        children: [
          ActivityHeader(onFilterTap: () {}),

          const SizedBox(height: 16),

          ActivityFilterChips(
            filters: filters,
            selected: selectedFilter,
            onChanged: (value) {
              setState(() {
                selectedFilter = value;
              });
            },
          ),

          const SizedBox(height: 16),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: isLoading
                  ? const ActivityLoadingSkeleton()
                  : error != null
                  ? ListView(
                      children: [
                        const SizedBox(height: 150),
                        Center(
                          child: Text(error!, textAlign: TextAlign.center),
                        ),
                      ],
                    )
                  : filtered.isEmpty
                  ? const ActivityEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                      itemCount: filtered.length,
                      itemBuilder: (_, index) {
                        final ActivityModel item = filtered[index];

                        return ActivityTransactionCard(
                          title: item.title,
                          subtitle: item.type,
                          amount: item.amount.toStringAsFixed(2),
                          time:
                              "${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}",
                          isCredit: item.type == "Received",
                          icon: item.type == "Received"
                              ? Icons.arrow_downward_rounded
                              : Icons.arrow_upward_rounded,
                          color: item.type == "Received"
                              ? Colors.green
                              : Colors.red,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const TransactionDetailsScreen(),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
