class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      message: json["message"] ?? "",
      type: json["type"] ?? "GENERAL",
      isRead: json["is_read"] ?? false,
      createdAt:
          DateTime.tryParse(json["created_at"]?.toString() ?? "") ??
          DateTime.now(),
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
    };
  }

  NotificationModel copyWith({
    int? id,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
