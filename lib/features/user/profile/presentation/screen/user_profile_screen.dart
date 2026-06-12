import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/icon_path.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';
import 'package:servant_hvac_and_plumbing_service/features/user/profile/controller/user_profile_controller.dart';
import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';
import 'package:shimmer/shimmer.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserProfileController>();

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
                    colors: [Color(0xff7B4620),
                      Color(0xffD26719),
                      ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          Positioned(
            top: getHeight(95),
            right: getWidth(185),

            child: Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getWidth(22),
                  fontWeight: FontWeight.w600,
                ),
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
              child: Column(
                children: [
                  SizedBox(height: getHeight(10),),
                  Obx((){
                    final profile = controller.profileDetails.value.result;
                    if(controller.isLoading.value){
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            // Circular avatar shimmer
                            Container(
                              width:getWidth(130),
                              height: getHeight(130),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(height: getHeight(8)),
                            // Name shimmer
                            Container(width: getWidth(120), height: getHeight(20), color: Colors.white),
                            SizedBox(height: getHeight(4)),
                            // Branch shimmer
                            Container(width: getWidth(80), height: getHeight(6), color: Colors.white),
                            SizedBox(height: getHeight(46)),
                          ],
                        ),
                      );
                    }
                    return Column(
                    children: [
                      Stack(
                        children: [
                          Obx(() {
                            if (controller.localImage.value != null) {
                              // Show local image (just picked)
                              return CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(controller.localImage.value!),
                              );
                            } else if (profile!.profileImage!.isNotEmpty) {
                              // Show network image
                              return CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(profile.profileImage.toString()),
                              );
                            } else {
                              // Show placeholder
                              return const CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage(ImagePath.noImage),
                              );
                            }
                          }),
                          Positioned(
                            bottom: getHeight(7),
                            right: getWidth(7),
                            child: InkWell(
                              onTap: () {
                                controller.pickImage();
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF8B4513),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  IconPath.editIcon,
                                  height: getHeight(14),
                                  width: getWidth(14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: getHeight(10)),
                       Text(
                          profile?.fullName??"N/A",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getWidth(18),
                          ),
                        ),

                      SizedBox(height: getHeight(5)),
                      Text(
                          profile?.email??"N/A",
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: getWidth(14),
                          ),
                        ),

                    ],
                  );}),
                  SizedBox(height: getHeight(20)),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getWidth(16),
                      right: getWidth(16),
                    ),
                    child: Divider(
                      height: getHeight(1),
                      color: Color(0xffE3E3E9),
                    ),
                  ),
                  SizedBox(height: getHeight(20)),
                  buildProfileListTile(title: "Edit Profile",iconPath: IconPath.editIcon,onTap: (){
                    Get.toNamed(AppRoute.userEditScreen,arguments: {
                      'fullName': controller.profileDetails.value.result?.fullName.toString(),
                      'address':controller.profileDetails.value.result?.address!= null? controller.profileDetails.value.result?.address.toString():"",
                      'latitude': controller.profileDetails.value.result?.lat.toString(),
                      'longitude': controller.profileDetails.value.result?.long.toString(),
                      'gender':controller.profileDetails.value.result?.gender.toString(),
                      'speciality': controller.branchesFromList(controller.profileDetails.value.result?.speciality),
                    });
    }

                  ),
                  buildProfileListTile(title: "Change Password",iconPath: IconPath.profilePasswordIcon,onTap: (){
                    Get.toNamed(AppRoute.changePasswordScreen);
                  }),
                  buildProfileListTile(title: "Privacy Policy",iconPath: IconPath.privacyPolicyIcon,onTap: (){
                    Get.toNamed(AppRoute.privacyPolicyScreen);
                  }),

                  ListTile(
                    leading: Image.asset(IconPath.logOutIcon, height: getHeight(24),
                      width: getWidth(24),),
                    title: Text(
                      "Logout",
                      style: TextStyle(fontSize: getWidth(17), fontWeight: FontWeight.w500,color: Color(0xff7B4620))),

                    onTap: (){
                      showLogoutDialog(context: context,onConfirm: (){
                        Get.back(); // Close dialog
                        controller.logout();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void showLogoutDialog({
    required VoidCallback onConfirm,
    required BuildContext context,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            insetPadding: EdgeInsets.symmetric(horizontal: getWidth(40), vertical: getHeight(24)),
            child: Padding(
              padding: EdgeInsets.all(getWidth(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: getHeight(10)),
                  Image.asset(
                    ImagePath.whatImage,
                    height: getHeight(110),
                    width: getWidth(110),
                  ),
                  SizedBox(height: getHeight(20)),

                  Text(
                    "Are You Sure?",
                    style: TextStyle(
                      fontSize: getWidth(20),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: getHeight(6)),

                  Text(
                    "Do you want to log out?",
                    style: TextStyle(
                      fontSize: getWidth(16),
                      color: AppColors.textGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getHeight(28)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF8B4513)),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B4513),
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(24),
                            vertical: getHeight(12),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }


  Widget buildProfileListTile({
    required String iconPath,
    required String title,
    required Function()? onTap,
  }) {
    return ListTile(
      leading: Image.asset(
        iconPath,
        height: getHeight(24),
        width: getWidth(24),
        color: Color(0xff2D2D2D),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: getWidth(17), fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

