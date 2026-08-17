class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  final int? transactionId;
  final String? billId;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.transactionId,
    this.billId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: int.tryParse(json["id"]?.toString() ?? "") ?? 0,
      title: json["title"]?.toString() ?? "",
      message: json["message"]?.toString() ?? "",
      type: json["type"]?.toString() ?? "GENERAL",
      isRead: json["is_read"] == true || json["isRead"] == true,
      createdAt: _parseDateTime(json["created_at"] ?? json["createdAt"]),
      transactionId: _parseNullableInt(
        json["transaction_id"] ?? json["transactionId"],
      ),
      billId: _parseNullableString(json["bill_id"] ?? json["billId"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "message": message,
      "type": type,
      "is_read": isRead,
      "created_at": createdAt.toIso8601String(),
      "transaction_id": transactionId,
      "bill_id": billId,
    };
  }

  NotificationModel copyWith({
    int? id,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    DateTime? createdAt,
    int? transactionId,
    String? billId,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      transactionId: transactionId ?? this.transactionId,
      billId: billId ?? this.billId,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.tryParse(value.toString()) ?? DateTime.now();
  }

  static int? _parseNullableInt(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return value;
    }

    return int.tryParse(value.toString());
  }

  static String? _parseNullableString(dynamic value) {
    if (value == null) {
      return null;
    }

    final result = value.toString().trim();

    return result.isEmpty ? null : result;
  }
}
