

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_eye_admin/app/support/model/support_model.dart';
import 'package:egy_eye_admin/app/support/view/screens/support_types_pages/police_support_page.dart';
import 'package:egy_eye_admin/app/support/view/screens/support_screen.dart';
import 'package:egy_eye_admin/helpers/static_data/govern_and_cities.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_support_states.dart';


class EditSupportCubit extends Cubit<EditSupportStates>{

  EditSupportCubit():super(InitialSupportState());

  static EditSupportCubit get(context) =>BlocProvider.of(context);


  void initControllers(SupportModel support){
    changeStatus(support.status??'Available') ;
    selectedSupportType= support.type;
    supportId= support.id;
    governorate= findPlaceById(id: int.parse(support.governId??'1'), places: governorates, key: 'id');
    city= findPlaceById(id: int.parse(support.cityId!), places: getCities(int.parse(support.governId!)), key: 'id');
    List<String> latAndLong= support.latLong!.split(',');
    changeLatLong(LatLng(double.parse(latAndLong.first), double.parse(latAndLong.last)));
    emit(InitialSupportState());
  }

  //
  // bool isAddSupport=false;
  // void toggleBetweenAddAndSupportData(){
  //   isAddSupport=!isAddSupport;
  //   emit(ToggleBetweenAddAndSupportDataState());
  // }
  //
  //
  // List<Widget> supportScreens=[
  //   SupportPage(),
  //   SupportPage(),
  //   SupportPage(),
  // ];
  //
  // int supportScreenTypeIndex=0;
  // void changeSupportScreenType(int index){
  //   supportScreenTypeIndex= index;
  //   emit(ChangeSupportScreenTypeState());
  // }


  String? supportId;
  void editSupport(){
    emit(EditSupportLoadingState());
    SupportModel model= SupportModel(
        type: selectedSupportType!,
        latLong: '${selectedLatLng!.longitude},${selectedLatLng!.longitude}',
        //photo: image,
        id: supportId,
        cityId: city!['id'].toString(),
        governId: governorate!['id'].toString(),
        status: selectedStatus,
    );
    //FirebaseFirestore.instance.collection('support').
    FirebaseFirestore.instance.collection('support').doc(supportId).set(model.toMap()).then((value) {
      emit(EditSupportSuccessState());
    }).catchError((error){
      emit(EditSupportErrorState());
    });
  }

  // void uploadSupportImage(){
  //   emit(UploadSupportImageLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref().child('supports/${Uri.file(supportImage!.path).pathSegments.last}')
  //       .putFile(supportImage!).then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       addSupport(value);
  //       emit(SupportImageUploadSuccess());
  //     }).catchError((error){
  //       emit(SupportImageUploadError());
  //     });
  //   }).catchError((error){
  //     emit(SupportImageUploadError());
  //   });
  // }

  // List<SupportModel> allSupports=[];
  // void getAllSupports(){
  //   allSupports=[];
  //   FirebaseFirestore.instance.collection('support')
  //       .snapshots()
  //       .listen((event) {
  //     allSupports=[];
  //     event.docs.forEach((element) {
  //       allSupports.add(SupportModel.fromJson(element.data()));
  //     });
  //     emit(GetSupportsSuccessState());
  //   });
  // }

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

  Map? governorate;
  Map? city;

  void changeGovernorate(Map value) {
    governorate = value;
    city = getCities(governorate!['id'])[0];
    emit(ChangeGovernorateState());
  }

  void changeCity(Map value) {
    city = value;
    emit(ChangeCityState());
  }

  List<Map<String, dynamic>> getCities(int governId) => cities[governId];


  List<String> status=['Available', 'Unavailable'];
  String selectedStatus= 'Available';
  void changeStatus(String value) {
    selectedStatus = value;
    emit(ChangeStatusState());
  }


  List<String> supportTypes=['Police', 'FireFighter', 'Ambulance',];
  String? selectedSupportType;
  void changeSupportType(String value) {
    selectedSupportType = value;
    emit(ChangeSupportTypeState());
  }


  late GoogleMapController googleMapController;
  List<Marker> markers=[];
  LatLng? selectedLatLng;
  void changeLatLong(LatLng latLng){
    markers.clear();
    selectedLatLng= latLng;
    markers.add(
      Marker(
        markerId: MarkerId('${latLng.latitude},${latLng.longitude}'),
        position: latLng,
      ),
    );
    emit(ChangeLatLongState());
  }

  // File? supportImage;
  // void pickSupportImage(context) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );
  //
  //   if (pickedFile != null) {
  //     supportImage = File(pickedFile.path);
  //     debugPrint(pickedFile.path);
  //     emit(SupportImagePickedSuccess());
  //   } else {}
  // }
}