class BeneficiaryModel {
  final int id;
  final String fullName;
  final String phone;
  final String? upiId;

  const BeneficiaryModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.upiId,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      id: json["id"] ?? 0,
      fullName: json["full_name"] ?? "",
      phone: json["phone"] ?? "",
      upiId: json["upi_id"],
    );
  }
}
