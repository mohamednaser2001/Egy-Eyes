import 'package:egy_eye_admin/app/reports/view_model/app_bloc/app_bloc.dart';
import 'package:egy_eye_admin/app/reports/view_model/app_bloc/app_states.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:egy_eye_admin/helpers/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);
  var pageController= PageController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getAllReports();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '8'.tr(context),
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '9'.tr(context),
                  style: GoogleFonts.roboto(
                    color:const Color(0xff787878),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 20.h,),
                const Divider(),
                BlocConsumer<AppCubit, AppStates>(
                  listener: (context, state){},
                  builder: (context, state){
                    AppCubit cubit= AppCubit.get(context);
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0.h),
                        child: Row(
                          children: [
                            TabItem(
                              number: 25,
                              header: '4'.tr(context),
                              isSelected: cubit.reportScreenTypeIndex==0? true : false,
                              function: (){
                                cubit.changeReportsScreenType(0);
                                pageController.jumpToPage(0);
                              },
                            ),
                            SizedBox(width: 20,),
                            TabItem(
                              number: 2,
                              header: '5'.tr(context),
                              isSelected: cubit.reportScreenTypeIndex==1? true : false,
                              function: (){
                                cubit.changeReportsScreenType(1);
                                pageController.jumpToPage(1);
                              },
                            ),
                            SizedBox(width: 20,),
                            TabItem(
                              number: 8,
                              header: '6'.tr(context),
                              isSelected: cubit.reportScreenTypeIndex==2? true : false,
                              function: (){
                                cubit.changeReportsScreenType(2);
                                pageController.jumpToPage(2);
                              },
                            ),
                            SizedBox(width: 20,),
                            TabItem(
                              number: 12,
                              header: '7'.tr(context),
                              isSelected: cubit.reportScreenTypeIndex==3? true : false,
                              function: (){
                                cubit.changeReportsScreenType(3);
                                pageController.jumpToPage(3);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                BlocConsumer<AppCubit, AppStates>(
                  listener: (context, state){},
                  builder: (context, state){
                    return Expanded(
                      child: PageView.builder(
                        itemCount: AppCubit.get(context).reportsScreens.length,
                        controller: pageController,
                        itemBuilder: (context, index)=> AppCubit.get(context).reportsScreens[index],
                        onPageChanged: (index){
                          AppCubit.get(context).changeReportsScreenType(index);
                        },
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        );
      }
    );
  }
}




