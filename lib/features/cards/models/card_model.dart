enum CardType { visa, mastercard, rupay }

class CardModel {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final CardType type;
  final String cardColor;
  final double balance;
  final bool isFrozen;
  final bool isDefault;

  const CardModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.type,
    required this.cardColor,
    required this.balance,
    this.isFrozen = false,
    this.isDefault = false,
  });

  String get maskedCardNumber {
    if (cardNumber.length < 4) return cardNumber;

    return "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
  }

  CardModel copyWith({
    String? id,
    String? cardHolderName,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    CardType? type,
    String? cardColor,
    double? balance,
    bool? isFrozen,
    bool? isDefault,
  }) {
    return CardModel(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      type: type ?? this.type,
      cardColor: cardColor ?? this.cardColor,
      balance: balance ?? this.balance,
      isFrozen: isFrozen ?? this.isFrozen,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "cardHolderName": cardHolderName,
      "cardNumber": cardNumber,
      "expiryDate": expiryDate,
      "cvv": cvv,
      "type": type.name,
      "cardColor": cardColor,
      "balance": balance,
      "isFrozen": isFrozen,
      "isDefault": isDefault,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map["id"],
      cardHolderName: map["cardHolderName"],
      cardNumber: map["cardNumber"],
      expiryDate: map["expiryDate"],
      cvv: map["cvv"],
      type: CardType.values.firstWhere(
        (e) => e.name == map["type"],
        orElse: () => CardType.visa,
      ),
      cardColor: map["cardColor"],
      balance: (map["balance"] as num).toDouble(),
      isFrozen: map["isFrozen"] ?? false,
      isDefault: map["isDefault"] ?? false,
    );
  }
}
