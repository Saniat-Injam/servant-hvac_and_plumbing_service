
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/Auth_service.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../routes/app_routes.dart';





class LogInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var rememberMe = false.obs;
  var obscurePassword = true.obs;

  void toggleRememberMe() => rememberMe.value = !rememberMe.value;
  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;
  @override
  void onInit() {
    super.onInit();
    _loadRememberedCredentials(); // ✅ Load on init
    //_getFcmToken();
  }

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken;


  // Future<void> _getFcmToken() async {
  //   try {
  //     fcmToken = await _firebaseMessaging.getToken();
  //     debugPrint(fcmToken);
  //     AppLoggerHelper.info("FCM Token: $fcmToken");
  //   } catch (e) {
  //     AppLoggerHelper.error("Failed to get FCM token: $e");
  //   }
  // }

  Future<void> _loadRememberedCredentials() async {
    final savedEmail = await AuthService.rememberedEmail; // ✅ await
    final savedPassword = await AuthService.rememberedPassword; // ✅ await

    if (savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe.value = true;
    }
  }



  Future<void> login() async {
    if(emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      AppSnackBar.showError("Please fill all fields");
      return;
    }
    if(!GetUtils.isEmail(emailController.text)) {
      AppSnackBar.showError("Please enter a valid email");
      return;
    }
    if(passwordController.text.length < 6) {
      AppSnackBar.showError("Password must be at least 6 characters");
      return;
    }

    EasyLoading.show(status: "Loading...");
    final Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      validateStatus: (status) => status != null && status < 500,
    ));

    final Map<String, dynamic> requestBody = {
      "email": emailController.text,
      "password": passwordController.text,
      "fcmToken": fcmToken
    };
    debugPrint(requestBody.toString());

    try {
      //await showProgressIndicator();
      log("Sending login request: $requestBody");

      final response = await dio.post(AppUrls.login, data: requestBody);

      log("Login response: ${response.statusCode}");
      log(response.toString());

      //await hideProgressIndicator();

      if (response.statusCode == 401) {
        EasyLoading.dismiss();
        AppSnackBar.showError("Invalid credentials");
        return;
      }
      if (response.statusCode == 404) {
        EasyLoading.dismiss();
        AppSnackBar.showError("User not found");
        return;
      }
      final String message = response.data["message"];

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = response.data["result"];
        final token = result["accessToken"];
        final userInfo = result["userInfo"];
        final userId = userInfo["id"];
        final userRole = userInfo["role"];
        //final isProfile = userInfo["isProfile"];


        // Optional: log full name or email if needed
        final name = userInfo["fullName"];
        final email = userInfo["email"];
        log("User: $name, Email: $email");


          await AuthService.saveToken(token, userId,userRole); // ✅ Updated method

          // ✅ Save credentials if "remember me" is checked
          if (rememberMe.value) {
            await AuthService.saveCredentials(emailController.text, passwordController.text);
          } else {
            await AuthService.clearCredentials();
          }

          log("Saved Token: ${AuthService.token}");
          log("Saved UserId: ${AuthService.userId}");
          EasyLoading.showSuccess(message);
          if(userRole == "PROVIDER"){
            Get.toNamed(AppRoute.providerNavBarScreen);

          }else{
            Get.toNamed(AppRoute.userNavBarScreen);

          }









      } else {
        EasyLoading.dismiss();
        //  AppSnackBar.showError("Login failed. Try again.");
      }
    } on DioException catch (e) {
      log("DioException: $e");
      EasyLoading.dismiss();
      //await hideProgressIndicator();
      AppSnackBar.showError("Please check your internet connection and try again");
    } catch (e) {
      log("Unexpected Error: $e");
      EasyLoading.dismiss();
      //await hideProgressIndicator();
      AppSnackBar.showError("An unexpected error occurred.");
    }
  }


  void signInWithGoogle() {
    // Add Google sign-in logic
    if (kDebugMode) {
      print("Signing in with Google");
    }
  }
}
