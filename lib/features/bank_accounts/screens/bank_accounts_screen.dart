import 'package:flutter/material.dart';

import '../models/bank_account_model.dart';
import '../services/bank_account_service.dart';
import 'add_bank_account_screen.dart';

class BankAccountsScreen extends StatefulWidget {
  const BankAccountsScreen({super.key});

  @override
  State<BankAccountsScreen> createState() => _BankAccountsScreenState();
}

class _BankAccountsScreenState extends State<BankAccountsScreen> {
  final BankAccountService service = BankAccountService.instance;

  List<BankAccountModel> accounts = [];

  @override
  void initState() {
    super.initState();
    service.loadDummyAccounts();
    _loadAccounts();
  }

  void _loadAccounts() {
    setState(() {
      accounts = service.getAccounts();
    });
  }

  Future<void> _deleteAccount(BankAccountModel account) async {
    final delete = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Remove Account"),
        content: Text("Remove ${account.bankName} account?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Remove"),
          ),
        ],
      ),
    );

    if (delete == true) {
      service.removeAccount(account.id);
      _loadAccounts();
    }
  }

  void _setPrimary(BankAccountModel account) {
    service.setPrimaryAccount(account.id);
    _loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bank Accounts"), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBankAccountScreen()),
          );

          if (result == true) {
            _loadAccounts();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadAccounts();
        },
        child: accounts.isEmpty
            ? const Center(
                child: Text(
                  "No linked bank accounts",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: accounts.length,
                itemBuilder: (_, index) {
                  final account = accounts[index];

                  return Dismissible(
                    key: ValueKey(account.id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (_) async {
                      await _deleteAccount(account);
                      return false;
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            account.bankName[0],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                account.bankName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (account.isPrimary)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Primary",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Text(account.accountHolderName),
                            Text(account.maskedAccountNumber),
                            Text("IFSC: ${account.ifscCode}"),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == "primary") {
                              _setPrimary(account);
                            }

                            if (value == "delete") {
                              _deleteAccount(account);
                            }
                          },
                          itemBuilder: (_) => [
                            if (!account.isPrimary)
                              const PopupMenuItem(
                                value: "primary",
                                child: Text("Set as Primary"),
                              ),
                            const PopupMenuItem(
                              value: "delete",
                              child: Text("Delete"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
