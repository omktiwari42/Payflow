import 'package:flutter/material.dart';

import '../models/bill_model.dart';
import '../services/bill_service.dart';

enum BillHistoryFilter { all, paid, pending, overdue }

class BillHistoryScreen extends StatefulWidget {
  const BillHistoryScreen({super.key});

  @override
  State<BillHistoryScreen> createState() => _BillHistoryScreenState();
}

class _BillHistoryScreenState extends State<BillHistoryScreen> {
  final BillService _service = BillService.instance;

  final TextEditingController _searchController = TextEditingController();

  BillHistoryFilter _filter = BillHistoryFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BillModel> get _filteredBills {
    final search = _searchController.text.toLowerCase();

    return _service.bills.where((bill) {
      final matchesSearch =
          bill.title.toLowerCase().contains(search) ||
          bill.accountNumber.toLowerCase().contains(search);

      if (!matchesSearch) return false;

      switch (_filter) {
        case BillHistoryFilter.all:
          return true;

        case BillHistoryFilter.paid:
          return bill.status == BillStatus.paid;

        case BillHistoryFilter.pending:
          return bill.status == BillStatus.pending;

        case BillHistoryFilter.overdue:
          return bill.isOverdue;
      }
    }).toList();
  }

  Widget _filterChip(String label, BillHistoryFilter value) {
    final selected = _filter == value;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          _filter = value;
        });
      },
    );
  }

  Color _statusColor(BillModel bill) {
    switch (bill.status) {
      case BillStatus.paid:
        return Colors.green;

      case BillStatus.pending:
        return Colors.orange;

      case BillStatus.overdue:
        return Colors.red;
    }
  }

  String _statusText(BillModel bill) {
    switch (bill.status) {
      case BillStatus.paid:
        return "Paid";

      case BillStatus.pending:
        return "Pending";

      case BillStatus.overdue:
        return "Overdue";
    }
  }

  Widget _historyCard(BillModel bill) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(child: const Icon(Icons.receipt_long)),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bill.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        bill.accountNumber,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(bill).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    _statusText(bill),
                    style: TextStyle(
                      color: _statusColor(bill),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                const Icon(Icons.currency_rupee, size: 18),

                const SizedBox(width: 6),

                Text(
                  bill.amount.toStringAsFixed(2),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

                const Spacer(),

                Text(
                  bill.paidOn != null
                      ? "${bill.paidOn!.day}/${bill.paidOn!.month}/${bill.paidOn!.year}"
                      : "${bill.dueDate.day}/${bill.dueDate.month}/${bill.dueDate.year}",
                ),
              ],
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: bill.status == BillStatus.paid
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Receipt feature coming soon."),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.receipt),
                label: const Text("Receipt"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bill History"), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 700));

          if (!mounted) return;

          setState(() {});
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search bills...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _filterChip("All", BillHistoryFilter.all),
                _filterChip("Paid", BillHistoryFilter.paid),
                _filterChip("Pending", BillHistoryFilter.pending),
                _filterChip("Overdue", BillHistoryFilter.overdue),
              ],
            ),

            const SizedBox(height: 24),

            if (_filteredBills.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "No bill history found",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Completed payments will appear here.",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            else
              ..._filteredBills.map((bill) => _historyCard(bill)),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
        label: const Text("Back"),
      ),
    );
  }
}
