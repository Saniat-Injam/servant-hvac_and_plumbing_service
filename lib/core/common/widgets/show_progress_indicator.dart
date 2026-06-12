import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/constants/app_colors.dart';



class ShowProgressIndicator extends StatelessWidget {
  const ShowProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: AppColors.primary,
        size: 50.0,
      ),
    );
  }
}