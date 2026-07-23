import '../models/bank_account_model.dart';

class BankAccountService {
  BankAccountService._();

  static final BankAccountService instance = BankAccountService._();

  final List<BankAccountModel> _accounts = [];

  List<BankAccountModel> getAccounts() {
    return List<BankAccountModel>.from(_accounts);
  }

  void addAccount(BankAccountModel account) {
    if (_accounts.isEmpty) {
      _accounts.add(account.copyWith(isPrimary: true));
    } else {
      _accounts.add(account);
    }
  }

  void removeAccount(String id) {
    final removedAccount = _accounts.firstWhere(
      (account) => account.id == id,
      orElse: () => throw Exception("Account not found"),
    );

    final wasPrimary = removedAccount.isPrimary;

    _accounts.removeWhere((account) => account.id == id);

    if (wasPrimary && _accounts.isNotEmpty) {
      _accounts[0] = _accounts[0].copyWith(isPrimary: true);
    }
  }

  void setPrimaryAccount(String id) {
    for (int i = 0; i < _accounts.length; i++) {
      _accounts[i] = _accounts[i].copyWith(isPrimary: _accounts[i].id == id);
    }
  }

  BankAccountModel? getPrimaryAccount() {
    try {
      return _accounts.firstWhere((account) => account.isPrimary);
    } catch (_) {
      return null;
    }
  }

  BankAccountModel? findById(String id) {
    try {
      return _accounts.firstWhere((account) => account.id == id);
    } catch (_) {
      return null;
    }
  }

  void loadDummyAccounts() {
    if (_accounts.isNotEmpty) return;

    _accounts.addAll([
      const BankAccountModel(
        id: "1",
        bankName: "State Bank of India",
        accountHolderName: "Om Kumar Tiwari",
        accountNumber: "123456789012",
        ifscCode: "SBIN0001234",
        isPrimary: true,
      ),
      const BankAccountModel(
        id: "2",
        bankName: "HDFC Bank",
        accountHolderName: "Om Kumar Tiwari",
        accountNumber: "987654321098",
        ifscCode: "HDFC0005678",
      ),
      const BankAccountModel(
        id: "3",
        bankName: "ICICI Bank",
        accountHolderName: "Om Kumar Tiwari",
        accountNumber: "456789123456",
        ifscCode: "ICIC0009876",
      ),
    ]);
  }

  void clearAccounts() {
    _accounts.clear();
  }
}
