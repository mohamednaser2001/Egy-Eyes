
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:egy_eye_admin/helpers/widgets/empty_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:math';

import '../../../view_model/app_bloc/app_bloc.dart';
import '../../../view_model/app_bloc/app_states.dart';
import '../../widgets/report_cart.dart';
import '../../widgets/shimmer.dart';

class TrafficReportsScreen extends StatelessWidget {
  TrafficReportsScreen({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final widthCount = (MediaQuery.of(context).size.width ~/ 350).toInt();
    final minCount = 2;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit= AppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.loadingReports,
            builder:(context)=> const ReportsShimmer(),
            fallback: (context) {
              return ConditionalBuilder(
                condition: cubit.trafficReports.isEmpty,
                builder:(context)=> const EmptyScreen(text: 'There is no traffic reports yet'),
                fallback: (context)=> GridView.count(
                  padding: EdgeInsets.all(10.w),
                  crossAxisCount:max(minCount, widthCount),
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 3.w,
                  childAspectRatio: 1/0.965,
                  children: List.generate(
                    cubit.trafficReports.length,
                        (index) => ReportCart(reportModel: cubit.trafficReports[index]),
                  ),
                ),
              );
            }
        );
      },
    );
  }
}

