

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:egy_eye_admin/app/layout/view/screens/layout_screen.dart';
import 'package:egy_eye_admin/helpers/cache/cache_helper.dart';
import 'package:egy_eye_admin/helpers/methods/navigation_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../../helpers/constants/constants.dart';
import 'campaigns_states.dart';


class CampaignsCubit extends Cubit<CampaignsStates>{

  CampaignsCubit():super(InitialCampaignsState());

  static CampaignsCubit get(context) =>BlocProvider.of(context);

  var descriptionController = TextEditingController();
  var titleController = TextEditingController();
  var dateTimeController = TextEditingController();



  bool isCampaignSent= false;
  File? campaignImage;
  void pickSupportImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      campaignImage = File(pickedFile.path);
      debugPrint(pickedFile.path);
      emit(CampaignImagePickedSuccess());
    } else {}
  }


  Uint8List? imageFile;
  void pickSupportImageWeb() async {
    final pickedFile = await ImagePickerWeb.getImageAsBytes();

    if (pickedFile != null) {
      imageFile = pickedFile;
      emit(CampaignImagePickedSuccess());
    } else {}
  }
}