
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/icon_path.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';
import 'package:servant_hvac_and_plumbing_service/features/user/profile/controller/user_profile_controller.dart';


import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';


import '../../../../provider/home/presentation/widgets/home_profile_shimmer.dart';
import '../../controller/home_controller.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserHomeController>();
    final profileController = Get.find<UserProfileController>();

    return Scaffold(


      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(left: getWidth(16),right: getWidth(16),top: getHeight(16),bottom: getHeight(16)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row
                SizedBox(height: getHeight(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx((){
                      
                      final profile = profileController.profileDetails.value.result;
                       if(profileController.isLoading.value){
                         return HomeProfileShimmer();

                       }
                      return Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                            backgroundImage: (profile?.profileImage != null && profile!.profileImage!.trim().isNotEmpty)
                                ? NetworkImage(profile.profileImage!.trim())
                                : AssetImage(ImagePath.noImage) as ImageProvider, // sample image
                        ),
                        SizedBox(width: getWidth(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, ${profile?.fullName?.split(' ').first ?? ''} 👋",
                              style: TextStyle(
                                fontSize: getWidth(20),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "What service do you need today?",
                              style: TextStyle(
                                  fontSize: getWidth(12), color: AppColors.textGrey,fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    );}),
                    Stack(
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xff7B4620).withValues(alpha: 0.1),
                            child: GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoute.notificationScreen);
                              },
                                child: Image.asset(IconPath.notificationIcon,height: getHeight(28),width: getWidth(28),))),
                        Positioned(
                          right: getWidth(10),
                          top: getHeight(12),
                          child: Container(
                            height: getHeight(10),
                            width: getWidth(10),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(height: getHeight(20)),
                CustomElevatedButtonWidget(buttonTitle: "Service Request",onPressed: (){
                  Get.toNamed(AppRoute.requestServiceScreen,arguments: '');
                },),

                //

                // Service Request Button


                SizedBox(height: getHeight(16)),
                Text("Our Services",
                    style:
                    TextStyle(fontSize: getWidth(18), fontWeight: FontWeight.w700)),

                SizedBox(height: getWidth(12)),

                // Services Grid
                 GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.services.length,
                  gridDelegate:
                   SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (context, index) {
                    var service = controller.services[index];
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.requestServiceScreen,arguments: service["title"]);

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: service["color"] as Color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(service["icon"] as String ,height: getHeight(40),width: getWidth(40),)
                            ,
                            SizedBox(height: getHeight(10)),
                            Text(
                              service["title"] as String,
                              style:  TextStyle(
                                  fontSize: getWidth(17), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}