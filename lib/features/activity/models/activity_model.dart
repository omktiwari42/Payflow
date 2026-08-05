class ActivityModel {
  final int id;
  final String title;
  final String type;
  final double amount;
  final String status;
  final DateTime createdAt;

  const ActivityModel({
    required this.id,
    required this.title,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json["id"] ?? 0,
      title: json["title"]?.toString() ?? "",
      type: json["type"]?.toString() ?? "",
      amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
      status: json["status"]?.toString() ?? "",
      createdAt:
          DateTime.tryParse(json["created_at"]?.toString() ?? "") ??
          DateTime.now(),
    );
  }
}
