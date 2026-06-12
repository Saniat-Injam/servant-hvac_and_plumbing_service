import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../routes/app_routes.dart';
import '../../presentation/widgets/custom_dialog_box.dart';

class ResetPasswordController extends GetxController {
  final confirmPasswordTEController = TextEditingController();
  final passwordTECController = TextEditingController();

  var obscurePassword = true.obs;
  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;

  var obscureConfirmPassword = true.obs;
  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.value = !obscureConfirmPassword.value;


  void changePassword({required String token}) async {

    if (passwordTECController.text.isEmpty) {
      AppSnackBar.showError("Please enter a password");
      return;
    }
    if(confirmPasswordTEController.text.isEmpty) {
      AppSnackBar.showError("Please enter a confirm");
      return;
    }
    if(confirmPasswordTEController.text !=passwordTECController.text) {
      AppSnackBar.showError("Password and confirm password do not match");
      return;
    }
    EasyLoading.show(status: "Loading...");

    final Map<String, dynamic> requestBody = {
      "newPassword":passwordTECController.text,
      "reason":"RESET_PASSWORD_SECRET"////SIGNUP_OTP_SECRET,LOGIN_OTP_SECRET,RESET_PASSWORD_SECRET


    };




    try {
      final response = await NetworkCaller()
          .patchRequest(AppUrls.resetPassword, body: requestBody,token: token);
      if(response.statusCode == 404){
        EasyLoading.dismiss();
        AppSnackBar.showError("Requested data not found.");
        return;

      }
      final String message = response.responseData['message'];





      if (response.isSuccess) {

        EasyLoading.showSuccess(message);
        debugPrint(token);
        Get.dialog(
          CustomDialogBox(),

        );
        Future.delayed(Duration(seconds: 3),() {

          Get.toNamed(AppRoute.loginScreen);
        },);







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