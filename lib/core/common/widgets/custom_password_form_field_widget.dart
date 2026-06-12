import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizes.dart';
import '../../utils/constants/icon_path.dart';

class CustomPasswordFormFieldWidget extends StatelessWidget {
  const CustomPasswordFormFieldWidget({
    super.key,
    required this.hintText, this.controller, required this.obscureText, this.onPressed,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Function()? onPressed;


  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: getWidth(1),color: AppColors.textFormFieldBorder)
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.textGrey,fontSize: getWidth(15)),
          prefixIcon: Padding(
            padding:  EdgeInsets.only(left: getWidth(16)),
            child: Image.asset(IconPath.passwordIcon,height: getHeight(24),width: getWidth(24),),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: getWidth(8)),
            child: IconButton(
              icon: Icon(obscureText
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: onPressed,
            ),
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