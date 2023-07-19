
import 'package:egy_eye_admin/app/support/view/screens/add_support_screen.dart';
import 'package:egy_eye_admin/app/support/view/screens/support_screen.dart';
import 'package:egy_eye_admin/app/support/view_model/support_bloc/support_bloc.dart';
import 'package:egy_eye_admin/app/support/view_model/support_bloc/support_states.dart';
import 'package:egy_eye_admin/helpers/constants/color_manger.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_text_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<SupportCubit, SupportStates>(
              listener: (context, state){},
              builder: (context, state)=> Row(
                children: [

                  Text(
                    SupportCubit.get(context).isAddSupport? 'Add Support' : 'Support' ,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  CustomTextButton(
                    text: SupportCubit.get(context).isAddSupport? 'Return' : '15'.tr(context),
                    fontSize: 15.sp,
                    textColor: AppColors.primaryColor,
                    icon: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Icon(
                        SupportCubit.get(context).isAddSupport ? Icons.arrow_forward_rounded : Icons.add,
                        color: Colors.white,),
                    ),
                    onPressed: (){
                      SupportCubit.get(context).toggleBetweenAddAndSupportData();
                      //SupportCubit.get(context).addSupport();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h,),
            const Divider(),
            Expanded(
              child: BlocConsumer<SupportCubit, SupportStates>(
                listener: (context, state){},
                builder: (context, state)=> SupportCubit.get(context).isAddSupport==false? SupportsDataPages() : AddSupportScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}