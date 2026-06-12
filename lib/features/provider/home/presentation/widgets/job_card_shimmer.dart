import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class JobCardShimmer extends StatelessWidget {
  const JobCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 0.2,
                color: const Color(0xffC8C8C8),
              ),
            ),
            child: Row(
              children: [
                // Left image shimmer
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Right content shimmer
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 16, width: 120, color: Colors.white),
                        const SizedBox(height: 8),
                        Container(height: 14, width: 180, color: Colors.white),
                        const SizedBox(height: 8),
                        Container(height: 14, width: 140, color: Colors.white),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(height: 14, width: 80, color: Colors.white),
                            const SizedBox(width: 10),
                            Container(height: 14, width: 60, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
