import 'package:flutter/foundation.dart';

import '../models/investment_model.dart';

class InvestmentService extends ChangeNotifier {
  InvestmentService._();

  static final InvestmentService instance = InvestmentService._();

  final List<InvestmentModel> _investments = [
    InvestmentModel(
      id: "1",
      name: "Apple Inc.",
      type: InvestmentType.stock,
      units: 10,
      buyPrice: 180.00,
      currentPrice: 195.25,
      purchaseDate: DateTime(2025, 5, 12),
    ),
    InvestmentModel(
      id: "2",
      name: "Bitcoin",
      type: InvestmentType.crypto,
      units: 1,
      buyPrice: 55000.00,
      currentPrice: 62000.00,
      purchaseDate: DateTime(2025, 8, 2),
    ),
    InvestmentModel(
      id: "3",
      name: "SBI Bluechip Fund",
      type: InvestmentType.mutualFund,
      units: 120,
      buyPrice: 65.40,
      currentPrice: 72.80,
      purchaseDate: DateTime(2024, 12, 18),
    ),
    InvestmentModel(
      id: "4",
      name: "Gold ETF",
      type: InvestmentType.gold,
      units: 15,
      buyPrice: 58.50,
      currentPrice: 61.20,
      purchaseDate: DateTime(2025, 3, 5),
    ),
  ];

  List<InvestmentModel> get investments => List.unmodifiable(_investments);

  void addInvestment(InvestmentModel investment) {
    _investments.add(investment);
    notifyListeners();
  }

  void updateInvestment(InvestmentModel investment) {
    final index = _investments.indexWhere((item) => item.id == investment.id);

    if (index == -1) return;

    _investments[index] = investment;
    notifyListeners();
  }

  void removeInvestment(String id) {
    _investments.removeWhere((investment) => investment.id == id);

    notifyListeners();
  }

  InvestmentModel? getInvestment(String id) {
    try {
      return _investments.firstWhere((investment) => investment.id == id);
    } catch (_) {
      return null;
    }
  }

  double get totalInvested => _investments.fold(
    0.0,
    (sum, investment) => sum + investment.investedAmount,
  );

  double get totalCurrentValue => _investments.fold(
    0.0,
    (sum, investment) => sum + investment.currentValue,
  );

  double get totalProfitLoss => totalCurrentValue - totalInvested;

  double get totalProfitLossPercentage {
    if (totalInvested == 0) return 0;

    return (totalProfitLoss / totalInvested) * 100;
  }

  int get totalInvestments => _investments.length;

  bool get isProfit => totalProfitLoss >= 0;

  void clearPortfolio() {
    _investments.clear();
    notifyListeners();
  }
}
