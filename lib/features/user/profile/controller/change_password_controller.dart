import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/Auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../core/utils/logging/logger.dart';

class ChangePasswordController extends GetxController{


  final confirmPasswordTEController = TextEditingController();
  final currentPasswordTEController = TextEditingController();
  final passwordTECController = TextEditingController();

  var obscurePassword = true.obs;
  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;
  var obscureCurrentPassword = true.obs;
  void toggleCurrentPasswordVisibility() => obscureCurrentPassword.value = !obscureCurrentPassword.value;

  var obscureConfirmPassword = true.obs;
  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.value = !obscureConfirmPassword.value;


  void changePassword() async {
    if(currentPasswordTEController.text.isEmpty ||
        passwordTECController.text.isEmpty ||
        confirmPasswordTEController.text.isEmpty) {
      AppSnackBar.showError("Please fill all fields");
      return;
    }
    if(confirmPasswordTEController.text.length < 6) {
      AppSnackBar.showError("Confirm Password must be at least 6 characters");
      return;
    }
    if(currentPasswordTEController.text.length < 6) {
      AppSnackBar.showError("Current Password must be at least 6 characters");
      return;
    }
    if(passwordTECController.text.length < 6) {
      AppSnackBar.showError("New Password must be at least 6 characters");
      return;
    }
    if(passwordTECController.text != confirmPasswordTEController.text) {
      AppSnackBar.showError("New Password and Confirm Password do not match");
      return;
    }
    EasyLoading.show(status: "Loading...");

    final Map<String, dynamic> requestBody = {
      "oldPassword":currentPasswordTEController.text,
      "newPassword":passwordTECController.text
    };




    try {
      final response = await NetworkCaller()
          .postRequest(AppUrls.changePassword, body: requestBody,token: AuthService.token);
      if(response.statusCode == 409){
        EasyLoading.dismiss();
        AppSnackBar.showError("User Already exists");
        return;

      }
      final String message = response.responseData['message'];




      if (response.isSuccess) {
        //final String token = response.responseData['result']["token"];
        EasyLoading.showSuccess(message);

        // Get.offAll(()=>VerifyOTPScreen(email: emailController.text,token: token,));





      } else {
        AppSnackBar.showError(message);

      }

    } catch (e) {
      AppLoggerHelper.error('Error: $e');
    } finally {
      EasyLoading.dismiss();

    }
  }
}