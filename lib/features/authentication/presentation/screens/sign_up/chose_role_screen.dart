import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';
import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';

import '../../../controllers/sign_up/chose_role_controller.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChoseRoleController >();
    return SafeArea(
      child: Scaffold(
      
        body: Padding(
          padding: EdgeInsets.only(left: getWidth(16), right: getWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             SizedBox(height: getHeight(180)),

              // Icon in circle
              buildImageContainer(),

              SizedBox(height: getHeight(20)),

              // Title
              Text(
                "Define your role",
                style: TextStyle(
                    fontSize:getWidth(22), fontWeight: FontWeight.w600),
              ),
               SizedBox(height: getHeight(10)),

              // Subtitle
             Text(
                "Create an account or log in to book your desired\nservices quickly and easily",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: getWidth(15), color: AppColors.textGrey),
              ),

              SizedBox(height: getHeight(40)),

              // Customer Button
              Obx(() => roleButton(
                title: "Customer",
                selected: controller.selectedRole.value == "CUSTOMER",
                onTap: () => controller.selectRole("CUSTOMER"),
              )),

              SizedBox(height: getHeight(15)),

              // Service Provider Button
              Obx(() => roleButton(
                title: "Service Provider",
                selected: controller.selectedRole.value == "PROVIDER",
                onTap: () => controller.selectRole("PROVIDER"),
              )),
              Spacer(),
              CustomElevatedButtonWidget(buttonTitle: "Continue",onPressed: (){
                if(controller.selectedRole.value == "CUSTOMER"){
                  Get.toNamed(AppRoute.signUpScreen);

                } else{
                  Get.toNamed(AppRoute.providerSignUpScreen);
                }

              },),
              SizedBox(height: getHeight(50),)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageContainer() {
    return Container(
              padding:  EdgeInsets.only(left: getWidth(16),right: getWidth(16),top: getHeight(16),bottom: getHeight(16)),
              decoration: BoxDecoration(
                color: Color(0xffEBE3DE),
                shape: BoxShape.circle,
              ),
              child: Image.asset(ImagePath.callImage,height: getHeight(32),width: getWidth(32),),
            );
  }

  Widget roleButton(
      {required String title, required bool selected, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: getWidth(20), vertical: getHeight(16)),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: getWidth(16),
              ),
            ),
            Container(
              width: getWidth(22),
              height: getHeight(22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ?AppColors.textWhite:Color(0xffD6C6BA)
              ),
              child: Container(
                width: getWidth(20),
                height: getHeight(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ?AppColors.textWhite:Color(0xffD6C6BA) ,
                    width: getWidth(3),
                  ),
                  color: selected ?Color(0xffD6C6BA):Color(0xffD6C6BA)
                      
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}