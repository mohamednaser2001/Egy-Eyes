
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:egy_eye_admin/app/campaigns/view_model/campaigns_bloc/campaigns_bloc.dart';
import 'package:egy_eye_admin/app/campaigns/view_model/campaigns_bloc/campaigns_states.dart';
import 'package:egy_eye_admin/helpers/constants/color_manger.dart';
import 'package:egy_eye_admin/helpers/localization/app_localization.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_button.dart';
import 'package:egy_eye_admin/helpers/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../helpers/methods/get_width_and _height.dart';



class AddCampaignsScreen extends StatelessWidget {
  AddCampaignsScreen({Key? key,}) : super(key: key);
  var formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.0.w, top: 20.h),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '44'.tr(context),
                  style: GoogleFonts.roboto(
                    color: AppColors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(height: 1, color: AppColors.descriptionColor.withOpacity(0.3)),
                SizedBox(height: 40.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: BlocConsumer<CampaignsCubit, CampaignsStates>(
                          listener: (context, state){},
                          builder: (context, state){
                            CampaignsCubit cubit= CampaignsCubit.get(context);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  'Image',
                                  style: GoogleFonts.roboto(
                                    color: AppColors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                ConditionalBuilder(
                                  condition: cubit.imageFile!=null,
                                  builder:(context)=> Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      height: getHeight(280, context),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.descriptionColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: AppColors.primaryColor, width: 1.5.r),
                                      ),
                                      child: Image.memory(cubit.imageFile!, fit: BoxFit.cover,),
                                    ),
                                  fallback:(context)=> Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      height: getHeight(450, context),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: AppColors.primaryColor, width: 1.5.r),
                                      ),
                                      child: Icon(Icons.add, color: AppColors.primaryColor, size: 36.r,),
                                    ),
                                ),
                                SizedBox(height: 20.h,),
                                CustomButton(
                                    text: '43'.tr(context),
                                    radius: 6.r,
                                    height: 44.h,
                                    fontSize: 14.sp,
                                    elevation: 0.0,
                                    function: (){
                                      cubit.pickSupportImage();
                                    }),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                '39'.tr(context),
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff787878),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.0.h,),
                            CustomTextFormField(
                              controller: CampaignsCubit.get(context).titleController,
                              verticalPadding: 12.h,
                              enabledBorderColor: AppColors.greyBorderColor,
                              radius: 6,
                              isEnabled: false,
                              horizontalPadding: 2.w,
                              validator: (value){
                                if(value!.isEmpty) return 'Enter the title';
                                else return null;
                              },
                              context: context,
                            ),
                            SizedBox(height: 30.0.h,),
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
                              controller: CampaignsCubit.get(context).dateTimeController,
                              verticalPadding: 12.h,
                              enabledBorderColor: AppColors.greyBorderColor,
                              radius: 6,
                              isEnabled: false,
                              horizontalPadding: 2.w,
                              validator: (value){
                                if(value!.isEmpty) return 'Enter the date and time';
                                else return null;
                              },
                              context: context,
                            ),
                            SizedBox(height: 30.0.h,),

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
                              controller: CampaignsCubit.get(context).descriptionController,
                              verticalPadding: 12.h,
                              enabledBorderColor: AppColors.greyBorderColor,
                              radius: 6,
                              isEnabled: false,
                              isDescription: true,
                              horizontalPadding: 2.w,
                              validator: (value){
                                if(value!.isEmpty) return 'Enter the description';
                                else return null;
                              },
                              context: context,
                            ),


                            SizedBox(height: 50.0.h,),
                            CustomButton(
                                text: '40'.tr(context),
                                radius: 6.r,
                                height: 44.h,
                                fontSize: 14.sp,
                                elevation: 0.0,
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    if(CampaignsCubit.get(context).campaignImage==null){

                                    }else{

                                    }
                                  }else{

                                  }
                                }),
                            const SizedBox(height: 4.0,),
                            BlocConsumer<CampaignsCubit, CampaignsStates>(
                              listener: (context, state){},
                              builder:(context, state)=>CampaignsCubit.get(context).isCampaignSent? const LinearProgressIndicator(color: AppColors.primaryColor,): const SizedBox(),
                            ),
                            //SizedBox(height: 30.0.h,),
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
      ),
    );
  }

}
