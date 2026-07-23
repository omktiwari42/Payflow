class WalletModel {
  final double balance;
  final double totalIncome;
  final double totalExpense;
  final String currency;

  const WalletModel({
    required this.balance,
    required this.totalIncome,
    required this.totalExpense,
    this.currency = "₹",
  });

  WalletModel copyWith({
    double? balance,
    double? totalIncome,
    double? totalExpense,
    String? currency,
  }) {
    return WalletModel(
      balance: balance ?? this.balance,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "balance": balance,
      "totalIncome": totalIncome,
      "totalExpense": totalExpense,
      "currency": currency,
    };
  }

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: (json["balance"] as num).toDouble(),
      totalIncome: (json["totalIncome"] as num).toDouble(),
      totalExpense: (json["totalExpense"] as num).toDouble(),
      currency: json["currency"] ?? "₹",
    );
  }
}
