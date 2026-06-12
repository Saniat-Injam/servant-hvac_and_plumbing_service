import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDateText extends StatelessWidget {
  final String? isoDate; // ISO 8601 String (e.g. 2025-08-25T03:31:19.286Z)
  final TextStyle? style;

  const FormattedDateText({
    super.key,
    required this.isoDate,
    this.style,
  });

  /// Add ordinal suffix (st, nd, rd, th)
  String _getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "${day}th";
    }
    switch (day % 10) {
      case 1:
        return "${day}st";
      case 2:
        return "${day}nd";
      case 3:
        return "${day}rd";
      default:
        return "${day}th";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isoDate == null || isoDate!.isEmpty) {
      return Text("N/A", style: style);
    }

    try {
      final parsedDate = DateTime.parse(isoDate!).toLocal(); // ✅ Convert to local time
      final day = _getDayWithSuffix(parsedDate.day);
      final month = DateFormat("MMMM").format(parsedDate); // August
      final year = parsedDate.year.toString();

      final formatted = "$day $month, $year"; // e.g. 25th August, 2025

      return Text(
        formatted,
        style: style ?? const TextStyle(fontSize: 14, color: Colors.black),
      );
    } catch (e) {
      return Text("Invalid date", style: style);
    }
  }
}
