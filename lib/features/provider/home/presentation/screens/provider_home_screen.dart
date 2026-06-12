import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:servant_hvac_and_plumbing_service/features/provider/home/controller/provider_home_controller.dart';
import 'package:servant_hvac_and_plumbing_service/features/user/profile/controller/user_profile_controller.dart';
import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';

import '../../../../../core/common/widgets/category_text.dart';
import '../../../../../core/common/widgets/custom_elevated_button_widget.dart';
import '../../../../../core/common/widgets/formatted_date_text_widget.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../widgets/home_profile_shimmer.dart';
import '../widgets/job_card_shimmer.dart';

class EngineerHomeScreen extends StatelessWidget {
  const EngineerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<UserProfileController>();

    final controller = Get.put(ProviderHomeController());

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            left: getWidth(16),
            right: getWidth(16),
            top: getHeight(30),
          ),
          child: Column(
            children: [
              SizedBox(height: getHeight(24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    final profile =
                        profileController.profileDetails.value.result;
                    if (profileController.isLoading.value) {
                      return HomeProfileShimmer();
                    }
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              (profile?.profileImage != null &&
                                      profile!.profileImage!.trim().isNotEmpty)
                                  ? NetworkImage(profile.profileImage!.trim())
                                  : AssetImage(ImagePath.noImage)
                                      as ImageProvider, // sample image
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
                                fontSize: getWidth(12),
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(
                          0xff7B4620,
                        ).withValues(alpha: 0.1),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.notificationScreen);
                          },
                          child: Image.asset(
                            IconPath.notificationIcon,
                            height: getHeight(28),
                            width: getWidth(28),
                          ),
                        ),
                      ),
                      Positioned(
                        right: getWidth(13),
                        top: getHeight(16),
                        child: Container(
                          height: getHeight(10),
                          width: getWidth(10),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: getHeight(30)),

              Row(
                children: [
                  Text(
                    "Services Request List",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     //Get.to(() => ServiceListScreen());
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "See all",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 14,
                  //           color: Color(0xff747474),
                  //         ),
                  //       ),
                  //       SizedBox(width: getWidth(6)),
                  //       Icon(
                  //         Icons.arrow_forward_ios_outlined,
                  //         size: 14,
                  //         color: Color(0xff747474),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),

              Obx(() {
                if (controller.isLoading.value) {
                  // Show shimmer placeholders (3 items for example)
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (_, __) => const JobCardShimmer(),
                  );
                }
                if (controller.timeBaseEventModelList.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: getHeight(350),),
                      Text("No pending jobs yet",style: TextStyle(color: Colors.grey,fontSize: getWidth(14)),),
                    ],
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.timeBaseEventModelList.length,
                  itemBuilder: (_, index) {
                    final service = controller.timeBaseEventModelList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: getHeight(12)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: getWidth(0.2),
                              color: const Color(0xffC8C8C8),
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                child:
                                    service.serviceImage != null
                                        ? Image.network(
                                          service.serviceImage.toString(),
                                          height: getHeight(130),
                                          width: getWidth(130),
                                          fit: BoxFit.cover,
                                        )
                                        : Image.asset(
                                          ImagePath.noImage,
                                          height: getHeight(130),
                                          width: getWidth(130),
                                          fit: BoxFit.cover,
                                        ),
                              ),
                              SizedBox(width: getWidth(12)),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: getHeight(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.serviceName ?? "N/A",
                                        style: TextStyle(
                                          fontSize: getWidth(16),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: getHeight(4)),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            IconPath.serviceLocationIcon,
                                            height: getHeight(16),
                                            width: getWidth(16),
                                          ),
                                          SizedBox(width: getWidth(4)),
                                          Expanded(
                                            child: Text(
                                              service.address ?? "N/A",
                                              style: TextStyle(
                                                fontSize: getWidth(13),
                                                color: AppColors.textGrey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: getHeight(4)),
                                      Row(
                                        children: [
                                          Image.asset(
                                            IconPath.calenderIcon,
                                            height: getHeight(16),
                                            width: getWidth(16),
                                          ),
                                          SizedBox(width: getWidth(4)),
                                          Expanded(
                                            child: FormattedDateText(
                                              isoDate:
                                                  service.serviceDate
                                                      ?.toIso8601String(),
                                              style: TextStyle(
                                                fontSize: getWidth(14),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: getHeight(10)),
                                      Row(
                                        children: [
                                          CategoryText(
                                            categoryKey:
                                                service.categories?.first,
                                          ),
                                          SizedBox(width: getWidth(10)),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                text: 'Price: ',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "\$${service.price.toString()}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: getWidth(13),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.end,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                        CustomElevatedButtonWidget(
                          buttonTitle: "View Details",
                          onPressed: () {
                            Get.toNamed(
                              AppRoute.viewDetailsScreen,
                              arguments: {"jobId": service.id},
                            );
                          },
                        ),
                        SizedBox(height: getHeight(16)),
                      ],
                    );
                  },
                );
              }),

              SizedBox(height: 80), // space for chatbot button
            ],
          ),
        ),
      ),
    );
  }
}
