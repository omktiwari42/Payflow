class UpiParser {
  UpiParser._();

  // ============================================================
  // MAIN PARSER
  // ============================================================

  static Map<String, dynamic> parse(String rawValue) {
    final raw = rawValue.trim();

    if (raw.isEmpty) {
      return {"isUpi": false, "raw": raw};
    }

    final uri = Uri.tryParse(raw);

    // ==========================================================
    // STANDARD UPI QR
    // upi://pay?pa=...&pn=...&am=...&tn=...
    // ==========================================================

    if (uri != null && uri.scheme.toLowerCase() == "upi") {
      final query = uri.queryParameters;

      final pa = _clean(query["pa"]);

      final pn = _clean(query["pn"]);

      final amount = _parseAmount(query["am"]);

      final note = _clean(query["tn"]);

      final phone = _extractPhone([pa, pn, query["mc"]]);

      return {
        "isUpi": true,
        "raw": raw,
        "upiId": pa,
        "name": pn.isNotEmpty ? pn : "UPI User",
        "phone": phone,
        "amount": amount,
        "note": note,
      };
    }

    // ==========================================================
    // RAW PHONE / TEL QR
    // ==========================================================

    final phone = _extractPhone([raw]);

    if (phone.isNotEmpty) {
      return {
        "isUpi": true,
        "raw": raw,
        "upiId": "",
        "name": "PayFlow User",
        "phone": phone,
        "amount": null,
        "note": "",
      };
    }

    return {"isUpi": false, "raw": raw};
  }

  // ============================================================
  // AMOUNT
  // ============================================================

  static double? _parseAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final amount = double.tryParse(value.trim());

    if (amount == null || !amount.isFinite || amount <= 0) {
      return null;
    }

    return amount;
  }

  // ============================================================
  // PHONE EXTRACTION
  // ============================================================

  static String _extractPhone(List<String?> values) {
    for (final value in values) {
      if (value == null || value.trim().isEmpty) {
        continue;
      }

      final phone = _normalizePhone(value);

      if (phone.isNotEmpty) {
        return phone;
      }
    }

    return "";
  }

  // ============================================================
  // PHONE NORMALIZATION
  // ============================================================

  static String _normalizePhone(String value) {
    String input = value.trim();

    // tel:+919387955099
    if (input.toLowerCase().startsWith("tel:")) {
      input = input.substring(4);
    }

    // Remove everything except digits.
    final digits = input.replaceAll(RegExp(r"\D"), "");

    // India +91XXXXXXXXXX
    if (digits.length == 12 && digits.startsWith("91")) {
      final phone = digits.substring(2);

      if (_isValidIndianPhone(phone)) {
        return phone;
      }
    }

    // 10 digit Indian number
    if (digits.length == 10 && _isValidIndianPhone(digits)) {
      return digits;
    }

    // 0XXXXXXXXXX
    if (digits.length == 11 && digits.startsWith("0")) {
      final phone = digits.substring(1);

      if (_isValidIndianPhone(phone)) {
        return phone;
      }
    }

    return "";
  }

  // ============================================================
  // VALIDATE INDIAN PHONE
  // ============================================================

  static bool _isValidIndianPhone(String phone) {
    if (phone.length != 10) {
      return false;
    }

    final firstDigit = phone.substring(0, 1);

    return RegExp(r"[6-9]").hasMatch(firstDigit);
  }

  // ============================================================
  // STRING CLEANER
  // ============================================================

  static String _clean(String? value) {
    return value?.trim() ?? "";
  }
}
