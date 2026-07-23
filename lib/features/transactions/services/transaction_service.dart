import '../models/transaction_model.dart';

class TransactionService {
  TransactionService._();

  static final TransactionService instance = TransactionService._();

  final List<TransactionModel> _transactions = [];

  List<TransactionModel> getAllTransactions() {
    final list = List<TransactionModel>.from(_transactions);
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return list;
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((transaction) => transaction.id == id);
  }

  void clearAllTransactions() {
    _transactions.clear();
  }

  List<TransactionModel> searchTransactions(String query) {
    if (query.trim().isEmpty) {
      return getAllTransactions();
    }

    final search = query.toLowerCase();

    return getAllTransactions().where((transaction) {
      return transaction.recipientName.toLowerCase().contains(search) ||
          transaction.upiId.toLowerCase().contains(search) ||
          transaction.note.toLowerCase().contains(search) ||
          transaction.id.toLowerCase().contains(search);
    }).toList();
  }

  List<TransactionModel> filterTransactions(String filter) {
    switch (filter) {
      case "Sent":
        return getAllTransactions()
            .where((transaction) => transaction.isSent)
            .toList();

      case "Received":
        return getAllTransactions()
            .where((transaction) => !transaction.isSent)
            .toList();

      case "Success":
        return getAllTransactions()
            .where((transaction) => transaction.status == "Success")
            .toList();

      case "Pending":
        return getAllTransactions()
            .where((transaction) => transaction.status == "Pending")
            .toList();

      case "Failed":
        return getAllTransactions()
            .where((transaction) => transaction.status == "Failed")
            .toList();

      default:
        return getAllTransactions();
    }
  }

  void seedDummyTransactions() {
    if (_transactions.isNotEmpty) return;

    _transactions.addAll([
      TransactionModel(
        id: "TXN100001",
        recipientName: "Rahul Sharma",
        upiId: "rahul@upi",
        amount: 250.00,
        note: "Lunch",
        status: "Success",
        dateTime: DateTime.now().subtract(const Duration(minutes: 15)),
        isSent: true,
      ),
      TransactionModel(
        id: "TXN100002",
        recipientName: "Aman Verma",
        upiId: "aman@ybl",
        amount: 1450.00,
        note: "Rent",
        status: "Success",
        dateTime: DateTime.now().subtract(const Duration(hours: 4)),
        isSent: true,
      ),
      TransactionModel(
        id: "TXN100003",
        recipientName: "Priya Singh",
        upiId: "priya@oksbi",
        amount: 850.00,
        note: "Received",
        status: "Success",
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        isSent: false,
      ),
      TransactionModel(
        id: "TXN100004",
        recipientName: "Vikas Kumar",
        upiId: "vikas@paytm",
        amount: 520.00,
        note: "Shopping",
        status: "Pending",
        dateTime: DateTime.now().subtract(const Duration(days: 2)),
        isSent: true,
      ),
      TransactionModel(
        id: "TXN100005",
        recipientName: "Sneha Patel",
        upiId: "sneha@ibl",
        amount: 300.00,
        note: "Coffee",
        status: "Failed",
        dateTime: DateTime.now().subtract(const Duration(days: 3)),
        isSent: true,
      ),
    ]);
  }
}
