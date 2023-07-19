


import 'dart:js_interop';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:egy_eye_admin/app/layout/view_model/locale_cubit/locale_cubit.dart';
import 'package:egy_eye_admin/app/reports/view_model/app_bloc/app_bloc.dart';
import 'package:egy_eye_admin/app/reports/view_model/app_bloc/app_states.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_text_button.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../helpers/constants/color_manger.dart';
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/methods/get_width_and _height.dart';
import '../../../../helpers/widgets/custom_shimmer.dart';
import '../../view_model/locale_cubit/locale_states.dart';
import '../widgets/admin_info_row.dart';
import '../widgets/drawer_item.dart';
import '../widgets/shimmer.dart';



class LayoutScreen extends StatelessWidget {
  LayoutScreen({Key? key}) : super(key: key);
  TextEditingController searchController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 8.0, top: 8.0, bottom: 8.0),
              child: Container(
                width: getWidth(63, context),
                height: getWidth(63, context),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset('$imagesPath/icons/logo.svg'),
              ),
            ),

            title: Text(
              '1'.tr(context),
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                color: Colors.black,
              ),
            ),

            actions: [


              BlocConsumer<LocaleCubit, ChangeLocaleState>(
                listener: (context, state){},
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 30.h,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            width: 1.5,
                            color: AppColors.descriptionColor.withOpacity(0.1),
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: context.read<LocaleCubit>().isArabic?'العربية': 'English',
                          borderRadius: BorderRadius.circular(10.r),
                          isExpanded: true,
                          hint: Text(
                            '35'.tr(context),
                            style: GoogleFonts.roboto(
                              color: AppColors.descriptionColor.withOpacity(0.8),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          iconSize: 24,
                          elevation: 16,
                          style: GoogleFonts.roboto(
                            color: AppColors.descriptionColor.withOpacity(0.7),
                            fontSize: 10.sp,
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (value) {
                            if(value!='English')
                              context.read<LocaleCubit>().changeLanguage('ar');
                            else
                              context.read<LocaleCubit>().changeLanguage('en');
                            },
                          items: context.read<LocaleCubit>().languages.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(width: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: ClipOval( child: Image.asset(
                      '$imagesPath/images/user.png',fit: BoxFit.cover,)),
                  ),
                  onTap: (){
                    cubit.getAdminData();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            alignment: AlignmentDirectional.topEnd,
                            content: ConditionalBuilder(
                                condition: cubit.adminModel.isNull,
                                builder: (context)=> AdminInfoShimmer(),
                                fallback: (context)=> SizedBox(
                                  width: 260,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        child: ClipOval( child: Image.asset(
                                          '$imagesPath/images/user.png',fit: BoxFit.cover,)),
                                      ),
                                      Text(
                                        cubit.adminModel!.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          color:Colors.black,
                                          fontSize:16.sp,
                                          fontWeight:FontWeight.w600,
                                        ),
                                      ),

                                      SizedBox(height: 10.h),
                                      RowOfAdminInfo(title: 'Phone',
                                          value: cubit.adminModel!.phone!, icon: Icons.phone),
                                      RowOfAdminInfo(title: 'Email',
                                          value: cubit.adminModel!.email!, icon: Icons.email),
                                      RowOfAdminInfo(title: 'National Id',
                                          value: cubit.adminModel!.nationalId!, icon: Icons.credit_card),
                                      RowOfAdminInfo(title: 'Address',
                                          value: cubit.adminModel!.address!, icon: Icons.location_on),

                                      const SizedBox(width: 20,),
                                      Align(
                                        alignment: AlignmentDirectional.centerStart,
                                        child: CustomTextButton(
                                          text: 'Sign out',
                                          fontSize: 12.sp,
                                          textColor: AppColors.primaryColor,
                                          icon: const Icon(Icons.logout, size: 17,),
                                          onPressed: (){
                                            cubit.logout(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ),
                          );
                        },
                    );
                  },
                ),
              ),
            ],
          ),

          body: Row(
            children: [
              Container(
                width: getWidth(200, context),
                //color: AppColors.primaryColor,
                padding: EdgeInsetsDirectional.only(start: 10.w, top: 80.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    drawerItem(
                        context: context,
                        text: '2'.tr(context),
                        iconPath: 'assets/icons/reports.svg',
                        isSelected:cubit.screenIndex==0 ? true: false ,
                        function: (){
                          cubit.changeDrawerIndex(0);
                        }
                    ),
                    SizedBox(height: 10.sp,),
                    drawerItem(
                        context: context,
                        text: '3'.tr(context),
                        iconPath: 'assets/icons/support.svg',
                        isSelected:cubit.screenIndex==1 ? true: false ,
                        function: (){
                          cubit.changeDrawerIndex(1);
                        }
                    ),
                    SizedBox(height: 10.sp,),
                    drawerItem(
                        context: context,
                        text: '41'.tr(context),
                        iconPath: 'assets/icons/notes.svg',
                        isSelected:cubit.screenIndex==2 ? true: false ,
                        function: (){
                          cubit.changeDrawerIndex(2);
                        }
                    ),
                    SizedBox(height: 10.sp,),
                    drawerItem(
                        context: context,
                        text: '42'.tr(context),
                        iconPath: 'assets/icons/share.svg',
                        isSelected:cubit.screenIndex==3 ? true: false ,
                        function: (){
                          cubit.changeDrawerIndex(3);
                        }
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration:const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(80)
                        )
                      ),
                      child: cubit.screens[cubit.screenIndex]),
              ),
            ],
          ),
        );
      },
    );
  }
}










