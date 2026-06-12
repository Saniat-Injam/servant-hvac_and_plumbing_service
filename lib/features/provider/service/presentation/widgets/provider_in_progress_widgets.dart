import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/show_progress_indicator.dart';
import '../../../../../core/common/widgets/category_text.dart';
import '../../../../../core/common/widgets/custom_accept_dialog_box.dart';
import '../../../../../core/common/widgets/formatted_date_text_widget.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/constants/icon_path.dart';

import '../../../../../core/utils/constants/image_path.dart';
import '../../../../../routes/app_routes.dart';
import '../../controller/provider_service_controller.dart';

class ProviderInProgressWidgets extends StatelessWidget {
  const ProviderInProgressWidgets({super.key, required this.controller});

  final ProviderServicesController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx((){
        final inProgressList = controller.progressServiceDetails.value.result?.data ?? [];

        if(controller.isLoading.value){
          return Center(child: Column(
            children: [
              SizedBox(height: getHeight(350),),
              ShowProgressIndicator(),
            ],
          ),);
        }
        if(inProgressList .isEmpty){
          return Center(child: Column(
            children: [
              SizedBox(height: getHeight(350),),

              Text("No In Progress Service Found!",style: TextStyle(fontSize: getWidth(16),fontWeight: FontWeight.w500,color: AppColors.textGrey),)
            ],
          ),);
        }


        return ListView.builder(
        itemCount: inProgressList.length,
        itemBuilder: (_, index) {
          final inProgressItem = inProgressList[index];
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(16),
                  vertical: getHeight(8),
                ),
                child:  GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoute.viewDetailsScreen,arguments: {
                      'jobId': inProgressItem.id,
                      "isUser": true,
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: getWidth(0.2), color: const Color(0xffC8C8C8)),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              child: inProgressItem.serviceImage != null? Image.network(inProgressItem.serviceImage.toString(), height: getHeight(140),
                                width: getWidth(130),
                                fit: BoxFit.cover,):Image.asset(
                                ImagePath.noImage,
                                height: getHeight(130),
                                width: getWidth(140),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: getWidth(12)),
                            Expanded(
                              child: Padding(
                                padding:EdgeInsets.symmetric(vertical:getHeight(8)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      inProgressItem.serviceName??'N/A',
                                      style:  TextStyle(fontSize: getWidth(16), fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: getHeight(4)),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          IconPath.serviceLocationIcon,
                                          height: getHeight(16),
                                          width: getWidth(16),

                                        ),
                                        SizedBox(width: getWidth(4)),
                                        Expanded(
                                          child: Text(
                                           inProgressItem.address??"",
                                            style: TextStyle(fontSize: getWidth(13), color: AppColors.textGrey,fontWeight: FontWeight.w500),
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
                                            isoDate:inProgressItem.serviceDate?.toIso8601String(),
                                            style: TextStyle(fontSize:getWidth(14), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: getHeight(10)),
                                    Row(
                                      children: [
                                        CategoryText(categoryKey:inProgressItem.categories?.first),
                                         SizedBox(width: getWidth(10)),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              text: 'Price: ',
                                              style: const TextStyle(color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                  text: "\$${inProgressItem.price??'0'}",
                                                  style: TextStyle(color: Colors.black,fontSize: getWidth(13),fontWeight: FontWeight.w500),
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
                            SizedBox(width: getWidth(12)),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              SizedBox(height: getHeight(8)),

              // Padding(
              //   padding: EdgeInsets.only(
              //     left: getWidth(16),
              //     right: getWidth(16),
              //     bottom: getHeight(10)
              //   ),
              //   child:
              //       CustomElevatedButtonWidget(buttonTitle: "Complete",onPressed: (){
              //
              //         showGeneralDialog(
              //           context: context,
              //           barrierDismissible: false,
              //           barrierColor: Colors.black54,
              //           transitionDuration: const Duration(milliseconds: 300),
              //           pageBuilder: (_, __, ___) {
              //             return Center(
              //               child: AcceptRequestDialog(
              //                 title: "Complete Request?",
              //                 description: "Do you want to complete this service request?",
              //                 iconData: Icons.check_circle_outline,
              //                 confirmButtonTitle: "Complete",
              //                 cancelButtonTitle: "Cancel",
              //                 onAccept: () {
              //                   Navigator.pop(context);
              //                   // Handle accept logic
              //                 },
              //                 onReject: () {
              //                   Navigator.pop(context);
              //                   // Handle reject logic
              //                 },
              //               ),
              //             );
              //           },
              //           transitionBuilder: (_, animation, __, child) {
              //             return ScaleTransition(
              //               scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              //               child: child,
              //             );
              //           },
              //         );
              //       },),
              //
              //
              //
              //
              // ),
            ],
          );
        },
      );}),
    );
  }

  Widget buildPriceRowWidget({required String title, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: getWidth(16), fontWeight: FontWeight.w600),
        ),
        Text(
          "£ $price",
          style: TextStyle(
            color: Color(0xff0277BD),
            fontSize: getWidth(16),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
