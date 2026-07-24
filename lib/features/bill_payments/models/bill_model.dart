enum BillCategory {
  electricity,
  water,
  gas,
  mobile,
  broadband,
  dth,
  insurance,
  creditCard,
  fastag,
  education,
}

enum BillStatus { pending, paid, overdue }

class BillModel {
  final String id;
  final String title;
  final BillCategory category;
  final String accountNumber;
  final double amount;
  final DateTime dueDate;
  final BillStatus status;
  final bool autoPay;
  final DateTime? paidOn;

  const BillModel({
    required this.id,
    required this.title,
    required this.category,
    required this.accountNumber,
    required this.amount,
    required this.dueDate,
    this.status = BillStatus.pending,
    this.autoPay = false,
    this.paidOn,
  });

  BillModel copyWith({
    String? id,
    String? title,
    BillCategory? category,
    String? accountNumber,
    double? amount,
    DateTime? dueDate,
    BillStatus? status,
    bool? autoPay,
    DateTime? paidOn,
  }) {
    return BillModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      accountNumber: accountNumber ?? this.accountNumber,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      autoPay: autoPay ?? this.autoPay,
      paidOn: paidOn ?? this.paidOn,
    );
  }

  bool get isPaid => status == BillStatus.paid;

  bool get isOverdue =>
      status == BillStatus.overdue ||
      (DateTime.now().isAfter(dueDate) && status != BillStatus.paid);

  String get formattedAmount => "\$${amount.toStringAsFixed(2)}";

  String get categoryName {
    switch (category) {
      case BillCategory.electricity:
        return "Electricity";
      case BillCategory.water:
        return "Water";
      case BillCategory.gas:
        return "Gas";
      case BillCategory.mobile:
        return "Mobile";
      case BillCategory.broadband:
        return "Broadband";
      case BillCategory.dth:
        return "DTH";
      case BillCategory.insurance:
        return "Insurance";
      case BillCategory.creditCard:
        return "Credit Card";
      case BillCategory.fastag:
        return "FASTag";
      case BillCategory.education:
        return "Education";
    }
  }
}
