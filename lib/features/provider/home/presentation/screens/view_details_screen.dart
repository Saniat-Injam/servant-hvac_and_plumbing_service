import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_outlined_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/show_progress_indicator.dart';

import '../../../../../core/common/widgets/category_text.dart';
import '../../../../../core/common/widgets/custom_accept_dialog_box.dart';
import '../../../../../core/common/widgets/custom_text.dart';

import '../../../../../core/common/widgets/formatted_date_text_widget.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../controller/single_job_details_controller.dart';

class ViewDetailScreen extends StatelessWidget {
  const ViewDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String? jobId = args['jobId'] ;
    final bool? isUser = args['isUser'] ;

    final  controller = Get.find<SingleJobDetailsController>();
    controller.fetchProfileDetails(jobId: jobId.toString());
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: getHeight(16),
          right: getWidth(16),
          top: getHeight(58),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xff7B4620).withValues(alpha: 0.1),
                    child: Image.asset(
                      IconPath.backArrowIcon,
                      height: getHeight(44),
                      width: getWidth(44),
                    ),
                  ),
                ),
                SizedBox(width: getWidth(130)),
                CustomText(text: "Details", fontSize: getWidth(18)),
              ],
            ),
            Obx((){

              final singleJobDetails = controller.jobDetails.value.result;

              if(controller.isLoading.value) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: getHeight(350),),
                      ShowProgressIndicator(),
                    ],
                  ),
                );
              }

              if(singleJobDetails == null) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: getHeight(350),),
                      Text(
                        "No Job Details Found",
                        style: TextStyle(
                          fontSize: getWidth(16),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getWidth(20)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: singleJobDetails.serviceImage!= null?Image.network(
                    singleJobDetails.serviceImage.toString(),
                    height: getHeight(220),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ):Image.asset(
                    ImagePath.extraPendingImage,
                    height: getHeight(220),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: getHeight(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      singleJobDetails.serviceName??"N/A",
                      style: TextStyle(
                        fontSize: getWidth(20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Price: ',
                        style: TextStyle(color: AppColors.textGrey),
                        children: [
                          TextSpan(
                            text: "\$${singleJobDetails.price ?? 0}",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(10)),
                Row(
                  children: [
                    Image.asset(
                      IconPath.locationIcon,
                      height: getHeight(20),
                      color: AppColors.primary,
                    ),
                    SizedBox(width: getWidth(5)),
                    Expanded(
                      child: Text(
                        singleJobDetails.address.toString(),
                        style: TextStyle(
                          fontSize: getWidth(13),
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(5)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset(
                            IconPath.calenderIcon,
                            height: getHeight(20),
                            color: AppColors.primary,
                          ),
                          SizedBox(width: getWidth(5)),
                          FormattedDateText(
                            isoDate: singleJobDetails.serviceDate?.toIso8601String(),
                            style: TextStyle(fontSize:getWidth(14), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),

                    CategoryText(categoryKey:singleJobDetails.categories?.first)

                  ],
                ),

                SizedBox(height: getHeight(24)),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Service Description: ",
                      style: TextStyle(
                        fontSize: getWidth(17),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: getHeight(6)),
                    CustomText(
                      text:
                          singleJobDetails.desc ?? "No description provided",
                      color: AppColors.textGrey,
                      fontSize: getWidth(14),
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: getHeight(24)),

                    if(isUser!= true)
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButtonWidget(
                              buttonTitle: "Accept Request",
                              onPressed: () {
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  barrierColor: Colors.black54,
                                  transitionDuration: const Duration(milliseconds: 300),
                                  pageBuilder: (_, __, ___) {
                                    return Center(
                                      child: AcceptRequestDialog(
                                        title: "Accept Request?",
                                        description: "Do you want to accept this service request?",
                                        iconData: Icons.check_circle_outline,
                                        confirmButtonTitle: "Accept",
                                        cancelButtonTitle: "Cancel",
                                        onAccept: () {
                                          Navigator.pop(context);
                                          controller.changeStatus(status: "ACCEPTED", jobId: singleJobDetails.id.toString());
                                          // Handle accept logic
                                        },
                                        onReject: () {
                                          Navigator.pop(context);
                                          // Handle reject logic
                                        },
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

                              },
                            ),
                          ),
                          SizedBox(width: getWidth(16)),
                          Expanded(
                            child: CustomOutlineButtonWidget(
                              buttonTitle: "Cancel",
                              onPressed: () {
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  barrierColor: Colors.black54,
                                  transitionDuration: const Duration(milliseconds: 300),
                                  pageBuilder: (_, __, ___) {
                                    return Center(
                                      child: AcceptRequestDialog(
                                        title: "Cancel Request?",
                                        description: "Are you sure you want to cancel this service request?This action cannot be undone",
                                        iconData: Icons.delete_forever,
                                        confirmButtonTitle: "Confirm",
                                        cancelButtonTitle: "Back",
                                        onAccept: () {
                                          controller.changeStatus(status: "CANCELLED", jobId: singleJobDetails.id.toString());
                                          Navigator.pop(context);


                                          // Handle accept logic
                                        },
                                        onReject: () {
                                          Navigator.pop(context);

                                          // Handle reject logic
                                        },
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
                              },
                            ),
                          ),
                        ],
                      ),


                  ],
                ),
              ],
            );}),
          ],
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat("MMMM dd, yyyy 'at' h:mm a");
    return formatter.format(dateTime);
  }
}
