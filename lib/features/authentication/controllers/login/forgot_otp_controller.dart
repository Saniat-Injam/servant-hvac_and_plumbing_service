import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../routes/app_routes.dart';
import '../../presentation/widgets/custom_dialog_box.dart';

class ForgotOtpController extends GetxController{


  final otpTEController = TextEditingController();

  void resendOtp({required String email,required String reason}) async {
    EasyLoading.show(status: "Loading...");

    final Map<String, dynamic> requestBody = {

      "email":email,
      "reason":reason

    };




    try {
      final response = await NetworkCaller()
          .postRequest(AppUrls.resendEmail, body: requestBody);
      if(response.statusCode == 500){
        EasyLoading.dismiss();
        AppSnackBar.showError("invalid signature");
        return;

      }
      final String message = response.responseData['message'];




      if (response.isSuccess) {
        //final String token = response.responseData['result']["token"];
        EasyLoading.showSuccess(message);







      } else {
        AppSnackBar.showError(message);

      }

    } catch (e) {
      AppLoggerHelper.error('Error: $e');
    } finally {
      EasyLoading.dismiss();

    }
  }

  Future<void> verifyOtp({ required String email,required String token,required String reason,required isSignUp}) async {

    EasyLoading.show(status: "Loading...");
    final code = otpTEController.text.toString();

    final Map<String, dynamic> requestBody = {

      "email": email,
      "reason":reason,
      "otp": code

    };

    try {
      debugPrint("------------------------$token----------------------------");


      final response =
      await NetworkCaller().postRequest(AppUrls.verifyOtp , body: requestBody,token: token);

      if(response.statusCode == 404){
        EasyLoading.dismiss();
        AppSnackBar.showError("Wrong OTP");
        return;

      }
      final String message = response.responseData["message"];

      //final token1 = result["token"];

      if (response.isSuccess) {
        final String token = response.responseData["result"]["token"];
        debugPrint("Response: $token");

        if(isSignUp == true){
          Get.dialog(
            CustomDialogBox(),

          );
          Future.delayed(Duration(seconds: 3),() {

            Get.toNamed(AppRoute.loginScreen);
          },);

        }else{
          Get.toNamed(AppRoute.resetPasswordScreen,arguments: {
            "token": token,
          });

        }


       // Get.to(()=>ResetPasswordScreen(token: token,));

        EasyLoading.showSuccess(message);
      } else {
        AppSnackBar.showError( message);
      }
    } catch (e) {
      AppLoggerHelper.error('Error: $e');
    } finally {
      EasyLoading.dismiss();

    }
  }




}