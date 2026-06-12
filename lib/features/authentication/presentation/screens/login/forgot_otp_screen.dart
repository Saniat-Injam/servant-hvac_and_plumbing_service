import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/app_snack_bar.dart';
import 'package:servant_hvac_and_plumbing_service/features/authentication/presentation/widgets/custom_footer_section_widget.dart';

import '../../../../../core/common/widgets/custom_app_bar_widget.dart';
import '../../../../../core/common/widgets/custom_elevated_button_widget.dart';
import '../../../../../core/common/widgets/custom_text.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';


import '../../../controllers/login/forgot_otp_controller.dart';

import '../../widgets/custom_otp_text_form_widget.dart';


class ForgotOtpScreen extends StatefulWidget {
   const ForgotOtpScreen({super.key});


  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {
  final RxInt remainingTime = 30.obs;
  late Timer timer;
  final RxBool enableResendCodeButton = false.obs;

  void startResendCodeTimer() {
    enableResendCodeButton.value = false;
    remainingTime.value = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      remainingTime.value--;
      if (remainingTime.value == 0) {
        t.cancel();
        enableResendCodeButton.value = true;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    startResendCodeTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments ?? {};
    final bool? isSignUp= arguments['isSignUp'];
    final String? email = arguments['email'];
    final String? token = arguments['token'];
    final controller = Get.find<ForgotOtpController>();
    debugPrint("----------------------------------------------------------$email----------------------------------------------");
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: getWidth(16), right: getWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBarWidget(onTap: (){
              Get.back();
            },),

            CustomText(text: "Enter OTP",fontSize: getWidth(21),fontWeight: FontWeight.w600,),
            SizedBox(height: getHeight(6),),
            CustomText(text: "Enter OTP send your number",fontSize: getWidth(14),fontWeight: FontWeight.w400,color: AppColors.textGrey,),
            SizedBox(height: getHeight(32),),
            CustomOTPTextFormFieldWidget(
              controller: controller.otpTEController,
              fontSize: getWidth(20),
              activeFillColor: Colors.white,
              inactiveFillColor: Color(0xffFAFAFA),
              pinCount: 6,
            ),
            SizedBox(height: getHeight(20)),

            // TODO: enable button when 120s is done and invisible the text
            CustomFooterSection(titleText: "Didn’t receive the code? ", buttonTitle: "Resend code",onTap: (){
              if(enableResendCodeButton.value == true){
                startResendCodeTimer();
                if(isSignUp == true){
                  controller.resendOtp(email: email.toString(),reason:"SIGNUP_OTP_SECRET" );

                }else{
                  controller.resendOtp(email: email.toString(),reason:"FORGET_PASSWORD_SECRET" );

                }



              }else{
                AppSnackBar.showError("Please wait for timer finish");


              }
            },),
            buildCustomTimeAndSendAgainWidget(resendText: 'Resend code in',buttonName: "Send Again"),
            Spacer(),
            CustomElevatedButtonWidget(buttonTitle: "Continue",onPressed: (){
              if(isSignUp == true){
                controller.verifyOtp(email: email.toString(), reason: "SIGNUP_OTP_SECRET",token: token!,isSignUp: isSignUp);

              }else{
                controller.verifyOtp(email: email.toString(), reason: "FORGET_PASSWORD_SECRET",token: token!,isSignUp: isSignUp);


              }


            },),
            SizedBox(height: getHeight(40),)
          ],
        ),
      ),
    );
  }

  Widget buildCustomTimeAndSendAgainWidget({required String resendText, required String buttonName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Obx(()=>RichText(
            text: TextSpan(
              style: TextStyle(
                color: Color(0xff374151),
                fontSize: getWidth(15),
                fontWeight: FontWeight.w500,
              ),
              text: "$resendText ",
              children: [
                TextSpan(
                  text: "${remainingTime.value}s",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: getWidth(15),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ))

      ],
    );
  }
}


