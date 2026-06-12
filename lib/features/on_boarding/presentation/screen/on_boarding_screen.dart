import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';
import '../../../../core/common/widgets/custom_elevated_button_widget.dart';
import '../../../../core/common/widgets/custom_outlined_button_widget.dart';
import '../../../../core/common/widgets/custom_text.dart';
import '../../../../core/services/Auth_service.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/constants/image_path.dart';





class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          buildCustomImageContainer(),

          SizedBox(
            height: getHeight(45),
          ),
          Padding(
            padding: EdgeInsets.only(left: getWidth(24), right: getWidth(24)),
            child: buildBodyColumWidget(),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: getWidth(24), right: getWidth(24)),
            child: CustomElevatedButtonWidget(buttonTitle: "Log In",onPressed: () async {
              await AuthService.setOnboardingSeen(true);
              Get.toNamed(AppRoute.loginScreen);
            },),
          ),
          SizedBox(
            height: getHeight(20),
          ),
          Padding(
            padding: EdgeInsets.only(left: getWidth(24), right: getWidth(24)),
            child: CustomOutlineButtonWidget(buttonTitle: "Sign Up",onPressed: () async {
              await AuthService.setOnboardingSeen(true);
              Get.toNamed(AppRoute.choseRoleScreen);
            },),
          ),
          SizedBox(
            height: getHeight(40),
          ),


        ],
      ),
    );
  }

  Widget buildBodyColumWidget() {
    return Column(
            children: [
              CustomText(
                text: "Welcome Back 👋",
                color: AppColors.textPrimary,

                fontSize: getWidth(23),
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: getHeight(10),
              ),
              CustomText(
                text:
                    "We happy to see you again! to use your account, you should Log in first.",

                fontSize: getWidth(15),
                fontWeight: FontWeight.w300,
                color: AppColors.textGrey,
                textAlign: TextAlign.center,
              ),

            ],
          );
  }

  Widget buildCustomImageContainer() {
    return Image.asset(ImagePath.onBoardingImage,width: double.infinity,fit: BoxFit.cover,);
  }
}






