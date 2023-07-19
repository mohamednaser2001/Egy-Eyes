
import 'package:egy_eye_admin/app/support/model/support_model.dart';
import 'package:egy_eye_admin/app/support/view/screens/edit_support_screen.dart';
import 'package:egy_eye_admin/helpers/constants/color_manger.dart';
import 'package:egy_eye_admin/helpers/methods/navigation_method.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_button.dart';
import 'package:egy_eye_admin/helpers/widgets/user_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helpers/static_data/govern_and_cities.dart';


class SupportCart extends StatelessWidget {
  SupportCart({Key? key, required this.support}) : super(key: key);
  SupportModel support;
  Map? governorate;
  Map? city;

  Color getColor(){
    if(support.status=='Available') return Color(0xff14A38B);
    else return Color(0xffFF9494);
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
    governorate= findPlaceById(id: int.parse(support.governId!)??1, places: governorates, key: 'id');
    city= findPlaceById(id: int.parse(support.cityId!), places: getCities(int.parse(support.governId!)), key: 'id');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserInfoItem(title: 'Type', body:support.type!),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: getColor(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            support.status!,
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
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserInfoItem(title: 'Place', body: '${city!['name']} / ${governorate!['name']}'),
                    CustomButton(
                      text: 'Edit',
                      icon: null,
                      color: AppColors.primaryColor,
                      width: 100,
                      height: 36.h,
                      fontSize: 12.sp,
                      radius: 3,
                      function: (){
                        navigateTo(context, EditSupportScreen(supportModel: support));
                      },
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
