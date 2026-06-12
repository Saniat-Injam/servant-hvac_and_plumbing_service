import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';
import 'package:servant_hvac_and_plumbing_service/features/user/home/presentation/widgets/input_label_widget.dart';

import '../../../../../core/common/widgets/custom_password_form_field_widget.dart';
import '../../controller/change_password_controller.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangePasswordController >();

    return Scaffold(
      body: Stack(
        children: [
          // Header
          Column(
            children: [
              Container(
                width: double.infinity,
                height: getHeight(200),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff7B4620), Color(0xffD26719)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          Positioned(
            top: getHeight(85),

            child: Center(
              child: Row(
                children: [
                  SizedBox(width: getWidth(18)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      ImagePath.backImage,
                      height: getHeight(50),
                      width: getWidth(50),
                    ),
                  ),
                  SizedBox(width: getWidth(60)),
                  Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getWidth(22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: getHeight(185),
            left: getWidth(0),
            right: getWidth(0),
            child: Container(
              height: AppSizes.height,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: getWidth(16),
                  right: getWidth(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: getHeight(16)),
                    Obx(
                          () => CustomPasswordFormFieldWidget(
                        hintText: "Current Password",
                        obscureText: controller.obscureCurrentPassword.value,
                        controller: controller.currentPasswordTEController,
                        onPressed: controller.toggleCurrentPasswordVisibility,
                      ),
                    ),
                    SizedBox(height: getHeight(16)),

                    Obx(
                          () => CustomPasswordFormFieldWidget(
                        hintText: "Password",
                        obscureText: controller.obscurePassword.value,
                        controller: controller.passwordTECController,
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    SizedBox(height: getHeight(16)),

                    Obx(
                          () => CustomPasswordFormFieldWidget(
                        hintText: "Confirm Password",
                        obscureText: controller.obscureConfirmPassword.value,
                        controller: controller.confirmPasswordTEController,
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    ),

                    SizedBox(height: getHeight(460),),
                    CustomElevatedButtonWidget(buttonTitle: "Update",onPressed: (){
                      controller.changePassword();
                    },),
                    SizedBox(height: getHeight(24),)

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextAndTextFormWidget({
    required String labelText,
    required String hintText,
    required TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label: labelText),
        SizedBox(height: getHeight(10)),
        Container(
          padding: EdgeInsets.symmetric(vertical: getHeight(4)),
          decoration: BoxDecoration(
            color: Color(0xffF9F9FB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: getWidth(1), color: Color(0xffF9F9FB)),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.textGrey,
                fontSize: getWidth(15),
                fontWeight: FontWeight.w400,
              ),

              contentPadding: EdgeInsets.symmetric(
                horizontal: getWidth(28),
                vertical: getHeight(14),
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  void showLogoutDialog(VoidCallback onConfirm) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.symmetric(
          horizontal: getWidth(40),
          vertical: getHeight(24),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: getWidth(20),
            right: getWidth(20),
            top: getHeight(20),
            bottom: getHeight(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: getHeight(10)),
              // Icon
              Image.asset(
                ImagePath.whatImage,
                height: getHeight(110),
                width: getWidth(110),
              ),
              SizedBox(height: getHeight(20)),

              // Title
              Text(
                "Are You Sure?",
                style: TextStyle(
                  fontSize: getWidth(20),
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: getHeight(6)),

              // Subtitle
              Text(
                "Do you want to log out ?",
                style: TextStyle(
                  fontSize: getWidth(16),
                  color: AppColors.textGrey,
                ),
              ),

              SizedBox(height: getHeight(28)),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Log Out Button
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF8B4513)),
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(24),
                        vertical: getHeight(12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: onConfirm,
                    child: const Text(
                      "Log Out",
                      style: TextStyle(color: Color(0xFF8B4513)),
                    ),
                  ),

                  // Cancel Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8B4513),
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(24),
                        vertical: getWidth(12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



}



