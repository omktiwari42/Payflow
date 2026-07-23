class TransactionModel {
  final String id;
  final String recipientName;
  final String upiId;
  final double amount;
  final String note;
  final String status;
  final DateTime dateTime;
  final bool isSent;

  const TransactionModel({
    required this.id,
    required this.recipientName,
    required this.upiId,
    required this.amount,
    required this.note,
    required this.status,
    required this.dateTime,
    required this.isSent,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      recipientName: json['recipientName'],
      upiId: json['upiId'],
      amount: (json['amount'] as num).toDouble(),
      note: json['note'],
      status: json['status'],
      dateTime: DateTime.parse(json['dateTime']),
      isSent: json['isSent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipientName': recipientName,
      'upiId': upiId,
      'amount': amount,
      'note': note,
      'status': status,
      'dateTime': dateTime.toIso8601String(),
      'isSent': isSent,
    };
  }

  TransactionModel copyWith({
    String? id,
    String? recipientName,
    String? upiId,
    double? amount,
    String? note,
    String? status,
    DateTime? dateTime,
    bool? isSent,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      recipientName: recipientName ?? this.recipientName,
      upiId: upiId ?? this.upiId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      isSent: isSent ?? this.isSent,
    );
  }
}
