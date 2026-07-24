import 'package:flutter/material.dart';

import '../models/bill_model.dart';
import '../services/bill_service.dart';
import '../skeletons/bill_skeleton.dart';
import '../widgets/bill_card.dart';
import '../widgets/bill_category.dart';
import '../widgets/upcoming_bill_tile.dart';
import 'pay_bill_screen.dart';

class BillPaymentsScreen extends StatefulWidget {
  const BillPaymentsScreen({super.key});

  @override
  State<BillPaymentsScreen> createState() => _BillPaymentsScreenState();
}

class _BillPaymentsScreenState extends State<BillPaymentsScreen> {
  final BillService _service = BillService.instance;

  final TextEditingController _searchController = TextEditingController();

  bool _loading = true;

  String _search = "";

  BillCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BillModel> get _filteredBills {
    return _service.bills.where((bill) {
      final searchMatch =
          bill.title.toLowerCase().contains(_search.toLowerCase()) ||
          bill.accountNumber.toLowerCase().contains(_search.toLowerCase());

      final categoryMatch =
          _selectedCategory == null || bill.category == _selectedCategory;

      return searchMatch && categoryMatch;
    }).toList();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {});
  }

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryGrid() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: .9,
      children: BillCategory.values.map((category) {
        return BillCategoryWidget(
          category: category,
          selected: _selectedCategory == category,
          onTap: () {
            setState(() {
              if (_selectedCategory == category) {
                _selectedCategory = null;
              } else {
                _selectedCategory = category;
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _searchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Search bills...",
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _search.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _searchController.clear();

                  setState(() {
                    _search = "";
                  });
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onChanged: (value) {
        setState(() {
          _search = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        appBar: null,
        body: SafeArea(
          child: Padding(padding: EdgeInsets.all(16), child: BillSkeleton()),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Bill Payments"), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                _summaryCard(
                  icon: Icons.receipt_long,
                  title: "Total Bills",
                  value: _service.totalBills.toString(),
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                _summaryCard(
                  icon: Icons.pending_actions,
                  title: "Pending",
                  value: _service.pendingBills.length.toString(),
                  color: Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _summaryCard(
                  icon: Icons.check_circle,
                  title: "Paid",
                  value: _service.paidBills.length.toString(),
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                _summaryCard(
                  icon: Icons.currency_rupee,
                  title: "Due Amount",
                  value: "₹${_service.totalPendingAmount.toStringAsFixed(0)}",
                  color: Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 24),

            _searchBar(),

            const SizedBox(height: 24),

            const Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _categoryGrid(),

            const SizedBox(height: 30),

            if (_service.pendingBills.isNotEmpty) ...[
              const Text(
                "Upcoming Bills",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 14),

              ..._service.pendingBills
                  .take(3)
                  .map(
                    (bill) => UpcomingBillTile(
                      bill: bill,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PayBillScreen(bill: bill),
                          ),
                        ).then((_) => setState(() {}));
                      },
                    ),
                  ),

              const SizedBox(height: 30),
            ],

            const Text(
              "All Bills",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 14),

            if (_filteredBills.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 70,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "No bills found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Try changing your search or category.",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            else
              ..._filteredBills.map(
                (bill) => BillCard(
                  bill: bill,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PayBillScreen(bill: bill),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  onPay: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PayBillScreen(bill: bill),
                      ),
                    ).then((_) => setState(() {}));
                  },
                ),
              ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add Bill screen coming next.")),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Bill"),
      ),
    );
  }
}
