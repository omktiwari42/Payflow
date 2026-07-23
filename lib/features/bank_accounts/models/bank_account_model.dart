class BankAccountModel {
  final String id;
  final String bankName;
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final bool isPrimary;

  const BankAccountModel({
    required this.id,
    required this.bankName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    this.isPrimary = false,
  });

  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;

    return "•••• ${accountNumber.substring(accountNumber.length - 4)}";
  }

  BankAccountModel copyWith({
    String? id,
    String? bankName,
    String? accountHolderName,
    String? accountNumber,
    String? ifscCode,
    bool? isPrimary,
  }) {
    return BankAccountModel(
      id: id ?? this.id,
      bankName: bankName ?? this.bankName,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "bankName": bankName,
      "accountHolderName": accountHolderName,
      "accountNumber": accountNumber,
      "ifscCode": ifscCode,
      "isPrimary": isPrimary,
    };
  }

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json["id"],
      bankName: json["bankName"],
      accountHolderName: json["accountHolderName"],
      accountNumber: json["accountNumber"],
      ifscCode: json["ifscCode"],
      isPrimary: json["isPrimary"] ?? false,
    );
  }
}
