

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/widgets/custom_shimmer.dart';

class ReportsShimmer extends StatelessWidget {
  const ReportsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthCount = (MediaQuery.of(context).size.width ~/ 350).toInt();
    const minCount = 2;
    return GridView.count(
      padding: EdgeInsets.all(10.w),
      crossAxisCount:max(minCount, widthCount),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 3.w,
      childAspectRatio: 1/0.965,
      children: List.generate(
        6,
            (index) => const ReportsCardShimmer(),
      ),
    );
  }
}
class ReportsCardShimmer extends StatelessWidget {
  const ReportsCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Column(
        children: [
          Expanded(
            child: CustomShimmer(
                width: double.infinity,
                height: double.infinity,
                radius: 20
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmer(
                            width: 100,
                            height: 14,
                            radius: 4,
                          ),
                          const SizedBox(height: 6,),
                          CustomShimmer(
                            width: 125,
                            height: 13,
                            radius: 4,
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmer(
                            width: 100,
                            height: 14,
                            radius: 4,
                          ),
                          const SizedBox(height: 6,),
                          CustomShimmer(
                            width: 125,
                            height: 13,
                            radius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmer(
                            width: 100,
                            height: 14,
                            radius: 4,
                          ),
                          const SizedBox(height: 6,),
                          CustomShimmer(
                            width: 125,
                            height: 13,
                            radius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: CustomShimmer(
                        width: 100,
                        height: 36,
                        radius: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}