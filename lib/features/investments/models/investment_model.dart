enum InvestmentType { stock, mutualFund, crypto, gold, etf, fixedDeposit }

class InvestmentModel {
  final String id;
  final String name;
  final InvestmentType type;
  final int units;
  final double buyPrice;
  final double currentPrice;
  final DateTime purchaseDate;

  const InvestmentModel({
    required this.id,
    required this.name,
    required this.type,
    required this.units,
    required this.buyPrice,
    required this.currentPrice,
    required this.purchaseDate,
  });

  double get investedAmount => buyPrice * units;

  double get currentValue => currentPrice * units;

  double get profitLoss => currentValue - investedAmount;

  double get profitLossPercentage =>
      investedAmount == 0 ? 0 : (profitLoss / investedAmount) * 100;

  bool get isProfit => profitLoss >= 0;

  InvestmentModel copyWith({
    String? id,
    String? name,
    InvestmentType? type,
    int? units,
    double? buyPrice,
    double? currentPrice,
    DateTime? purchaseDate,
  }) {
    return InvestmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      units: units ?? this.units,
      buyPrice: buyPrice ?? this.buyPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      purchaseDate: purchaseDate ?? this.purchaseDate,
    );
  }

  String get typeName {
    switch (type) {
      case InvestmentType.stock:
        return "Stock";
      case InvestmentType.mutualFund:
        return "Mutual Fund";
      case InvestmentType.crypto:
        return "Crypto";
      case InvestmentType.gold:
        return "Gold";
      case InvestmentType.etf:
        return "ETF";
      case InvestmentType.fixedDeposit:
        return "Fixed Deposit";
    }
  }
}
