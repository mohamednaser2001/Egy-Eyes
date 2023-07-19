

import 'package:egy_eye_admin/helpers/methods/get_width_and%20_height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget drawerItem({
  required Function function,
  required context,
  required String iconPath,
  required String text,
  bool isSelected =false,
})=>InkWell(
  onTap: (){
    function();
  },
  child: Container(
    height: getHeight(75, context),
    decoration: BoxDecoration(
      color: isSelected ? Colors.white : Colors.transparent,
      borderRadius: const BorderRadiusDirectional.only(bottomStart: Radius.circular(20)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //Icon(icon,size: 16.r,),
        SizedBox(width: 3,),
        SvgPicture.asset(iconPath, width: 20, color:isSelected ? Colors.black : Colors.white,),
        SizedBox(width: 5,),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            color:isSelected ? Colors.black : Colors.white,

            fontSize:isSelected ? 14.r : 12.r,
            fontWeight:isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    ),
  ),
);