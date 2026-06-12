import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizes.dart';

Future<void> showProgressIndicator() async {
  await Future.delayed(Duration(milliseconds: 50)); // smoother render
  if (!(Get.isDialogOpen ?? false)) {
    Get.dialog(
      Center(
        child: SpinKitFadingCircle(
          color: AppColors.primary,
          size: getWidth(50),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: false,
    );
  }
}

Future<void> hideProgressIndicator() async {
  await Future.delayed(Duration(milliseconds: 100));
  if (Get.isDialogOpen ?? false) {
    try {
      Get.back();
    } catch (e) {
      // Already closed or error while closing
    }
  }
}

