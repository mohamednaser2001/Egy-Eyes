
import 'package:egy_eye_admin/app/reports/view_model/app_bloc/app_bloc.dart';
import 'package:egy_eye_admin/helpers/constants/color_manger.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:egy_eye_admin/helpers/methods/get_width_and%20_height.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_button.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view_model/login_bloc/login_bloc.dart';
import '../view_model/login_bloc/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return BlocProvider(
      create: (context)=> LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state){},
          builder: (context, state) {
            LoginCubit cubit= LoginCubit.get(context);
            return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              width: size.width*0.4,
              height: size.height*0.6,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '10'.tr(context),
                      style: GoogleFonts.roboto(
                        fontSize: 28.0.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.customBlackColor,
                      ),
                    ),
                    Text(
                      '14'.tr(context),
                      style: GoogleFonts.roboto(
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.descriptionColor
                      ),
                    ),
                    const SizedBox(height: 40.0,),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '11'.tr(context),
                        style: TextStyle(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black
                        ),
                      ),
                    ),
                    SizedBox(height: 2.0.h,),
                    CustomTextFormField(
                      controller: cubit.emailController,
                      verticalPadding: 12.h,
                      enabledBorderColor: AppColors.tffBorderColor,
                      radius: 6,
                      horizontalPadding: 2.w,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter email address';
                        }
                        else {
                          return null;
                        }
                      },
                      context: context,
                    ),
                    SizedBox(height: 20.0.h,),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '12'.tr(context),
                        style: TextStyle(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black
                        ),
                      ),
                    ),
                    SizedBox(height: 2.0.h,),
                    CustomTextFormField(
                      controller: cubit.passwordController,
                      verticalPadding: 12.h,
                      enabledBorderColor: AppColors.tffBorderColor,
                      radius: 6,
                      horizontalPadding: 2.w,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter your password';
                        }
                        else {
                          return null;
                        }
                      },
                      context: context,
                    ),
                    SizedBox(height: 50.0.h,),
                    CustomButton(
                      text: '13'.tr(context),
                      radius: 8.r,
                      height: getHeight(67, context),
                      function: (){
                        if(formKey.currentState!.validate()){
                          cubit.login(context);
                        }
                      },
                    ),
                    if(state is SocialAppLoginLoadingState)
                      Column(
                        children: [
                          SizedBox(height: 6.0.h,),
                          const LinearProgressIndicator(color: AppColors.primaryColor,),
                        ],
                      ),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
          }),
    );
  }
}
