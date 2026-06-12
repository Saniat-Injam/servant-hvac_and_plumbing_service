
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';


import '../../../../../core/common/widgets/category_text.dart';
import '../../../../../core/common/widgets/formatted_date_text_widget.dart';
import '../../../../../core/common/widgets/show_progress_indicator.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../../../../routes/app_routes.dart';
import '../../controller/provider_service_controller.dart';



class ProviderCompleteWidget extends StatelessWidget {
  const ProviderCompleteWidget({
    super.key,
    required this.controller,
  });

  final ProviderServicesController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Obx((){

        final inCompleteList = controller.completeDetails.value.result?.data ?? [];

        if(controller.isLoading1.value){
          return Center(child: Column(
            children: [
              SizedBox(height: getHeight(350),),
              ShowProgressIndicator(),
            ],
          ),);
        }
        if(inCompleteList  .isEmpty){
          return Center(child: Column(
            children: [
              SizedBox(height: getHeight(350),),

              Text("No Completed Service Found!",style: TextStyle(fontSize: getWidth(16),fontWeight: FontWeight.w500,color: AppColors.textGrey),)
            ],
          ),);
        }



        return ListView.builder(
        itemCount: inCompleteList.length,
        itemBuilder: (_, index) {
          final service = inCompleteList[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(16),
              vertical: getHeight(8),
            ),
            child: GestureDetector(
              onTap: (){
                Get.toNamed(AppRoute.viewDetailsScreen,arguments: {
                  'jobId': service.id,
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
                                    Text.rich(
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
                                  ],
                                ),
                                SizedBox(height: getHeight(10)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CategoryText(categoryKey:service.categories?.first),
                                    SizedBox(width: getWidth(10)),
                                    Row(

                                      children: [

                                        Icon(Icons.star, color: Colors.amber, size: getWidth(26)),
                                        SizedBox(width: getWidth(4)),
                                        service.rating!.isEmpty?Text("Not given",style: TextStyle(fontSize: getWidth(14), fontWeight: FontWeight.w500),):
                                        Text(
                                          service.rating?.first.rating?.toStringAsFixed(1)??'0',
                                          style: TextStyle(fontSize: getWidth(14), fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
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
          );
        },
      );})
    );
  }
}