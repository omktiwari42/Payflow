import '../models/wallet_model.dart';

class WalletService {
  WalletService._();

  static final WalletService instance = WalletService._();

  WalletModel _wallet = const WalletModel(
    balance: 5000.00,
    totalIncome: 10000.00,
    totalExpense: 5000.00,
  );

  WalletModel get wallet => _wallet;

  double get balance => _wallet.balance;

  void addMoney(double amount) {
    if (amount <= 0) return;

    _wallet = _wallet.copyWith(
      balance: _wallet.balance + amount,
      totalIncome: _wallet.totalIncome + amount,
    );
  }

  bool withdrawMoney(double amount) {
    if (amount <= 0) return false;

    if (_wallet.balance < amount) {
      return false;
    }

    _wallet = _wallet.copyWith(
      balance: _wallet.balance - amount,
      totalExpense: _wallet.totalExpense + amount,
    );

    return true;
  }

  bool sendMoney(double amount) {
    return withdrawMoney(amount);
  }

  void resetWallet() {
    _wallet = const WalletModel(balance: 0, totalIncome: 0, totalExpense: 0);
  }

  void loadDummyData() {
    _wallet = const WalletModel(
      balance: 5000,
      totalIncome: 10000,
      totalExpense: 5000,
    );
  }
}
