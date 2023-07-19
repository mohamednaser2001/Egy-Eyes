

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../helpers/constants/color_manger.dart';
import '../../../../helpers/methods/navigation_method.dart';
import '../../../../helpers/widgets/custom_button.dart';
import '../../../../helpers/widgets/user_info_item.dart';
import '../../../map_test.dart';
import '../../../support/view_model/support_bloc/support_bloc.dart';
import '../../model/report_model.dart';
import '../screens/report_details_screen.dart';

class ReportCart extends StatelessWidget {
  ReportCart({Key? key, required this.reportModel}) : super(key: key);
  ReportModel reportModel;
  String? dateAndTime;
  Color getColor(){
    if(reportModel.status==null) return Color(0xffFF9494) ;
    else if(reportModel.status=='approval') return Color(0xffF2AC57);
    else return Color(0xff14A38B);
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        reportModel.dateTime!.millisecondsSinceEpoch);
    dateAndTime= '${dateTime.year}-${dateTime.month}-${dateTime.day} | '
        '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MyMap(height: double.infinity, width: double.infinity,
                    latLng: reportModel.latLong??GeoPoint(125.0, 125.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: getColor(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          reportModel.status??'Not Completed',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 9.sp,
                              color: Colors.white
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Icon(Icons.timelapse, color: Colors.white, size: 12.sp,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0,
                top: 10.0, bottom: 24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: UserInfoItem(title: '18'.tr(context),
                        body: reportModel.senderName??'Mohamed Nasser')),
                    Expanded(child: UserInfoItem(title: '19'.tr(context),
                        body: dateAndTime??'')),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: UserInfoItem(title: '20'.tr(context),
                        body: reportModel.authority??'Police')),
                    Expanded(
                      child: CustomButton(
                        text: '21'.tr(context),
                        icon: null,
                        color: AppColors.primaryColor,
                        width: 100,
                        height: 36,
                        fontSize: 12,
                        radius: 3,
                        function: (){
                          navigateTo(context, ReportDetailsScreen(report: reportModel,));
                          SupportCubit.get(context).getAllNearestSupports(
                              LatLng(reportModel.latLong!.latitude, reportModel.latLong!.longitude));
                        },
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
