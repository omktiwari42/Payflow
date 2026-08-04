import 'package:flutter/material.dart';

import '../services/wallet_api_service.dart';
import 'add_money_screen.dart';
import 'withdraw_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _hideBalance = false;
  bool _isLoading = true;

  Map<String, dynamic> wallet = {};

  @override
  void initState() {
    super.initState();
    _loadWallet();
  }

  Future<void> _loadWallet() async {
    try {
      final data = await WalletApiService.instance.getWallet();

      if (!mounted) return;

      setState(() {
        wallet = Map<String, dynamic>.from(data["wallet"] ?? {});
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  String get currency => wallet["currency"]?.toString() ?? "₹";

  double get balance =>
      double.tryParse(wallet["wallet_balance"].toString()) ?? 0;

  double get income => double.tryParse(wallet["total_income"].toString()) ?? 0;

  double get expense =>
      double.tryParse(wallet["total_expense"].toString()) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet"), centerTitle: true),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadWallet,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Available Balance",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _hideBalance
                                      ? "••••••"
                                      : "$currency${balance.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _hideBalance = !_hideBalance;
                                  });
                                },
                                icon: Icon(
                                  _hideBalance
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddMoneyScreen(),
                              ),
                            );

                            if (updated == true) {
                              await _loadWallet();
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Add Money"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WithdrawScreen(),
                              ),
                            );

                            if (updated == true) {
                              await _loadWallet();
                            }
                          },
                          icon: const Icon(Icons.remove),
                          label: const Text("Withdraw"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.green,
                                ),
                                const SizedBox(height: 8),
                                const Text("Income"),
                                Text(
                                  "$currency${income.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 8),
                                const Text("Expense"),
                                Text(
                                  "$currency${expense.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _actionTile(Icons.send, "Send Money"),
                      _actionTile(Icons.qr_code_scanner, "Scan & Pay"),
                      _actionTile(Icons.receipt_long, "Transactions"),
                      _actionTile(Icons.account_balance, "Bank Accounts"),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Recent Activity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.account_balance_wallet),
                      ),
                      title: const Text("Current Wallet Balance"),
                      subtitle: const Text("Synced from backend"),
                      trailing: Text(
                        "$currency${balance.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _actionTile(IconData icon, String title) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("$title coming soon")));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 34),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
