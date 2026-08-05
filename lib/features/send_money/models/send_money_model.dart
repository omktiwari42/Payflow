class SendMoneyModel {
  final int id;
  final String receiverName;
  final String receiverPhone;
  final double amount;
  final String note;
  final String status;
  final DateTime createdAt;

  const SendMoneyModel({
    required this.id,
    required this.receiverName,
    required this.receiverPhone,
    required this.amount,
    required this.note,
    required this.status,
    required this.createdAt,
  });

  factory SendMoneyModel.fromJson(Map<String, dynamic> json) {
    return SendMoneyModel(
      id: json["id"] ?? 0,
      receiverName: json["receiver_name"]?.toString() ?? "",
      receiverPhone: json["receiver_phone"]?.toString() ?? "",
      amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
      note: json["note"]?.toString() ?? "",
      status: json["status"]?.toString() ?? "SUCCESS",
      createdAt:
          DateTime.tryParse(json["created_at"]?.toString() ?? "") ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson({
    required String phone,
    required double amount,
    String note = "",
  }) {
    return {"phone": phone, "amount": amount, "note": note};
  }
}
