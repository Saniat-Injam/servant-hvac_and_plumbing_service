import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/constants/app_sizes.dart';

class HomeProfileShimmer extends StatelessWidget {
  const HomeProfileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
          ),
          SizedBox(width: getWidth(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: getWidth(120),
                height: getWidth(20),
                color: Colors.white,
              ),
              SizedBox(height: getWidth(5)),
              Container(
                width: getWidth(180),
                height: getWidth(12),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}