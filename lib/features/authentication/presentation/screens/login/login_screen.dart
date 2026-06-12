import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_text.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/icon_path.dart';
import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';
import '../../../../../core/common/widgets/custom_password_form_field_widget.dart';
import '../../../../../core/common/widgets/custom_text_form_field_widget.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../controllers/login/login_controller.dart';
import '../../widgets/custom_footer_section_widget.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LogInController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: getHeight(160)),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: getWidth(21),
                    fontWeight: FontWeight.w700,
                    color: Color(0xff00322C),
                  ),
                ),
                SizedBox(height: getHeight(6)),
                Text(
                  'Welcome back, please enter your details',
                  style: TextStyle(
                    fontSize: getWidth(14),
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: getHeight(48)),
                CustomTextFormFieldWidget(
                  hintText: "Email Address",
                  prefixIconPath: IconPath.emailIcon,
                  controller: controller.emailController,
                ),

                SizedBox(height: getHeight(16)),

                Obx(
                  () => CustomPasswordFormFieldWidget(
                    hintText: "Password",
                    obscureText: controller.obscurePassword.value,
                    controller: controller.passwordController,
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
                SizedBox(height: getHeight(10)),

                // Remember me and Forgot Password
                buildRememberAndForgotPasswordSection(controller),

                SizedBox(height: getHeight(32)),
                CustomElevatedButtonWidget(
                  buttonTitle: "Log In",
                  onPressed: () {
                    controller.login();


                  },
                ),

                SizedBox(height: getHeight(28)),

                buildGoogleIconButtonWidget(buttonTitle: "Continue with Google",iconPath: IconPath.googleIcon,onTap: (){}),
                SizedBox(height: getHeight(290)),

                // Sign up prompt
                CustomFooterSection(titleText: "Don’t have an account? ",buttonTitle: "Sign up",onTap: (){
                  Get.toNamed(AppRoute.choseRoleScreen);
                },),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGoogleIconButtonWidget({
    required String buttonTitle,
    required String iconPath,
    required void Function()? onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: getHeight(24),
              width: getWidth(24),
            ),
            SizedBox(width: getWidth(10)),
            CustomText(
              text: buttonTitle,
              fontSize: getWidth(16),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRememberAndForgotPasswordSection(LogInController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Row(
            children: [
              GestureDetector(
                onTap: controller.toggleRememberMe,
                child:
                    controller.rememberMe.value
                        ? Image.asset(
                          IconPath.ticMarkIcon,
                          height: getHeight(24),
                          width: getWidth(24),
                        ): Container(
                      height: getHeight(20),
                      width: getWidth(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: getWidth(1.5),
                          color: AppColors.primary,
                        ),
                      ),
                    )
                    ,
              ),
              SizedBox(width: getWidth(8)),
              Text(
                "Remember me",
                style: TextStyle(
                  color: Color(0xff62666E),
                  fontSize: getWidth(15),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(AppRoute.forgotEmailScreen);
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: getWidth(15),
            ),
          ),
        ),
      ],
    );
  }
}


