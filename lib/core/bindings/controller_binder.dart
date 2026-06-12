

import 'package:get/get.dart';

import '../../features/authentication/controllers/login/forgot_email_controller.dart';
import '../../features/authentication/controllers/login/forgot_otp_controller.dart';
import '../../features/authentication/controllers/login/login_controller.dart';
import '../../features/authentication/controllers/login/reset_password_controller.dart';
import '../../features/authentication/controllers/sign_up/chose_role_controller.dart';
import '../../features/authentication/controllers/sign_up/provider_sign_up_controller.dart';
import '../../features/authentication/controllers/sign_up/sign_up_controller.dart';
import '../../features/notification/controller/notification_controller.dart';
import '../../features/provider/home/controller/single_job_details_controller.dart';
import '../../features/provider/provider_nav_bar/controllers/nav_bar_controller.dart';
import '../../features/provider/service/controller/provider_service_controller.dart';
import '../../features/splash_screen/controllers/splash_controller.dart';
import '../../features/user/home/controller/home_controller.dart';
import '../../features/user/home/controller/request_service_controller.dart';
import '../../features/user/nav_bar/controllers/nav_bar_controller.dart';
import '../../features/user/profile/controller/change_password_controller.dart';
import '../../features/user/profile/controller/edit_profile_controller.dart';
import '../../features/user/profile/controller/user_profile_controller.dart';
import '../../features/user/service/controller/rating_controller.dart';
import '../../features/user/service/controller/service_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true,);
    Get.lazyPut<LogInController>(() => LogInController(), fenix: true,);
    Get.lazyPut<ForgotEmailController>(() => ForgotEmailController(), fenix: true,);
    Get.lazyPut<ForgotOtpController >(() => ForgotOtpController (), fenix: true,);
    Get.lazyPut<ResetPasswordController >(() => ResetPasswordController(), fenix: true,);
    Get.lazyPut<ChoseRoleController  >(() => ChoseRoleController (), fenix: true,);
    Get.lazyPut<SignUpController  >(() => SignUpController (), fenix: true,);
    Get.lazyPut<ProviderSignUpController >(() => ProviderSignUpController (), fenix: true,);
    Get.lazyPut<UserNavBarController >(() => UserNavBarController(), fenix: true,);
    Get.lazyPut<UserHomeController >(() => UserHomeController(), fenix: true,);
    Get.lazyPut<RequestServiceScreenController>(() => RequestServiceScreenController(Get.arguments), fenix: true,);
    Get.lazyPut<UserProfileController >(() => UserProfileController (), fenix: true,);
    Get.lazyPut<UserEditProfileController  >(() => UserEditProfileController  (), fenix: true,);
    Get.lazyPut<RatingController  >(() => RatingController (), fenix: true,);
    Get.lazyPut<ProviderNavBarController >(() => ProviderNavBarController (), fenix: true,);
    Get.lazyPut<ChangePasswordController  >(() => ChangePasswordController  (), fenix: true,);
    Get.lazyPut<NotificationController >(() => NotificationController  (), fenix: true,);
    Get.lazyPut<SingleJobDetailsController  >(() => SingleJobDetailsController  (), fenix: true,);
    Get.lazyPut<ProviderServicesController  >(() => ProviderServicesController (), fenix: true,);
    Get.lazyPut<ServicesController  >(() => ServicesController (), fenix: true,);


  }
}