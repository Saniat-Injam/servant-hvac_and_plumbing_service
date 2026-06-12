import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_text.dart';


import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';



class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {


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
                    colors: [Color(0xff7B4620), Color(0xffD26719)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          Positioned(
            top: getHeight(85),

            child: Center(
              child: Row(
                children: [
                  SizedBox(width: getWidth(18)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      ImagePath.backImage,
                      height: getHeight(50),
                      width: getWidth(50),
                    ),
                  ),
                  SizedBox(width: getWidth(100)),
                  Text(
                    "Privacy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getWidth(22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
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
              child: Padding(
                padding: EdgeInsets.only(
                  left: getWidth(16),
                  right: getWidth(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getHeight(10)),
                    buildCustomHeaderWidget(labelText: "Privacy Policy"),
                    SizedBox(height: getHeight(12),),
                    buildSubTitleTextWidget(subTitleText: "Your privacy is important to us. This policy outlines how we collect, use, and protect your information when using FixZone Service app."),
                    SizedBox(height: getHeight(24),),
                    buildCustomHeaderWidget(labelText: "How We Use Your Information"),
                    SizedBox(height: getHeight(12),),
                    buildSubTitleTextWidget(subTitleText: "1. We collect your details information to give you better service from our end. We believe, customer satisfaction our top priority."),
                    SizedBox(height: getHeight(12),),
                    buildSubTitleTextWidget(subTitleText: "2. When you make a payment, we collect payment details such as (Stripe, Master Card, Visa Card, Amex, Apple Pay) information securely."),
                    SizedBox(height: getHeight(12),),
                    buildSubTitleTextWidget(subTitleText: "3. We may collect your name, email, and phone  number for account creation and communication."),
                    SizedBox(height: getHeight(24),),
                    buildCustomHeaderWidget(labelText: "Contact Us"),
                    SizedBox(height: getHeight(12),),
                    buildSubTitleTextWidget(subTitleText: "If you have any questions about this Privacy Policy, please contact us at: \nEmail: info@fixzone.app"),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomText buildSubTitleTextWidget({required String subTitleText}) => CustomText(text: subTitleText,fontSize: getWidth(14),fontWeight: FontWeight.w400,color: AppColors.textGrey,);

  CustomText buildCustomHeaderWidget({required String labelText}) => CustomText(text: labelText,fontSize: getWidth(17),fontWeight: FontWeight.w700,);

 



}



