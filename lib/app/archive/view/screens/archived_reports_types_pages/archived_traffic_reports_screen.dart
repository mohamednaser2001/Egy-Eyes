
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:egy_eye_admin/app/archive/view/widgets/shimmer.dart';
import 'package:egy_eye_admin/app/archive/view_model/archive_bloc/archive_bloc.dart';
import 'package:egy_eye_admin/app/archive/view_model/archive_bloc/archive_states.dart';
import 'package:egy_eye_admin/helpers/widgets/empty_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:math';

import '../../widgets/archive_report_cart.dart';


class ArchivedTrafficReportsScreen extends StatelessWidget {
  ArchivedTrafficReportsScreen({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final widthCount = (MediaQuery.of(context).size.width ~/ 350).toInt();
    final minCount = 2;
    return BlocConsumer<ArchiveCubit, ArchiveStates>(
      listener: (context, state){},
      builder: (context, state){
        ArchiveCubit cubit= ArchiveCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.loadingReports,
            builder:(context)=> const ArchivedReportsShimmer(),
            fallback: (context) {
              return ConditionalBuilder(
                condition: cubit.trafficReports.isEmpty,
                builder:(context)=> const EmptyScreen(text: 'There are no traffic reports yet'),
                fallback: (context)=> GridView.count(
                  padding: EdgeInsets.all(10.w),
                  crossAxisCount:max(minCount, widthCount),
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 3.w,
                  childAspectRatio: 1/0.965,
                  children: List.generate(
                    cubit.trafficReports.length,
                        (index) => ArchivedReportCart(reportModel: cubit.trafficReports[index]),
                  ),
                ),
              );
            }
        );
      },
    );
  }
}
