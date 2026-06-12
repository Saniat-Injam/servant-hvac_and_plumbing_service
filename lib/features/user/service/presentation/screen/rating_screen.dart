
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_outlined_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizer.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';
import '../../../../../core/common/widgets/custom_text.dart';

import '../../../../../core/utils/constants/app_colors.dart';

import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../routes/app_routes.dart';
import '../../controller/rating_controller.dart';

class RatingScreen extends StatelessWidget{
  const RatingScreen(  {super.key});




  @override
  Widget build(BuildContext context) {

    final controller = Get.find<RatingController>();

    final arguments = Get.arguments;

    final String? serviceId = arguments['serviceId'] ?? '';
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(15),),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
                    ),
                    SizedBox(width: 90.w,),
                    CustomText(
                      text: "Rating & Review",
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 24.h,),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: getWidth(4),color: AppColors.primary)
                    ),
                    child: CircleAvatar(

                      radius: 45,
                      backgroundImage: AssetImage(ImagePath.extraPendingImage),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                CustomText(text: "How was your experience with this Service from “Zayn Malik”", fontWeight: FontWeight.w500, fontSize: 16.sp),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final rating = 5;
                            return Icon(
                              Icons.star,
                              size: 30,
                              color: index < rating ? AppColors.primary : Colors.grey,
                            );
                          }),
                        ),
                        SizedBox(width: getWidth(15),),
                        CustomText(text: "Excellent",fontSize: 16,),
                      ],
                    ),

                    Obx(() => Checkbox(
                      value: controller.fiveIsClicked.value,
                      activeColor: AppColors.primary,
                      checkColor: Colors.white,
                      onChanged: (bool? change){
                        controller.fiveIsClicked.value = change!;
                        controller.fourIsClicked.value = false;
                        controller.threeIsClicked.value = false;
                        controller.twoIsClicked.value = false;
                        controller.oneIsClicked.value = false;
                        controller.rating.value = 5;
                      },
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final rating = 4;
                            return Icon(
                              Icons.star,
                              size: 30,
                              color: index < rating ? AppColors.primary : Colors.grey,
                            );
                          }),
                        ),
                        SizedBox(width: getWidth(15),),
                        CustomText(text: "Good",fontSize: 16,),
                      ],
                    ),
                    Obx(() => Checkbox(
                      value: controller.fourIsClicked.value,
                      activeColor: AppColors.primary,
                      checkColor: Colors.white,
                      onChanged: (bool? change){
                        controller.fiveIsClicked.value = false;
                        controller.fourIsClicked.value = change!;
                        controller.threeIsClicked.value = false;
                        controller.twoIsClicked.value = false;
                        controller.oneIsClicked.value = false;
                        controller.rating.value = 4;
                      },
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final rating = 3;
                            return Icon(
                              Icons.star,
                              size: 30,
                              color: index < rating ? AppColors.primary : Colors.grey,
                            );
                          }),
                        ),
                        SizedBox(width: getWidth(15),),
                        CustomText(text: "Average",fontSize: 16,),
                      ],
                    ),
                    Obx(() => Checkbox(
                      value: controller.threeIsClicked.value,
                      activeColor: AppColors.primary,
                      checkColor: Colors.white,
                      onChanged: (bool? change){
                        controller.fiveIsClicked.value = false;
                        controller.fourIsClicked.value = false;
                        controller.threeIsClicked.value = change!;
                        controller.twoIsClicked.value = false;
                        controller.oneIsClicked.value = false;
                        controller.rating.value = 3;
                      },
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final rating = 2;
                            return Icon(
                              Icons.star,
                              size: 30,
                              color: index < rating ? AppColors.primary : Colors.grey,
                            );
                          }),
                        ),
                        SizedBox(width: getWidth(15),),
                        CustomText(text: "Improvement",fontSize: 16,),
                      ],
                    ),
                    Obx(() => Checkbox(
                      value: controller.twoIsClicked.value,
                      activeColor: AppColors.primary,
                      checkColor: Colors.white,
                      onChanged: (bool? change){
                        controller.fiveIsClicked.value = false;
                        controller.fourIsClicked.value = false;
                        controller.threeIsClicked.value = false;
                        controller.twoIsClicked.value = change!;
                        controller.oneIsClicked.value = false;
                        controller.rating.value = 2;
                      },
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final rating = 1;
                            return Icon(
                              Icons.star,
                              size: 30,
                              color: index < rating ? AppColors.primary : Colors.grey,
                            );
                          }),
                        ),
                        SizedBox(width: getWidth(15),),
                        CustomText(text: "Poor",fontSize: 16,),
                      ],
                    ),
                    Obx(() => Checkbox(
                      value: controller.oneIsClicked.value,
                      activeColor: AppColors.primary,
                      checkColor: Colors.white,
                      onChanged: (bool? change){
                        controller.fiveIsClicked.value = false;
                        controller.fourIsClicked.value = false;
                        controller.threeIsClicked.value = false;
                        controller.twoIsClicked.value = false;
                        controller.oneIsClicked.value = change!;
                        controller.rating.value = 1;
                      },
                    ))
                  ],
                ),
                SizedBox(height: 16.h,),
                CustomText(text: "Write your review", fontWeight: FontWeight.w500, fontSize: 16.sp),
                SizedBox(height: 16.h,),
                TextFormField(
                  maxLines: 5,
                  controller: controller.messageTEController,
                  onTapOutside: (d){
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "Write your message here",
                    hintStyle: GoogleFonts.dmSans(
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      height: 20 / 14,

                    ),
                    fillColor: Colors.transparent, // Make background transparent
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(8.h)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide( width: 0.5),
                        borderRadius: BorderRadius.circular(8.h)
                    ),
                    contentPadding: EdgeInsets.only(left: 12.w,right: 10.w,top: 12.h,bottom: 12.h),
                  ),
                ),
                SizedBox(height: 150,),
                CustomElevatedButtonWidget(buttonTitle: "Done",onPressed: (){
                  controller.createReview(serviceId: serviceId.toString());
                },),


                SizedBox(height: 12.h,),
                CustomOutlineButtonWidget(buttonTitle: "Skip",onPressed: (){
                  Get.offAllNamed(AppRoute.userNavBarScreen);
                },)



              ],
            ),
          ),
        ),
      ),
    );
  }
}