
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_password_form_field_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_text.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import '../../../../../core/common/widgets/custom_app_bar_widget.dart';

import '../../../controllers/login/reset_password_controller.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();

    final arguments = Get.arguments ?? {};
    final String? token = arguments['token'];
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: getWidth(16),right: getWidth(16)),
        child: Center(
          child: Column(

            children: [
              CustomAppBarWidget(onTap: (){
                Get.back();
              },),
              CustomText(text: "Reset Password",fontSize: getWidth(21),fontWeight: FontWeight.w600,),
              SizedBox(height: getHeight(6),),
              CustomText(text: "The password must be different than before",fontSize: getWidth(14),fontWeight: FontWeight.w400,color: AppColors.textGrey,),
              SizedBox(height: getHeight(32),),
              Obx(()=>CustomPasswordFormFieldWidget(hintText: "Password", obscureText: controller.obscurePassword.value,controller: controller.passwordTECController,onPressed: controller.togglePasswordVisibility,)),
              SizedBox(height: getHeight(16),),
              Obx(()=>CustomPasswordFormFieldWidget(hintText: "Confirm Password", obscureText: controller.obscureConfirmPassword.value,controller: controller.confirmPasswordTEController,onPressed: controller.toggleConfirmPasswordVisibility,)),
              Spacer(),
              CustomElevatedButtonWidget(buttonTitle: "Continue",onPressed: (){
                controller.changePassword(token: token!);

              },),
              SizedBox(height: getHeight(40),)





            ],
          ),
        ),
      ),
    );
  }
}


