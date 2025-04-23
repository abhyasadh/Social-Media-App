class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  static const String sharkURL = "https://shark-app-ee7r8.ondigitalocean.app/";
  static const String oysterURL = "https://oyster-app-ddfra.ondigitalocean.app/";
  static const String api1URL = "https://api1.yaallo.com/";

  // ====================== App Routes ======================

  static const String getPosts = "fetch";
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String generateAvatars = "auth/generate-avatars";
  static const String sendOtp = "auth/send-otp";
  static const String resetPassword = "auth/reset-password";

  static const String getJobs = "jobs";
  static const String applyJob = "jobs/apply_job";

  static const String updateUser = "user/update";
  static const String getUserByHash = "user/get-by-hash/";

  static const String getNotifications = "notifi/fetch/";
}
