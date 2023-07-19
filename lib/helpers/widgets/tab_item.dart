import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color_manger.dart';


class TabItem extends StatelessWidget {
  TabItem({
    Key? key,
    required this.number,
    required this.header,
    required this.isSelected,
    required this.function,
  }) : super(key: key);

  String header;
  int number;
  bool isSelected;
  Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        function();
      },
      child: Row(
        children: [
          Text(
            header,
            style: GoogleFonts.roboto(
              color: isSelected ? AppColors.blackColor : AppColors.descriptionColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 2.w,),
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1.5 ,color: isSelected ? AppColors.primaryColor : AppColors.descriptionColor,),
            ),
            child: Center(
              child: Text(
                '$number',
                style: GoogleFonts.roboto(
                  color: isSelected ? AppColors.blackColor : AppColors.descriptionColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
