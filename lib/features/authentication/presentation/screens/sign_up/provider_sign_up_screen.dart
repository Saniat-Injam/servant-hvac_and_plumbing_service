import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_text_form_field_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/icon_path.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';

import '../../../../../core/common/widgets/custom_password_form_field_widget.dart';
import '../../../../../core/common/widgets/custom_text.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../user/home/presentation/screens/map_screen.dart';
import '../../../controllers/sign_up/provider_sign_up_controller.dart';
import '../../widgets/category_drop_down.dart';
import '../../widgets/custom_footer_section_widget.dart';

class ProviderSignUpScreen extends StatelessWidget {
  const ProviderSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderSignUpController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(20),
            vertical: getHeight(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: getHeight(10)),
              Text(
                "Create an account",
                style: TextStyle(
                  fontSize: getHeight(24),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: getHeight(10)),
              Text(
                "Join Servant to access trusted engineers and\nhassle-free technical services in minutes.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getWidth(15),
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: getHeight(24)),
              CustomTextFormFieldWidget(
                controller: controller.nameTEController,
                hintText: "Enter Your Name",
                prefixIconPath: IconPath.fullNameIcon,
              ),
              SizedBox(height: getHeight(16)),


              CustomTextFormFieldWidget(
                hintText: "jadenb@gmail.com",
                prefixIconPath: IconPath.emailIcon,
                controller: controller.emailTEController,
              ),
              SizedBox(height: getHeight(16)),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: getWidth(1),
                    color: AppColors.textFormFieldBorder,
                  ),
                ),
                child: TextField(


                  controller: controller.locationTEController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select a location",
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: getWidth(14),
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: IconButton(onPressed: () async {
                      LatLng? selectedLocation = await Get.to(() => MapScreenProfile());
                      if (selectedLocation != null) {
                        // Store lat/lng in controller
                        controller.setLatLng(selectedLocation.latitude, selectedLocation.longitude);

                        // Convert to address
                        String address = await _getAddressFromLatLng(selectedLocation);
                        controller.locationTEController .text = address;
                      }


                    }, icon: Padding(
                      padding:  EdgeInsets.only(left: getWidth(16)),
                      child: Image.asset(IconPath.locationIcon,height: getHeight(18),width: getWidth(18),),
                    )),

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getWidth(20),
                      vertical: getHeight(14),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              // Name
              SizedBox(height: getHeight(16)),

              // Upload License
              Obx(
                () => uploadBox(
                  "Upload Your License",
                  controller.licenseImage.value,
                  () => controller.pickImage(true),
                ),
              ),

              SizedBox(height: getHeight(16)),

              // Upload ID
              Obx(
                () => uploadBox(
                  "Upload Your ID",
                  controller.idImage.value,
                  () => controller.pickImage(false),
                ),
              ),
              SizedBox(height: getHeight(16)),
              CategoryDropdown(
                hintText: "Select Categories",
                prefixIconPath: IconPath.documentIcon,
              ),

              SizedBox(height: getHeight(16)),
              CustomTextFormFieldWidget(
                controller: controller.shortDescriptionTEController,
                hintText: "Write your short description",
                prefixIconPath: IconPath.documentIcon,
                maxLines: 4,
              ),

              // Short Description


              // Name


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

             SizedBox(height: getHeight(24)),

              CustomElevatedButtonWidget(buttonTitle: "Sign Up",onPressed: (){
                controller.createProviderAccount();


              },),
              SizedBox(height: getHeight(12),),
              Image.asset(ImagePath.orImage,height: getHeight(30),width: double.infinity,),

              SizedBox(height: getHeight(28)),

              buildGoogleIconButtonWidget(buttonTitle: "Continue with Google",iconPath: IconPath.googleIcon,onTap: (){}),
              SizedBox(height: getHeight(100)),


              // Sign up prompt
              CustomFooterSection(titleText: "All Ready have an account? ",buttonTitle: "Sign In",onTap: (){
                Get.toNamed(AppRoute.loginScreen);
              },),
              SizedBox(height: getHeight(20)),

              // Sign In Button

            ],
          ),
        ),
      ),
    );
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks.first;
        return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }
      return "Unknown location";
    } catch (e) {
      return "Failed to get address";
    }
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



  Widget uploadBox(String label, File? image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getHeight(130),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffD6C6BA), width: getWidth(1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child:
            image != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(image, fit: BoxFit.cover),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: getWidth(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: getHeight(10)),
                    Image.asset(
                      ImagePath.uploadImage,
                      height: getHeight(28),
                      width: getWidth(28),
                    ),
                  ],
                ),
      ),
    );
  }
}
