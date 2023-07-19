
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:egy_eye_admin/app/support/model/support_model.dart';
import 'package:egy_eye_admin/app/support/view/screens/edit_support_screen.dart';
import 'package:egy_eye_admin/app/support/view_model/support_bloc/support_bloc.dart';
import 'package:egy_eye_admin/app/support/view_model/support_bloc/support_states.dart';
import 'package:egy_eye_admin/helpers/constants/color_manger.dart';
import 'package:egy_eye_admin/helpers/methods/navigation_method.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_button.dart';
import 'package:egy_eye_admin/helpers/widgets/user_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import '../../../../../helpers/static_data/govern_and_cities.dart';
import '../../../../../helpers/widgets/empty_screen.dart';
import '../../widgets/support_cart.dart';


class AmbulanceSupportPage extends StatelessWidget {
  AmbulanceSupportPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final widthCount = (MediaQuery.of(context).size.width ~/ 350).toInt();

    final minCount = 2;

    return Builder(
      builder: (context) {
        SupportCubit.get(context).getAllSupports();
        return BlocConsumer<SupportCubit, SupportStates>(
          listener: (context, state){},
          builder: (context, state){
            SupportCubit cubit= SupportCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.ambulanceSupports.isEmpty,
              builder: (context)=> const EmptyScreen(text: 'There are no ambulance support yet'),
              fallback:(context)=> GridView.count(
                padding: EdgeInsets.all(10.w),
                crossAxisCount:max(minCount, widthCount),
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 3.w,
                childAspectRatio: 1/0.5,
                children: List.generate(
                  cubit.ambulanceSupports.length,
                      (index) => SupportCart(support: cubit.ambulanceSupports[index],),
                ),
              ),
            );
          },
        );
      }
    );
  }
}






