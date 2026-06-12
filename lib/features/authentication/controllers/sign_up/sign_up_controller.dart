import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../routes/app_routes.dart';

class SignUpController extends GetxController {

  final fullNameTEController = TextEditingController();
  final emailTEController = TextEditingController();
  final confirmPasswordTEController = TextEditingController();
  final passwordTECController = TextEditingController();
  final locationTEController = TextEditingController();

  var obscurePassword = true.obs;
  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;

  var obscureConfirmPassword = true.obs;
  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.value = !obscureConfirmPassword.value;


  var selectedLatitude = 0.0.obs;
  var selectedLongitude = 0.0.obs;



  void setLatLng(double lat, double lng) {
    selectedLatitude.value = lat;
    selectedLongitude.value = lng;
  }



  void createAccount() async {
    if(fullNameTEController.text.isEmpty ||
        emailTEController.text.isEmpty ||
        locationTEController.text.isEmpty||
        passwordTECController.text.isEmpty ||
        confirmPasswordTEController.text.isEmpty) {
      AppSnackBar.showError("Please fill all fields");
      return;
    }
    if(!GetUtils.isEmail(emailTEController.text)) {
      AppSnackBar.showError("Please enter a valid email");
      return;
    }
    if(passwordTECController.text.length < 6) {
      AppSnackBar.showError("Password must be at least 6 characters");
      return;
    }
    if(confirmPasswordTEController.text.length < 6) {
      AppSnackBar.showError("Password must be at least 6 characters");
      return;
    }
    if(confirmPasswordTEController.text != passwordTECController.text) {
      AppSnackBar.showError("Password and confirm password don't match");
      return;
    }
    EasyLoading.show(status: "Loading...");

    final Map<String, dynamic> requestBody = {
      "fullName": fullNameTEController.text,
      "email": emailTEController.text.trim(),
      "password": passwordTECController.text,
      "role": "CUSTOMER",
      "location": {
        "long": selectedLongitude.value,
        "lat": selectedLatitude.value,
        "address":locationTEController.text
      },
    };




    try {
      final response = await NetworkCaller()
          .postRequest(AppUrls.createAccount, body: requestBody);
      debugPrint("-------------------------------${response.statusCode}------------------------------------");
      final String message = response.responseData['message'];
      debugPrint("-------------------$message-----------------------------");
      AppLoggerHelper.error('Error: $message');

      if(response.statusCode == 409){
        EasyLoading.dismiss();
        AppSnackBar.showError("User Already exists");
        return;

      }




      if (response.isSuccess) {
        final String token = response.responseData['result']["token"];
        EasyLoading.showSuccess(message);
        Get.toNamed(AppRoute.forgotOTPScreen, arguments: {
          "isSignUp": true,
          'email':emailTEController.text,
          'token':token

        });







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