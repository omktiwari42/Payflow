class TransactionModel {
  final String id;
  final int senderId;
  final int receiverId;
  final double amount;
  final String note;
  final String status;
  final DateTime dateTime;
  final bool isSent;
  final String recipientName;
  final String upiId;

  const TransactionModel({
    required this.id,
    this.senderId = 0,
    this.receiverId = 0,
    required this.amount,
    required this.note,
    required this.status,
    required this.dateTime,
    required this.isSent,
    required this.recipientName,
    required this.upiId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["id"].toString(),
      senderId: json["sender_id"] ?? 0,
      receiverId: json["receiver_id"] ?? 0,
      amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
      note: json["note"] ?? "",
      status: json["status"] ?? "SUCCESS",
      dateTime:
          DateTime.tryParse(
            json["created_at"] ??
                json["dateTime"] ??
                DateTime.now().toIso8601String(),
          ) ??
          DateTime.now(),
      isSent:
          json["isSent"] ??
          ((json["sender_id"] ?? 0) == (json["currentUserId"] ?? 0)),
      recipientName:
          json["recipientName"] ?? json["receiver_name"] ?? "PayFlow User",
      upiId: json["upiId"] ?? json["receiver_upi"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sender_id": senderId,
      "receiver_id": receiverId,
      "amount": amount,
      "note": note,
      "status": status,
      "created_at": dateTime.toIso8601String(),
      "isSent": isSent,
      "recipientName": recipientName,
      "upiId": upiId,
    };
  }

  TransactionModel copyWith({
    String? id,
    int? senderId,
    int? receiverId,
    double? amount,
    String? note,
    String? status,
    DateTime? dateTime,
    bool? isSent,
    String? recipientName,
    String? upiId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      isSent: isSent ?? this.isSent,
      recipientName: recipientName ?? this.recipientName,
      upiId: upiId ?? this.upiId,
    );
  }
}
