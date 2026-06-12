import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../controllers/sign_up/provider_sign_up_controller.dart';

class CategoryDropdown extends StatelessWidget {
  final String hintText;
  final String prefixIconPath;

  const CategoryDropdown({
    super.key,
    required this.hintText,
    required this.prefixIconPath,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderSignUpController>();

    return Obx(() {
      // Display selected category labels instead of keys
      final selectedLabels = controller.selectedCategories
          .map((key) => controller.categories[key] ?? key)
          .toList();

      return Container(
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: getWidth(1),
            color: Colors.grey.shade400,
          ),
        ),
        child: ExpansionTile(
          title: Text(
            selectedLabels.isEmpty ? hintText : selectedLabels.join(", "),
            style: TextStyle(
              color: selectedLabels.isEmpty
                  ? AppColors.textGrey
                  : Colors.black,
              fontSize: getWidth(15),
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: getWidth(5)),
            child: Image.asset(
              prefixIconPath,
              height: getHeight(24),
              width: getWidth(24),
            ),
          ),
          children: controller.categories.entries.map((entry) {
            final key = entry.key;
            final label = entry.value;
            return Obx(() {
              final isSelected =
              controller.selectedCategories.contains(key);
              return CheckboxListTile(
                value: isSelected,
                title: Text(label),
                onChanged: (_) => controller.toggleCategory(key),
              );
            });
          }).toList(),
        ),
      );
    });
  }
}
