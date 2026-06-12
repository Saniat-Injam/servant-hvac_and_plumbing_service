import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_outlined_button_widget.dart';

import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';

import '../../../../../core/common/widgets/category_text.dart';
import '../../../../../core/common/widgets/custom_accept_dialog_box.dart';
import '../../../../../core/common/widgets/formatted_date_text_widget.dart';
import '../../../../../core/common/widgets/show_progress_indicator.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/constants/icon_path.dart';

import '../../../../../core/utils/constants/image_path.dart';
import '../../../../provider/home/controller/single_job_details_controller.dart';
import '../../controller/service_controller.dart';

class ActiveWidgets extends StatelessWidget {
  const ActiveWidgets({super.key, required this.controller});

  final ServicesController controller;

  @override
  Widget build(BuildContext context) {

    final singleJobDetailsController = Get.find<SingleJobDetailsController>();
    return Expanded(
      child: Obx((){

        final inActiveList = controller.activeDetails.value.result?.data ?? [];

        if(controller.isLoading1.value){
          return Center(child: Column(
            children: [
              SizedBox(height: getHeight(350),),
              ShowProgressIndicator(),
            ],
          ),);
        }
        if(inActiveList  .isEmpty){
          return Center(child: Column(
            children: [
              SizedBox(height: getHeight(350),),

              Text("No Active Service Found!",style: TextStyle(fontSize: getWidth(16),fontWeight: FontWeight.w500,color: AppColors.textGrey),)
            ],
          ),);
        }
        return ListView.builder(
        itemCount: inActiveList.length,
        itemBuilder: (_, index) {
          final service = inActiveList[index];
          return GestureDetector(
            onTap: (){
              Get.toNamed(AppRoute.viewDetailsScreen,arguments: {
                'jobId': service.id,
                "isUser": true,
              });
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(16),
                    vertical: getHeight(8),
                  ),
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
                              child: service.serviceImage != null? Image.network(service.serviceImage.toString(), height: getHeight(140),
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
                                      service.serviceName ?? "N/A",
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
                                            service.address??'',
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
                                            isoDate:service.serviceDate?.toIso8601String(),
                                            style: TextStyle(fontSize:getWidth(14), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: getHeight(10)),
                                    Row(
                                      children: [
                                        CategoryText(categoryKey:service.categories?.first),
                                        SizedBox(width: getWidth(10)),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              text: 'Price: ',
                                              style: const TextStyle(color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                  text: "\$${service.price?? '0'}",
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
                SizedBox(height: getHeight(8)),

                Padding(
                  padding: EdgeInsets.only(
                    left: getWidth(16),
                    right: getWidth(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButtonWidget(buttonTitle: "Payment",onPressed: (){
                          Get.toNamed(AppRoute.paymentScreen,  arguments: {
                            'imagePath': service.serviceImage,
                            'serviceName': service.serviceName,
                            'address': service.address,
                            'time': service.serviceDate?.toIso8601String(),
                            'price': service.price.toString(),
                            'category': service.categories?.first,
                            'serviceId': service.id,
                          },);
                        },),
                      ),

                      SizedBox(width: getWidth(10)),

                      Expanded(
                        child: CustomOutlineButtonWidget(buttonTitle: "Cancel",onPressed: (){

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
                                    singleJobDetailsController.changeStatus(status: "CANCELLED", jobId: service.id.toString());
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
                        },),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
