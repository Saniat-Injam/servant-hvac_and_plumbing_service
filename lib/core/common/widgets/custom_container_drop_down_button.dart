import 'package:flutter/material.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';

class CustomContainerDropDownButton<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const CustomContainerDropDownButton({
    super.key,
    required this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getWidth(16), ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF90E0D4), // Light Aqua Border
          width: getWidth(1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          hint: Text(
            hintText,
            style: TextStyle(fontSize: getWidth(15)),
          ),
          icon: const Icon(
            Icons.expand_more,
            color: Color(0xFF009688), // Aqua Arrow
          ),
          style:  TextStyle(
            color: Color(0xFF091440), // Text Color
            fontSize: getWidth(16),
          ),
          onChanged: onChanged,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}