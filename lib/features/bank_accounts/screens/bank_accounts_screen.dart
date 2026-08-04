import 'package:flutter/material.dart';

import '../models/bank_account_model.dart';
import '../services/bank_account_api_service.dart';
import '../skeletons/bank_accounts_skeleton.dart';
import '../widgets/bank_account_card.dart';
import '../widgets/empty_bank_widget.dart';
import 'add_bank_account_screen.dart';

class BankAccountsScreen extends StatefulWidget {
  const BankAccountsScreen({super.key});

  @override
  State<BankAccountsScreen> createState() => _BankAccountsScreenState();
}

class _BankAccountsScreenState extends State<BankAccountsScreen> {
  List<BankAccountModel> _accounts = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    try {
      if (mounted) {
        setState(() {
          _loading = true;
        });
      }

      final accounts = await BankAccountApiService.instance.getBankAccounts();

      if (!mounted) return;

      setState(() {
        _accounts = accounts;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  Future<void> _goToAddScreen() async {
    final added = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddBankAccountScreen()),
    );

    if (added == true) {
      await _loadAccounts();
    }
  }

  Future<void> _deleteAccount(BankAccountModel account) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Account"),
        content: Text("Delete ${account.bankName} account?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await BankAccountApiService.instance.deleteBankAccount(account.id);

      await _loadAccounts();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bank account deleted successfully.")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  Future<void> _makePrimary(BankAccountModel account) async {
    try {
      await BankAccountApiService.instance.setPrimary(account.id);

      await _loadAccounts();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Primary account updated.")));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bank Accounts"), centerTitle: true),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToAddScreen,
        icon: const Icon(Icons.add),
        label: const Text("Add Account"),
      ),

      body: RefreshIndicator(
        onRefresh: _loadAccounts,
        child: _loading
            ? const BankAccountsSkeleton()
            : _accounts.isEmpty
            ? EmptyBankWidget(onAddAccount: _goToAddScreen)
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _accounts.length,
                itemBuilder: (_, index) {
                  final account = _accounts[index];

                  return BankAccountCard(
                    account: account,
                    onSetPrimary: () => _makePrimary(account),
                    onDelete: () => _deleteAccount(account),
                  );
                },
              ),
      ),
    );
  }
}
