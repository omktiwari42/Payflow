class BankAccountModel {
  final int id;
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
    if (accountNumber.length <= 4) {
      return accountNumber;
    }

    return "•••• ${accountNumber.substring(accountNumber.length - 4)}";
  }

  BankAccountModel copyWith({
    int? id,
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
      "bank_name": bankName,
      "account_holder": accountHolderName,
      "account_number": accountNumber,
      "ifsc": ifscCode,
      "is_primary": isPrimary,
    };
  }

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json["id"] ?? 0,
      bankName: json["bank_name"] ?? "",
      accountHolderName: json["account_holder"] ?? "",
      accountNumber: json["account_number"] ?? "",
      ifscCode: json["ifsc"] ?? "",
      isPrimary: json["is_primary"] ?? false,
    );
  }
}
