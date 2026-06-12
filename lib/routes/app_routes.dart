import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/features/notification/presentation/screen/notification_screen.dart';

import '../features/authentication/presentation/screens/login/forgot_email_screen.dart';
import '../features/authentication/presentation/screens/login/forgot_otp_screen.dart';
import '../features/authentication/presentation/screens/login/login_screen.dart';

import '../features/authentication/presentation/screens/login/reset_password_screen.dart';
import '../features/authentication/presentation/screens/sign_up/chose_role_screen.dart';
import '../features/authentication/presentation/screens/sign_up/provider_sign_up_screen.dart';
import '../features/authentication/presentation/screens/sign_up/sign_up_screen.dart';

import '../features/on_boarding/presentation/screen/on_boarding_screen.dart';
import '../features/provider/home/presentation/screens/view_details_screen.dart';
import '../features/provider/provider_nav_bar/presentation/screens/provider_nav_bar.dart';
import '../features/splash_screen/presentation/screens/splash_screen.dart';
import '../features/user/home/presentation/screens/request_service_screen.dart';
import '../features/user/nav_bar/presentation/screens/nav_bar.dart';
import '../features/user/profile/presentation/screen/change_password_scren.dart';
import '../features/user/profile/presentation/screen/edit_profile_screen.dart';
import '../features/user/profile/presentation/screen/privacy_policy_screen.dart';
import '../features/user/profile/presentation/screen/user_profile_screen.dart';
import '../features/user/service/presentation/screen/payment_screen.dart';
import '../features/user/service/presentation/screen/rating_screen.dart';

class AppRoute {
  static String init = "/";
  static String onBoardingScreen = "/onBoardingScreen";
  static String loginScreen = "/loginScreen";
  static String forgotEmailScreen = "/forgotEmailScreen";
  static String forgotOTPScreen = "/forgotOTPScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String choseRoleScreen = "/choseRoleScreen";
  static String signUpScreen = "/signUpScreen";
  static String providerSignUpScreen = "/providerSignUpScreen";
  static String userNavBarScreen = "/userNavBarScreen";
  static String requestServiceScreen = "/requestServiceScreen";
  static String userProfileScreen = "/userProfileScreen";
  static String userEditScreen = "/userEditScreen";
  static String privacyPolicyScreen = "/privacyPolicyScreen";
  static String ratingScreen = "/ratingScreen";
  static String paymentScreen = "/paymentScreen";
  static String providerNavBarScreen = "/providerNavBarScreen";
  static String viewDetailsScreen = "/viewDetailsScreen";
  static String changePasswordScreen = "/changePasswordScreen";
  static String notificationScreen = "/notificationScreen";



  static List<GetPage> routes = [
    GetPage(name: init, page: () => SplashScreen()),
    GetPage(name: onBoardingScreen, page: () => OnBoardingScreen(),transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300), curve: Curves.easeOut,),
    GetPage(name: loginScreen, page: () => const LogInScreen ()),
    GetPage(name: forgotEmailScreen, page:() => const ForgotEmailScreen()),
    GetPage(name: forgotOTPScreen, page:() => const ForgotOtpScreen ()),
    GetPage(name: resetPasswordScreen, page:() => const ResetPasswordScreen ()),
    GetPage(name: choseRoleScreen, page:() => const ChooseRoleScreen ()),
    GetPage(name: signUpScreen, page:() => const SignUpScreen ()),
    GetPage(name: providerSignUpScreen, page:() => const ProviderSignUpScreen ()),
    GetPage(name: userNavBarScreen, page:() => const UserNavBar ()),
    GetPage(name: requestServiceScreen, page:() => RequestServiceScreen ()),
    GetPage(name: userProfileScreen, page:() => const UserProfileScreen ()),
    GetPage(name: userEditScreen, page:() => const UserEditProfileScreen  ()),
    GetPage(name: privacyPolicyScreen, page:() => const PrivacyPolicyScreen  ()),
    GetPage(name: ratingScreen, page:() => const RatingScreen  ()),
    GetPage(name: paymentScreen, page:() => const PaymentScreen   ()),
    GetPage(name: providerNavBarScreen, page:() => const ProviderNavBar()),
    GetPage(name: viewDetailsScreen, page:() => const ViewDetailScreen()),
    GetPage(name: changePasswordScreen, page:() => const ChangePasswordScreen()),
    GetPage(name: notificationScreen, page:() =>  NotificationScreen()),
  ];
}