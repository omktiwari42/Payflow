import 'package:flutter/foundation.dart';

import '../models/bill_model.dart';

class BillService extends ChangeNotifier {
  BillService._();

  static final BillService instance = BillService._();

  final List<BillModel> _bills = [
    BillModel(
      id: "1",
      title: "Electricity Bill",
      category: BillCategory.electricity,
      accountNumber: "ELEC-987654321",
      amount: 1850.75,
      dueDate: DateTime.now().add(const Duration(days: 5)),
    ),
    BillModel(
      id: "2",
      title: "Broadband",
      category: BillCategory.broadband,
      accountNumber: "BB-123456789",
      amount: 999.00,
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    BillModel(
      id: "3",
      title: "Mobile Recharge",
      category: BillCategory.mobile,
      accountNumber: "9389795509",
      amount: 399.00,
      dueDate: DateTime.now().add(const Duration(days: 10)),
      status: BillStatus.paid,
      paidOn: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<BillModel> get bills => List.unmodifiable(_bills);

  List<BillModel> get pendingBills =>
      _bills.where((bill) => bill.status == BillStatus.pending).toList();

  List<BillModel> get paidBills =>
      _bills.where((bill) => bill.status == BillStatus.paid).toList();

  List<BillModel> get overdueBills =>
      _bills.where((bill) => bill.isOverdue).toList();

  void addBill(BillModel bill) {
    _bills.add(bill);
    notifyListeners();
  }

  void removeBill(String id) {
    _bills.removeWhere((bill) => bill.id == id);
    notifyListeners();
  }

  void payBill(String id) {
    final index = _bills.indexWhere((bill) => bill.id == id);

    if (index == -1) return;

    _bills[index] = _bills[index].copyWith(
      status: BillStatus.paid,
      paidOn: DateTime.now(),
    );

    notifyListeners();
  }

  void toggleAutoPay(String id) {
    final index = _bills.indexWhere((bill) => bill.id == id);

    if (index == -1) return;

    final bill = _bills[index];

    _bills[index] = bill.copyWith(autoPay: !bill.autoPay);

    notifyListeners();
  }

  BillModel? getBill(String id) {
    try {
      return _bills.firstWhere((bill) => bill.id == id);
    } catch (_) {
      return null;
    }
  }

  double get totalPendingAmount =>
      pendingBills.fold(0.0, (sum, bill) => sum + bill.amount);

  int get totalBills => _bills.length;

  bool get hasBills => _bills.isNotEmpty;

  void clearBills() {
    _bills.clear();
    notifyListeners();
  }
}
