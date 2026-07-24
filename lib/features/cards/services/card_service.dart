import 'package:flutter/foundation.dart';

import '../models/card_model.dart';

class CardService extends ChangeNotifier {
  CardService._();

  static final CardService instance = CardService._();

  final List<CardModel> _cards = [
    const CardModel(
      id: "1",
      cardHolderName: "Om Kumar Tiwari",
      cardNumber: "4532123412345678",
      expiryDate: "12/29",
      cvv: "123",
      type: CardType.visa,
      cardColor: "blue",
      balance: 125430.50,
      isDefault: true,
    ),
    const CardModel(
      id: "2",
      cardHolderName: "Om Kumar Tiwari",
      cardNumber: "5423123412345678",
      expiryDate: "08/28",
      cvv: "456",
      type: CardType.mastercard,
      cardColor: "black",
      balance: 82450.25,
    ),
  ];

  List<CardModel> get cards => List.unmodifiable(_cards);

  CardModel? get defaultCard {
    try {
      return _cards.firstWhere((card) => card.isDefault);
    } catch (_) {
      return _cards.isNotEmpty ? _cards.first : null;
    }
  }

  CardModel? getCard(String id) {
    try {
      return _cards.firstWhere((card) => card.id == id);
    } catch (_) {
      return null;
    }
  }

  void addCard(CardModel card) {
    _cards.add(card);
    notifyListeners();
  }

  void removeCard(String id) {
    _cards.removeWhere((card) => card.id == id);
    notifyListeners();
  }

  void setDefaultCard(String id) {
    for (int i = 0; i < _cards.length; i++) {
      _cards[i] = _cards[i].copyWith(isDefault: _cards[i].id == id);
    }

    notifyListeners();
  }

  void toggleFreeze(String id) {
    final index = _cards.indexWhere((card) => card.id == id);

    if (index == -1) return;

    final card = _cards[index];

    _cards[index] = card.copyWith(isFrozen: !card.isFrozen);

    notifyListeners();
  }

  void updateBalance(String id, double balance) {
    final index = _cards.indexWhere((card) => card.id == id);

    if (index == -1) return;

    _cards[index] = _cards[index].copyWith(balance: balance);

    notifyListeners();
  }

  void clearCards() {
    _cards.clear();
    notifyListeners();
  }

  bool get hasCards => _cards.isNotEmpty;

  int get totalCards => _cards.length;
}
