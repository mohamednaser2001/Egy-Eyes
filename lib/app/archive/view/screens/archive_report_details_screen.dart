
import 'package:egy_eye_admin/app/map_test.dart';
import 'package:egy_eye_admin/helpers/constants/color_manger.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:egy_eye_admin/helpers/methods/get_width_and%20_height.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_button.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helpers/static_data/govern_and_cities.dart';
import '../../../support/view_model/support_bloc/support_bloc.dart';
import '../../../support/view_model/support_bloc/support_states.dart';
import '../../model/archive_report_model.dart';


class ArchivedReportDetailsScreen extends StatelessWidget {
  ArchivedReportDetailsScreen({Key? key, required this.report}) : super(key: key);
  var descriptionController = TextEditingController();
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var senderNameController = TextEditingController();
  var senderIdController = TextEditingController();
  var reportIdController = TextEditingController();
  var authorityController = TextEditingController();
  var confirmationTimeController = TextEditingController();
  var adminIdController = TextEditingController();
  ArchiveReportModel report;
  Map? governorate;
  Map? city;

  void initControllers(){
    List<String> descParts= report.description!.split(',');
    for(String part in descParts){
      descriptionController.text+= '$part \n\n';
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(report.dateTime!.millisecondsSinceEpoch);
    dateController.text= '${dateTime.year}-${dateTime.month}-${dateTime.day} | ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
    senderIdController.text= report.senderId??'4568521457896548';
    senderNameController.text= report.senderName??'Ammar Zakaria';
    reportIdController.text= report.id??'';
    authorityController.text= report.authority??'';
    governorate= findPlaceById(id: report.governId??1, places: governorates, key: 'id');
    city= findPlaceById(id: report.cityId!, places: getCities(report.governId!), key: 'id');
    adminIdController.text= report.adminId??'30102151402548';
    DateTime confirmationTime = DateTime.fromMillisecondsSinceEpoch(report.confirmationTime!.millisecondsSinceEpoch);
    confirmationTimeController.text= '${confirmationTime.year}-${confirmationTime.month}-${confirmationTime.day} | ${confirmationTime.hour}:${confirmationTime.minute}:${confirmationTime.second}';
  }

  Map<String, dynamic>? findPlaceById(
      {required int id,
        required List<Map<String, dynamic>> places,
        required String key}) {
    for (int i = 0; i < places.length; i++) {
      if (places[i].containsKey(key) && places[i][key] == id) {
        return places[i];
      }
    }
    return null;
  }

  List<Map<String, dynamic>> getCities(int governId) => cities[governId];


  @override
  Widget build(BuildContext context) {
    final widthCount = (MediaQuery.of(context).size.width ~/ 400).toInt();
    final minCount = 2;
    Size size= MediaQuery.of(context).size;
    initControllers();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.0.w, top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '22'.tr(context),
                style: GoogleFonts.roboto(
                  color: AppColors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h,),
              Container(height: 1, color: AppColors.descriptionColor.withOpacity(0.3)),
              SizedBox(height: 40.h,),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width*0.47,
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
                                  color: AppColors.descriptionColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '${city!['name']} / ${governorate!['name']}',
                                style: GoogleFonts.roboto(
                                  color: AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Container(
                            height: getHeight(400, context),
                            decoration: BoxDecoration(
                                  color: AppColors.descriptionColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.descriptionColor, width: 1.5.r),
                                ),
                            child: MyMap(width: double.infinity, height: getHeight(400, context),latLng: report.latLong!),
                          ),
                          SizedBox(height: 30.h,),
                          // Text(
                          //   'Image',
                          //   style: GoogleFonts.roboto(
                          //     color: AppColors.black,
                          //     fontSize: 14.sp,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                          // SizedBox(height: 10.h,),
                          // if(report.photo!=null)
                          //   Container(
                          //     clipBehavior: Clip.antiAliasWithSaveLayer,
                          //     height: getHeight(280, context),
                          //     width: double.infinity,
                          //     decoration: BoxDecoration(
                          //       color: AppColors.descriptionColor,
                          //       borderRadius: BorderRadius.circular(10),
                          //       border: Border.all(color: AppColors.primaryColor, width: 1.5.r),
                          //     ),
                          //     child: Image.network(report.photo!, fit: BoxFit.cover,),
                          //   ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '25'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          CustomTextFormField(
                            controller: senderNameController,
                            verticalPadding: 12.h,
                            isEnabled: false,
                            enabledBorderColor: AppColors.greyBorderColor,
                            radius: 6,
                            horizontalPadding: 2.w,
                            validator: (value){},
                            context: context,
                          ),
                          SizedBox(height: 20.0.h,),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '26'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          CustomTextFormField(
                            controller: senderIdController,
                            verticalPadding: 12.h,
                            isEnabled: false,
                            enabledBorderColor: AppColors.greyBorderColor,
                            withBorder: true,
                            radius: 6,
                            horizontalPadding: 2.w,
                            validator: (value){},
                            context: context,
                          ),
                          //SizedBox(height: 20.0.h,),
                          SizedBox(height: 30.h,),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '27'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          BlocConsumer<SupportCubit, SupportStates>(
                            listener: (context, state){},
                            builder: (context, state){
                              SupportCubit cubit= SupportCubit.get(context);
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: CustomTextFormField(
                                      controller: cubit.nearestSupportController,
                                      verticalPadding: 12.h,
                                      enabledBorderColor: AppColors.greyBorderColor,
                                      radius: 6,
                                      isEnabled: false,
                                      horizontalPadding: 2.w,
                                      validator: (value){},
                                      context: context,
                                    ),
                                  ),
                                  SizedBox(width: 4.w,),
                                  Expanded(
                                    flex: 2,
                                    child: CustomButton(
                                        text: '28'.tr(context),
                                        radius: 6.r,
                                        height: 44.h,
                                        elevation: 0.0,
                                        fontSize: 13.sp,
                                        function: (){

                                        }),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.47,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0.w),
                      child: Column(
                        children: [

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '19'.tr(context),
                              style: GoogleFonts.roboto(
                                  fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          CustomTextFormField(
                            controller: dateController,
                            verticalPadding: 12.h,
                            enabledBorderColor: AppColors.greyBorderColor,
                            radius: 6,
                            isEnabled: false,
                            horizontalPadding: 2.w,
                            validator: (value){},
                            context: context,
                          ),
                          SizedBox(height: 20.0.h,),

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '29'.tr(context),
                              style: GoogleFonts.roboto(
                                  fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          CustomTextFormField(
                            controller: descriptionController,
                            verticalPadding: 12.h,
                            enabledBorderColor: AppColors.greyBorderColor,
                            radius: 6,
                            isEnabled: false,
                            isDescription: true,
                            horizontalPadding: 2.w,
                            validator: (value){},
                            context: context,
                          ),
                          SizedBox(height: 20.0.h,),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '20'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          CustomTextFormField(
                            controller: authorityController,
                            verticalPadding: 12.h,
                            enabledBorderColor: AppColors.greyBorderColor,
                            radius: 6,
                            isEnabled: false,
                            horizontalPadding: 2.w,
                            validator: (value){},
                            context: context,
                          ),
                          SizedBox(height: 20.0.h,),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '30'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          CustomTextFormField(
                            controller: reportIdController,
                            verticalPadding: 12.h,
                            enabledBorderColor: AppColors.greyBorderColor,
                            radius: 6,
                            isEnabled: false,
                            horizontalPadding: 2.w,
                            validator: (value){},
                            context: context,
                          ),
                          SizedBox(height: 20.0.h,),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '37'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          CustomTextFormField(
                            controller: adminIdController,
                            verticalPadding: 12.h,
                            enabledBorderColor: AppColors.greyBorderColor,
                            radius: 6,
                            isEnabled: false,
                            horizontalPadding: 2.w,
                            validator: (value){},
                            context: context,
                          ),
                          SizedBox(height: 20.0.h,),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '38'.tr(context),
                              style: GoogleFonts.roboto(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff787878),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0.h,),
                          CustomTextFormField(
                            controller: confirmationTimeController,
                            verticalPadding: 12.h,
                            enabledBorderColor: AppColors.greyBorderColor,
                            radius: 6,
                            isEnabled: false,
                            horizontalPadding: 2.w,
                            validator: (value){},
                            context: context,
                          ),
                          SizedBox(height: 30.0.h,),
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
    );
  }




}
