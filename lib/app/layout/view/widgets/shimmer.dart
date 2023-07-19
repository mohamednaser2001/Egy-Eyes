import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/widgets/custom_shimmer.dart';

class AdminInfoShimmer extends StatelessWidget {
  const AdminInfoShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: SizedBox(
        width: 260,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[400],
            ),
            const SizedBox(height: 14,),
            CustomShimmer(width: 120, height: 12,),
            const SizedBox(height: 10,),
            CustomShimmer(width: 80, height: 13,),
            const SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.grey[400],
                ),
                const SizedBox(width: 3,),
                CustomShimmer(width: 60, height: 12,),
                const SizedBox(width: 4,),
                CustomShimmer(width: 120, height: 12,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.grey[400],
                ),
                const SizedBox(width: 3,),
                CustomShimmer(width: 60, height: 12,),
                const SizedBox(width: 4,),
                CustomShimmer(width: 130, height: 12,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.grey[400],
                ),
                const SizedBox(width: 3,),
                CustomShimmer(width: 60, height: 12,),
                const SizedBox(width: 4,),
                CustomShimmer(width: 120, height: 12,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.grey[400],
                ),
                const SizedBox(width: 3,),
                CustomShimmer(width: 60, height: 12,),
                const SizedBox(width: 4,),
                CustomShimmer(width: 110, height: 12,),
              ],
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );;
  }
}
