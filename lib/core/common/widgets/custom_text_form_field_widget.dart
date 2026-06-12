import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizes.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.controller, required this.hintText, required this.prefixIconPath, this.readOnly, this.maxLines,
  });


  final String hintText;
  final String prefixIconPath;
  final TextEditingController? controller;
  final bool? readOnly;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: getWidth(1),color: AppColors.textFormFieldBorder)
      ),
      child: TextField(
        maxLines: maxLines??1,
        readOnly: readOnly??false,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.textGrey,fontSize: getWidth(14),fontWeight: FontWeight.w400),
          prefixIcon: Padding(
            padding:  EdgeInsets.only(left: getWidth(16)),
            child: Image.asset(prefixIconPath,height: getHeight(24),width: getWidth(24),),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: getWidth(28),vertical: getHeight(14)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}