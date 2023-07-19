import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:egy_eye_admin/app/map_test.dart';
import 'package:egy_eye_admin/app/reports/view_model/app_bloc/app_bloc.dart';
import 'package:egy_eye_admin/app/support/model/support_model.dart';
import 'package:egy_eye_admin/app/support/view_model/edit_support_cubit/edit_support_states.dart';
import 'package:egy_eye_admin/app/support/view_model/support_bloc/support_bloc.dart';
import 'package:egy_eye_admin/app/support/view_model/support_bloc/support_states.dart';
import 'package:egy_eye_admin/helpers/constants/color_manger.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:egy_eye_admin/helpers/methods/get_width_and%20_height.dart';
import 'package:egy_eye_admin/helpers/static_data/govern_and_cities.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_button.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/widgets/custom_text_button.dart';
import '../../view_model/edit_support_cubit/edit_support_bloc.dart';

class EditSupportScreen extends StatelessWidget {
  EditSupportScreen({Key? key, required this.supportModel}) : super(key: key);

  SupportModel supportModel;

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;

    return BlocProvider(
      create: (context)=> EditSupportCubit()..initControllers(supportModel),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0, top: 8.0, bottom: 8.0),
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: ClipOval( child: Image.asset('$imagesPath/images/user.png',fit: BoxFit.cover,)),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded)
                    ),
                    Text(
                      'Edit Support Data' ,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h,),
                const Divider(),
                SizedBox(height: 10.h,),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width*0.45,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${'23'.tr(context)} - ',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff787878),
                                  ),
                                ),

                                Text(
                                  '24'.tr(context),
                                  style: GoogleFonts.roboto(
                                    color: AppColors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h,),

                            BlocConsumer<EditSupportCubit, EditSupportStates>(
                              listener: (context, state){},
                              builder: (context, state){
                                EditSupportCubit cubit= EditSupportCubit.get(context);
                                return Container(
                                  width: double.infinity,
                                  height: size.height*0.7,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: GoogleMap(
                                    onMapCreated: (controller){
                                      cubit.googleMapController= controller;
                                    },
                                    buildingsEnabled: true,
                                    onTap:(LatLng latLng){
                                      cubit.changeLatLong(latLng);
                                    },
                                    initialCameraPosition: CameraPosition(
                                      target: cubit.selectedLatLng?? const LatLng(30.123225, 31.375692),
                                      zoom: 13,
                                    ),
                                    markers: Set<Marker>.of(cubit.markers),
                                    mapType: MapType.normal,
                                  ),
                                );
                              },
                            ),
                            // SizedBox(height: 30.h,),
                            // Text(
                            //   'Image',
                            //   style: GoogleFonts.roboto(
                            //     fontSize: 14.0.sp,
                            //     fontWeight: FontWeight.w600,
                            //     color: const Color(0xff787878),
                            //   ),
                            // ),

                            // SizedBox(height: 10.h,),
                            // BlocConsumer<SupportCubit, EditSupportStates>(
                            //   listener: (context, state){},
                            //   builder: (context, state) {
                            //     SupportCubit cubit= SupportCubit.get(context);
                            //     return ConditionalBuilder(
                            //     condition: cubit.supportImage!=null,
                            //     builder: (context)=> Container(
                            //       height: getHeight(280, context),
                            //       width: double.infinity,
                            //       clipBehavior: Clip.antiAliasWithSaveLayer,
                            //       decoration: BoxDecoration(
                            //         border: Border.all(color: AppColors.primaryColor),
                            //         borderRadius: BorderRadius.circular(12.r),
                            //       ),
                            //       child: Image.network(cubit.supportImage!.path, fit: BoxFit.cover,),
                            //     ),
                            //     fallback:(context)=> InkWell(
                            //       onTap: (){
                            //         SupportCubit.get(context).pickSupportImage(context);
                            //       },
                            //       child: Container(
                            //         height: getHeight(280, context),
                            //         width: double.infinity,
                            //         decoration: BoxDecoration(
                            //           border: Border.all(color: AppColors.primaryColor),
                            //           borderRadius: BorderRadius.circular(12.r),
                            //         ),
                            //         child: Center(
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             children: [
                            //               Icon(Icons.add, color: AppColors.primaryColor,),
                            //               Text(
                            //                 'Add Image',
                            //                 style: GoogleFonts.roboto(
                            //                   color: AppColors.primaryColor,
                            //                   fontSize: 12.sp,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width*0.45,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                '32'.tr(context),
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff787878),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.0.h,),
                            BlocConsumer<EditSupportCubit, EditSupportStates>(
                              listener: (context, state){},
                              builder: (context, state) {
                                EditSupportCubit cubit= EditSupportCubit.get(context);
                                return Container(
                                  height: 35.h,
                                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        width: 1.5,
                                        color: AppColors.descriptionColor.withOpacity(0.1),
                                      )),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: cubit.selectedSupportType,
                                      borderRadius: BorderRadius.circular(10.r),
                                      isExpanded: true,
                                      hint: Text(
                                        '32'.tr(context),
                                        style: GoogleFonts.roboto(
                                          color: AppColors.descriptionColor.withOpacity(0.8),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      icon:
                                      const Icon(Icons.arrow_drop_down_rounded),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: GoogleFonts.roboto(
                                        color: AppColors.descriptionColor.withOpacity(0.7),
                                        fontSize: 10.sp,
                                        height: 1.3,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      onChanged: (value) {
                                        cubit.changeSupportType(value!);
                                      },
                                      items: cubit.supportTypes.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.0.h,),

                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                '33'.tr(context),
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff787878),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.0.h,),
                            BlocConsumer<EditSupportCubit, EditSupportStates>(
                              listener: (context, state){},
                              builder: (context, state) {
                                EditSupportCubit cubit= EditSupportCubit.get(context);
                                return Container(
                                  height: 35.h,
                                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        width: 1.5,
                                        color: AppColors.descriptionColor.withOpacity(0.1),
                                      )),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Map>(
                                      value: cubit.governorate,
                                      borderRadius: BorderRadius.circular(10.r),
                                      isExpanded: true,
                                      hint: Text(
                                        '33'.tr(context),
                                        style: GoogleFonts.roboto(
                                          color: AppColors.descriptionColor.withOpacity(0.8),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      icon:
                                      const Icon(Icons.arrow_drop_down_rounded),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: GoogleFonts.roboto(
                                        color: AppColors.descriptionColor.withOpacity(0.7),
                                        fontSize: 10.sp,
                                        height: 1.3,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      onChanged: (value) {
                                        cubit.changeGovernorate(value!);
                                      },
                                      items: governorates.map((Map value) {
                                        return DropdownMenuItem<Map>(
                                          value: value,
                                          child: Text(value['name']),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: 20.0.h,),

                            Text(
                              '34'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                            SizedBox(height: 2.0.h,),
                            BlocConsumer<EditSupportCubit, EditSupportStates>(
                              listener: (context, state){},
                              builder: (context, state) {
                                EditSupportCubit cubit= EditSupportCubit.get(context);
                                return Container(
                                  height: 35.h,
                                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        width: 1.5,
                                        color: AppColors.descriptionColor.withOpacity(0.1),
                                      )),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Map>(
                                      value: cubit.city,
                                      borderRadius: BorderRadius.circular(10.r),
                                      isExpanded: true,
                                      hint: Text(
                                        '34'.tr(context),
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
                                        cubit.changeCity(value!);
                                      },
                                      items: cubit.getCities(cubit.governorate==null? 100 : cubit.governorate!['id']).map((Map value) {
                                        return DropdownMenuItem<Map>(
                                          value: value,
                                          child: Text(value['name']),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: 20.0.h,),
                            Text(
                              '35'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                            SizedBox(height: 2.0.h,),
                            BlocConsumer<EditSupportCubit, EditSupportStates>(
                              listener: (context, state){},
                              builder: (context, state) {
                                EditSupportCubit cubit= EditSupportCubit.get(context);
                                return Container(
                                  height: 35.h,
                                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        width: 1.5,
                                        color: AppColors.descriptionColor.withOpacity(0.1),
                                      )),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: cubit.selectedStatus,
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
                                        cubit.changeStatus(value!);
                                      },
                                      items: cubit.status.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 30.0.h,),
                            BlocConsumer<EditSupportCubit, EditSupportStates>(
                              listener: (context, state){},
                              builder: (context, state)=> Column(
                                children: [
                                  CustomButton(
                                      text: '36'.tr(context),
                                      radius: 6.r,
                                      height: 44.h,
                                      fontSize: 14.sp,
                                      elevation: 0.0,
                                      function:state is EditSupportLoadingState ? (){} : (){
                                        if(EditSupportCubit.get(context).selectedLatLng==null){
                                          print('latlong null');
                                          /// todo
                                        }else if(EditSupportCubit.get(context).selectedSupportType==null){
                                          print('type null');
                                        }else if(EditSupportCubit.get(context).governorate==null){
                                          print('governorate null');
                                        }else if(EditSupportCubit.get(context).city==null){
                                          print('city null');
                                        }else{
                                          EditSupportCubit.get(context).editSupport();
                                        }
                                      }),
                                  if(state is EditSupportLoadingState)
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: LinearProgressIndicator(color: AppColors.primaryColor,),
                                    ),
                                ],
                              ) ,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
