import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';

class CustomOTPTextFormFieldWidget extends StatelessWidget {
  const CustomOTPTextFormFieldWidget({
    super.key,
    required this.controller,
    this.pinCount,
    this.inactiveFillColor,
    this.activeFillColor,
    this.fontSize,
    this.borderRadius,
  });

  final TextEditingController? controller;
  final int? pinCount;
  final Color? inactiveFillColor,activeFillColor;
  final double? fontSize;
  final double? borderRadius;


  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,

      appContext: context,
      length: pinCount??6,
      onChanged: (value) {},

      pinTheme: PinTheme(
        activeFillColor: activeFillColor,
        selectedFillColor: Colors.white,
        shape: PinCodeFieldShape.box,
        borderWidth: getWidth(1),
        borderRadius: BorderRadius.circular(borderRadius??8.0),
        fieldHeight: getHeight(55),
        fieldWidth: getWidth(55),
        inactiveFillColor:inactiveFillColor,
        inactiveColor: Color(0xFFE0E0E0),
      ),
      cursorColor: Color(0xFF007AFF),
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}