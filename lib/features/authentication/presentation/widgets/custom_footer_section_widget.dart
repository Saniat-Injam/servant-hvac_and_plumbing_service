import 'package:flutter/material.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';

class CustomFooterSection extends StatelessWidget {
  const CustomFooterSection({
    super.key, required this.titleText, required this.buttonTitle, this.onTap,
  });
  final String titleText,buttonTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(titleText,style: TextStyle(color: AppColors.textGrey,fontSize: getWidth(16),fontWeight: FontWeight.w600),),
        GestureDetector(
          onTap: onTap,
          child: Text(
            buttonTitle,
            style: TextStyle(color: AppColors.primary,fontSize: getWidth(16),fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}