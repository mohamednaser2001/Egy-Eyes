import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color_manger.dart';

Widget CustomTextFormField({
  required TextEditingController controller,
  required String ?validator(String ? str),
  IconData ? icon,
  IconData ? prefixIcon,
  String ? text,
  Color color =Colors.white,
  bool withBorder =true,
  bool isDescription =false,
  bool isPassword =false,
  bool isSecured =false,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  double radius=100,
  bool isEnabled=true,
  Color hintColor = Colors.grey,
  Color enabledBorderColor = AppColors.primaryColor,
  double height=53,
  required context,
  Function ? suffixIconPressed,
  double verticalPadding=0,
  double horizontalPadding=0,
  TextInputType inputType =TextInputType.text,
})=>Container(
  //height: height.h,
  alignment: Alignment.bottomCenter,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: BoxDecoration(
    color: color,
    border: Border.all(color:withBorder ? AppColors.greyBorderColor : color),
    borderRadius: BorderRadius.circular(radius),
  ),
  child: Center(
    child: TextFormField(
      enabled:isEnabled ? true: false,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      textAlignVertical: TextAlignVertical.bottom,
      validator: validator,
      onChanged: onChanged,
      maxLines:isDescription ? 7:1,
      obscureText:isSecured ? true: false,
      keyboardType: inputType,
      decoration: InputDecoration(
        isDense: true,
        hintText: text,
        hintStyle: GoogleFonts.poppins(
          color: hintColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: verticalPadding.h,horizontal: horizontalPadding.w),
        prefixIcon:prefixIcon==null ? null : Icon(prefixIcon),
        prefixIconConstraints: BoxConstraints(maxHeight: 30.h,minWidth: 32.w),
        suffixIcon:icon==null ? null : Icon(icon, color: AppColors.primaryColor,),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(radius)),
          borderSide:const BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(radius)),
          borderSide: BorderSide(color:withBorder ? enabledBorderColor : color),
        ),
      ),
    ),
  ),
);

