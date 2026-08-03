class DashboardModel {
  final String fullName;
  final double walletBalance;
  final double totalSent;
  final double totalReceived;
  final int totalTransactions;
  final List<dynamic> recentTransactions;

  const DashboardModel({
    required this.fullName,
    required this.walletBalance,
    required this.totalSent,
    required this.totalReceived,
    required this.totalTransactions,
    required this.recentTransactions,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final summary = Map<String, dynamic>.from(json["summary"] ?? {});

    final user = Map<String, dynamic>.from(json["user"] ?? {});

    return DashboardModel(
      fullName: user["full_name"] ?? "User",
      walletBalance: (summary["walletBalance"] as num?)?.toDouble() ?? 0.0,
      totalSent: (summary["totalSent"] as num?)?.toDouble() ?? 0.0,
      totalReceived: (summary["totalReceived"] as num?)?.toDouble() ?? 0.0,
      totalTransactions: (summary["totalTransactions"] as num?)?.toInt() ?? 0,
      recentTransactions: List<dynamic>.from(
        summary["recentTransactions"] ?? [],
      ),
    );
  }
}
