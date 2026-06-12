class AppUrls {
  AppUrls._();

  //static const String _baseUrl = 'http://10.0.20.13:8003/api/v1';
  static const String _baseUrl = 'http://145.223.120.135:8003/api/v1';

  // Authentication
  static const String createAccount = '$_baseUrl/user/create';
  static const String resendEmail = '$_baseUrl/auth/resend-otp';
  static const String verifyOtp = '$_baseUrl/auth/verfiy-otp';
  static const String forgetPasswordEmail = '$_baseUrl/auth/forgetpassword-otp-to-gmail';
  static const String resetPassword = '$_baseUrl/auth/reset-password';

  //User
  static const String login = '$_baseUrl/auth/login';
  static const String getMe = '$_baseUrl/user/get-profile';
  static const String changePassword = '$_baseUrl/auth/change-password';
  static const String updateProfile = '$_baseUrl/user/update-profile';


  //Create Service
  static const String createService = '$_baseUrl/service/service-request';
  static const String technicalPendingJob = '$_baseUrl/service/technicion-pending-job';
  static getSingleJobDetails({required String jobId}) => '$_baseUrl/service/get-technicion-single-job/$jobId';
  static getStatusWiseProviderService({required String status}) => '$_baseUrl/service/technicion-service?status=$status';
  static getStatusWiseUserService({required String status}) => '$_baseUrl/service/get-customer-service?status=$status';
  static const String updateJobStatus = '$_baseUrl/service/update-job-status';

  // Get Notification
  static const String getNotification = '$_baseUrl/notification';
  static const String createRating = '$_baseUrl/rating/create-rating';

  // Payment
  static const String confirmPayment = '$_baseUrl/payment/create-payment';
  static const String earningOverView = '$_baseUrl/payment/earning-overview';


}
