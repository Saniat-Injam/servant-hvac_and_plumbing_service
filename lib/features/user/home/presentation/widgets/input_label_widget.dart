import 'package:flutter/material.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import '../../../../../core/common/widgets/custom_text.dart';


class InputLabel extends StatelessWidget {
  const InputLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getHeight(15)),
      child: CustomText(
        text: label,
        fontWeight: FontWeight.w600,
        fontSize: getWidth(16),

      ),
    );
  }
}
