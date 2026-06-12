import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_text.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_text_form_field_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/icon_path.dart';


import '../../../../../core/common/widgets/custom_app_bar_widget.dart';
import '../../../controllers/login/forgot_email_controller.dart';

class ForgotEmailScreen extends StatelessWidget {
  const ForgotEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotEmailController>();
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
              CustomText(text: "No worries — we’ll send you a reset link.",fontSize: getWidth(14),fontWeight: FontWeight.w400,color: AppColors.textGrey,),
              SizedBox(height: getHeight(32),),
              CustomTextFormFieldWidget(controller: controller.emailTEController, hintText: "Type your email", prefixIconPath: IconPath.emailIcon),
              Spacer(),
              CustomElevatedButtonWidget(buttonTitle: "Continue",onPressed: (){
                controller.forgotEmail();

              },),
              SizedBox(height: getHeight(40),)





            ],
          ),
        ),
      ),
    );
  }
}


