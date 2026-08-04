class ApiConstants {
  ApiConstants._();

  // ==========================
  // Base URL
  // ==========================

  static const String baseUrl = "http://10.0.2.2:5000/api";

  // Linux / Windows Desktop
  // static const String baseUrl = "http://localhost:5000/api";

  // Physical Device
  // static const String baseUrl = "http://192.168.1.100:5000/api";

  // Production
  // static const String baseUrl = "https://your-domain.com/api";

  // ==========================
  // Authentication
  // ==========================

  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String sendOtp = "/auth/send-otp";
  static const String verifyOtp = "/auth/verify-otp";
  static const String completeProfile = "/auth/complete-profile";

  // ==========================
  // Dashboard
  // ==========================

  static const String dashboard = "/dashboard";

  // ==========================
  // Wallet
  // ==========================

  static const String wallet = "/wallet";
  static const String walletHistory = "/wallet/history";
  static const String addMoney = "/wallet/add-money";
  static const String withdrawMoney = "/wallet/withdraw";

  // ==========================
  // Transactions
  // ==========================

  static const String transactions = "/transactions";
  static const String transactionHistory = "/transactions/history";
  static const String transactionDetails = "/transactions/details";
  static const String sendMoney = "/transactions/send";
  static const String requestMoney = "/transactions/request";
  static const String filterTransactions = "/transactions/filter";

  // ==========================
  // Beneficiaries
  // ==========================

  static const String beneficiaries = "/beneficiaries";

  // ==========================
  // Contacts
  // ==========================

  static const String contacts = "/contacts";

  // ==========================
  // Bills
  // ==========================

  static const String bills = "/bills";

  // ==========================
  // QR
  // ==========================

  static const String qr = "/qr";

  // ==========================
  // Search
  // ==========================

  static const String search = "/search";

  // ==========================
  // Profile
  // ==========================

  static const String profile = "/profile";

  // ==========================
  // Settings
  // ==========================

  static const String settings = "/settings";

  // ==========================
  // Uploads
  // ==========================

  static const String uploads = "/uploads";

  // ==========================
  // Notifications
  // ==========================

  static const String notifications = "/notifications";
}
