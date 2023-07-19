

import 'package:flutter/material.dart';

class CustomShimmer extends StatelessWidget {
  CustomShimmer({Key? key, required this.height, required this.width, this.radius=0.0, this.color}) : super(key: key);
  double height;
  double width;
  double radius;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color??Colors.grey[400],
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}