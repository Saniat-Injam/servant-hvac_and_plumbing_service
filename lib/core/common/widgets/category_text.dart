import 'package:flutter/material.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';

class CategoryText extends StatelessWidget {
  final String? categoryKey;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const CategoryText({
    super.key,
    required this.categoryKey,
    this.labelStyle,
    this.valueStyle,
  });

  // Category Map
  static const Map<String, String> categories = {
    "AC_REPAIR": 'AC Repair',
    "PLUMBING": 'Plumbing',
    "CLEANING": 'Cleaning',
    "ELECTRICIAN": 'Electrical',
  };

  @override
  Widget build(BuildContext context) {
    final categoryName = categories[categoryKey] ?? "Unknown";

    return Text.rich(
      TextSpan(
        text: 'Category: ',
        style: labelStyle ??
            TextStyle(
              color: Colors.grey,
              fontSize:getWidth(14),
            ),
        children: [
          TextSpan(
            text: categoryName,
            style: valueStyle ??
                TextStyle(
                  color: Colors.black,
                  fontSize: getWidth(14),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
