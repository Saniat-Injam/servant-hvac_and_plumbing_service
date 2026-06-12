import 'package:flutter/material.dart';

import '../../utils/constants/app_sizes.dart';

class CustomContainerDropDownButton1<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const CustomContainerDropDownButton1({
    super.key,
    required this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getHeight(4) ),
      decoration: BoxDecoration(
        color: Color(0xffF9F9FB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xffF9F9FB), // Light Aqua Border
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