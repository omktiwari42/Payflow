enum CardType { visa, mastercard, rupay }

class BankCardModel {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final CardType type;
  final String cardColor;
  final bool isFrozen;
  final bool isContactlessEnabled;
  final bool isInternationalEnabled;
  final double spendingLimit;

  const BankCardModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.type,
    required this.cardColor,
    this.isFrozen = false,
    this.isContactlessEnabled = true,
    this.isInternationalEnabled = false,
    this.spendingLimit = 50000,
  });

  String get maskedCardNumber {
    if (cardNumber.length < 16) return cardNumber;

    return "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
  }

  BankCardModel copyWith({
    String? id,
    String? cardHolderName,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    CardType? type,
    String? cardColor,
    bool? isFrozen,
    bool? isContactlessEnabled,
    bool? isInternationalEnabled,
    double? spendingLimit,
  }) {
    return BankCardModel(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      type: type ?? this.type,
      cardColor: cardColor ?? this.cardColor,
      isFrozen: isFrozen ?? this.isFrozen,
      isContactlessEnabled: isContactlessEnabled ?? this.isContactlessEnabled,
      isInternationalEnabled:
          isInternationalEnabled ?? this.isInternationalEnabled,
      spendingLimit: spendingLimit ?? this.spendingLimit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cardHolderName": cardHolderName,
      "cardNumber": cardNumber,
      "expiryDate": expiryDate,
      "cvv": cvv,
      "type": type.name,
      "cardColor": cardColor,
      "isFrozen": isFrozen,
      "isContactlessEnabled": isContactlessEnabled,
      "isInternationalEnabled": isInternationalEnabled,
      "spendingLimit": spendingLimit,
    };
  }

  factory BankCardModel.fromJson(Map<String, dynamic> json) {
    return BankCardModel(
      id: json["id"],
      cardHolderName: json["cardHolderName"],
      cardNumber: json["cardNumber"],
      expiryDate: json["expiryDate"],
      cvv: json["cvv"],
      type: CardType.values.firstWhere(
        (e) => e.name == json["type"],
        orElse: () => CardType.visa,
      ),
      cardColor: json["cardColor"],
      isFrozen: json["isFrozen"] ?? false,
      isContactlessEnabled: json["isContactlessEnabled"] ?? true,
      isInternationalEnabled: json["isInternationalEnabled"] ?? false,
      spendingLimit: (json["spendingLimit"] as num?)?.toDouble() ?? 50000,
    );
  }
}
