import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../controllers/splash_controller.dart';
import '../widgets/custom_splash_logo_widgets.dart';




class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(76)),
          child: CustomSplashLogoWidget(),
        ),
      ),
    );
  }
}
