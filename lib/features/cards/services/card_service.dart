import '../models/bank_card_model.dart';

class CardService {
  CardService._();

  static final CardService instance = CardService._();

  final List<BankCardModel> _cards = [];

  List<BankCardModel> getCards() {
    return List<BankCardModel>.from(_cards);
  }

  void addCard(BankCardModel card) {
    _cards.add(card);
  }

  void removeCard(String id) {
    _cards.removeWhere((card) => card.id == id);
  }

  BankCardModel? getCard(String id) {
    try {
      return _cards.firstWhere((card) => card.id == id);
    } catch (_) {
      return null;
    }
  }

  void freezeCard(String id, bool freeze) {
    final index = _cards.indexWhere((card) => card.id == id);

    if (index == -1) return;

    _cards[index] = _cards[index].copyWith(isFrozen: freeze);
  }

  void setContactless(String id, bool enabled) {
    final index = _cards.indexWhere((card) => card.id == id);

    if (index == -1) return;

    _cards[index] = _cards[index].copyWith(isContactlessEnabled: enabled);
  }

  void setInternational(String id, bool enabled) {
    final index = _cards.indexWhere((card) => card.id == id);

    if (index == -1) return;

    _cards[index] = _cards[index].copyWith(isInternationalEnabled: enabled);
  }

  void updateLimit(String id, double limit) {
    final index = _cards.indexWhere((card) => card.id == id);

    if (index == -1) return;

    _cards[index] = _cards[index].copyWith(spendingLimit: limit);
  }

  void loadDummyCards() {
    if (_cards.isNotEmpty) return;

    _cards.addAll([
      const BankCardModel(
        id: "1",
        cardHolderName: "Om Kumar Tiwari",
        cardNumber: "4111111111111111",
        expiryDate: "12/29",
        cvv: "123",
        type: CardType.visa,
        cardColor: "blue",
      ),
      const BankCardModel(
        id: "2",
        cardHolderName: "Om Kumar Tiwari",
        cardNumber: "5555555555554444",
        expiryDate: "09/28",
        cvv: "456",
        type: CardType.mastercard,
        cardColor: "black",
        isInternationalEnabled: true,
      ),
      const BankCardModel(
        id: "3",
        cardHolderName: "Om Kumar Tiwari",
        cardNumber: "6522334455667788",
        expiryDate: "06/30",
        cvv: "789",
        type: CardType.rupay,
        cardColor: "purple",
      ),
    ]);
  }

  void clearCards() {
    _cards.clear();
  }
}
