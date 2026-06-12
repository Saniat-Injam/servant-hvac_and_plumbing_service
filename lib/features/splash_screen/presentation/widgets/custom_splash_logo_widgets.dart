import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/constants/logo_path.dart';

class CustomSplashLogoWidget extends StatelessWidget {
  const CustomSplashLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: getHeight(160),),
        Image.asset(
          LogoPath.splashLogoIcon,
          height: getHeight(270),
          width: getWidth(275),
        ),
        SizedBox(height: getHeight(220),),

        Center(
          child: SpinKitCircle(
            color: AppColors.primary,
            size: getWidth(70),
          ),
        ),

      ],
    );
  }
}