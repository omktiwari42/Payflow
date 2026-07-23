import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TransactionService service = TransactionService.instance;

  final TextEditingController _searchController = TextEditingController();

  List<TransactionModel> transactions = [];

  String selectedFilter = "All";

  final filters = ["All", "Sent", "Received", "Success", "Pending", "Failed"];

  @override
  void initState() {
    super.initState();
    service.seedDummyTransactions();
    _loadTransactions();
  }

  void _loadTransactions() {
    setState(() {
      transactions = service.getAllTransactions();
    });
  }

  void _search(String value) {
    setState(() {
      if (value.isEmpty) {
        _applyFilter(selectedFilter);
      } else {
        transactions = service.searchTransactions(value);
      }
    });
  }

  void _applyFilter(String filter) {
    selectedFilter = filter;

    setState(() {
      transactions = service.filterTransactions(filter);
    });
  }

  Color statusColor(String status) {
    switch (status) {
      case "Success":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Failed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData transactionIcon(bool sent) {
    return sent ? Icons.arrow_upward : Icons.arrow_downward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              service.clearAllTransactions();
              _loadTransactions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: "Search transaction...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (_, index) {
                final filter = filters[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: selectedFilter == filter,
                    onSelected: (_) => _applyFilter(filter),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _loadTransactions();
              },
              child: transactions.isEmpty
                  ? const Center(
                      child: Text(
                        "No Transactions Found",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (_, index) {
                        final tx = transactions[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(transactionIcon(tx.isSent)),
                            ),
                            title: Text(tx.recipientName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tx.upiId),
                                Text(
                                  tx.dateTime.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₹${tx.amount.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  tx.status,
                                  style: TextStyle(
                                    color: statusColor(tx.status),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
