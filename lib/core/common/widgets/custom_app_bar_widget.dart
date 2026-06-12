import 'package:flutter/material.dart';

import '../../utils/constants/app_sizes.dart';
import '../../utils/constants/icon_path.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key, this.onTap,
  });
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getHeight(48),),
        Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
                onTap: onTap,
                child: Image.asset(IconPath.backArrowIcon,height: getHeight(44),width: getWidth(44),))),
        SizedBox(height: getHeight(112),),
      ],
    );
  }
}