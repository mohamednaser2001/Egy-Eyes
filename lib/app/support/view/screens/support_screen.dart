
import 'package:egy_eye_admin/app/support/view_model/support_bloc/support_bloc.dart';
import 'package:egy_eye_admin/app/support/view_model/support_bloc/support_states.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:egy_eye_admin/helpers/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SupportsDataPages extends StatelessWidget {
  SupportsDataPages({Key? key}) : super(key: key);
  var pageController= PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocConsumer<SupportCubit, SupportStates>(
          listener: (context, state){},
          builder: (context, state){
            SupportCubit cubit= SupportCubit.get(context);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TabItem(
                      number: 25,
                      header: '4'.tr(context),
                      isSelected: cubit.supportScreenTypeIndex==0? true : false,
                      function: (){
                        cubit.changeSupportScreenType(0);
                        pageController.jumpToPage(0);
                      },
                    ),
                    SizedBox(width: 16,),
                    TabItem(
                      number: 2,
                      header: '6'.tr(context),
                      isSelected: cubit.supportScreenTypeIndex==1? true : false,
                      function: (){
                        cubit.changeSupportScreenType(1);
                        pageController.jumpToPage(1);
                      },
                    ),
                    SizedBox(width: 16,),
                    TabItem(
                      number: 8,
                      header: '16'.tr(context),
                      isSelected: cubit.supportScreenTypeIndex==2? true : false,
                      function: (){
                        cubit.changeSupportScreenType(2);
                        pageController.jumpToPage(2);
                      },
                    ),


                  ],
                ),
              ),
            );
          },
        ),

        Expanded(
          child: PageView.builder(
            itemCount: SupportCubit.get(context).supportScreens.length,
            controller: pageController,
            itemBuilder: (context, index)=> SupportCubit.get(context).supportScreens[index],
            onPageChanged: (index){
              SupportCubit.get(context).changeSupportScreenType(index);
            },
          ),
        ),
      ],
    );
  }
}

