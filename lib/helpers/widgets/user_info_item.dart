import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoItem extends StatelessWidget {
  UserInfoItem({Key? key, required this.title, required this.body}) : super(key: key);
  String title;
  String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            color:const Color(0xff232323),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          body,
          style: GoogleFonts.roboto(
            color:const Color(0xff626262),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}