class RequestMoneyModel {
  final int id;
  final int senderId;
  final int receiverId;

  final String senderName;
  final String senderPhone;

  final String receiverName;
  final String receiverPhone;

  final double amount;
  final String note;

  final String status;

  final String createdAt;

  const RequestMoneyModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.amount,
    required this.note,
    required this.status,
    required this.createdAt,
  });

  factory RequestMoneyModel.fromJson(Map<String, dynamic> json) {
    return RequestMoneyModel(
      id: json["id"] ?? 0,
      senderId: json["sender_id"] ?? 0,
      receiverId: json["receiver_id"] ?? 0,
      senderName: json["sender_name"] ?? "",
      senderPhone: json["sender_phone"] ?? "",
      receiverName: json["receiver_name"] ?? "",
      receiverPhone: json["receiver_phone"] ?? "",
      amount: (json["amount"] as num?)?.toDouble() ?? 0,
      note: json["note"] ?? "",
      status: json["status"] ?? "PENDING",
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sender_id": senderId,
      "receiver_id": receiverId,
      "sender_name": senderName,
      "sender_phone": senderPhone,
      "receiver_name": receiverName,
      "receiver_phone": receiverPhone,
      "amount": amount,
      "note": note,
      "status": status,
      "created_at": createdAt,
    };
  }

  RequestMoneyModel copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    double? amount,
    String? note,
    String? status,
    String? createdAt,
  }) {
    return RequestMoneyModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
