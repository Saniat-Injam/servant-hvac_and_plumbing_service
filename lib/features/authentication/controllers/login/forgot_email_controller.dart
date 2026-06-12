import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../routes/app_routes.dart';

class ForgotEmailController extends GetxController{

  final emailTEController = TextEditingController();

  void forgotEmail() async {

    if (emailTEController.text.isEmpty) {
      AppSnackBar.showError("Please enter a an email");
      return;
    }
    if(!GetUtils.isEmail(emailTEController.text)) {
      AppSnackBar.showError("Please enter a valid email");
      return;
    }
    EasyLoading.show(status: "Loading...");

    final Map<String, dynamic> requestBody = {
      "email": emailTEController.text
    };




    try {
      final response = await NetworkCaller()
          .postRequest(AppUrls.forgetPasswordEmail, body: requestBody);
      if(response.statusCode == 404){
        EasyLoading.dismiss();
        AppSnackBar.showError("Requested data not found.");
        return;
      }

      final String message = response.responseData['message'];






      if (response.isSuccess) {
        final String token = response.responseData['result']["token"];
        EasyLoading.showSuccess(message);
        debugPrint(token);
        Get.toNamed(AppRoute.forgotOTPScreen,arguments: {
          "isSignUp":false,
          "email":emailTEController.text,
          "token":token,
        });

       // Get.to(()=>OtpVerificationScreen (email: emailController.text,token: token,));





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