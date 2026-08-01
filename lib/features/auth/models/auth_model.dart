class AuthModel {
  final String token;
  final bool success;
  final bool isNewUser;
  final String message;
  final UserModel? user;

  const AuthModel({
    required this.token,
    required this.success,
    required this.isNewUser,
    required this.message,
    this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json["token"] ?? "",
      success: json["success"] ?? false,
      isNewUser: json["isNewUser"] ?? false,
      message: json["message"] ?? "",
      user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }
}

class UserModel {
  final int id;
  final String fullName;
  final String phone;
  final String? email;
  final double walletBalance;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    required this.walletBalance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      fullName: json["full_name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"],
      walletBalance: double.tryParse(json["wallet_balance"].toString()) ?? 0.0,
    );
  }
}
