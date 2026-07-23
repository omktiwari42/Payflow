class UpiParser {
  static Map<String, dynamic> parse(String qrData) {
    if (!qrData.startsWith("upi://pay")) {
      return {"isUpi": false};
    }

    final uri = Uri.parse(qrData);

    return {
      "isUpi": true,
      "upiId": uri.queryParameters["pa"] ?? "",
      "name": uri.queryParameters["pn"] ?? "Unknown",
      "amount": double.tryParse(uri.queryParameters["am"] ?? "0") ?? 0.0,
      "note": uri.queryParameters["tn"] ?? "",
    };
  }
}
