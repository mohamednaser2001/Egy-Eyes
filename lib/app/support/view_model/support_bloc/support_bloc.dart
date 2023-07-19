

import 'dart:io';
import 'dart:math' as Math;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_eye_admin/app/reports/model/report_model.dart';
import 'package:egy_eye_admin/app/support/model/support_model.dart';
import 'package:egy_eye_admin/app/support/view/screens/support_types_pages/police_support_page.dart';
import 'package:egy_eye_admin/helpers/constants/constants.dart';
import 'package:egy_eye_admin/helpers/static_data/govern_and_cities.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../view/screens/support_types_pages/ambulance_support_page.dart';
import '../../view/screens/support_types_pages/firefighter_support_page.dart';
import 'support_states.dart';


class SupportCubit extends Cubit<SupportStates>{

  SupportCubit():super(InitialSupportState());

  static SupportCubit get(context) =>BlocProvider.of(context);




  bool isAddSupport=false;
  void toggleBetweenAddAndSupportData(){
    isAddSupport=!isAddSupport;
    emit(ToggleBetweenAddAndSupportDataState());
  }


  List<Widget> supportScreens=[
    AmbulanceSupportPage(),
    FireFighterSupportPage(),
    PoliceSupportPage(),
  ];

  int supportScreenTypeIndex=0;
  void changeSupportScreenType(int index){
    supportScreenTypeIndex= index;
    emit(ChangeSupportScreenTypeState());
  }



  void addSupport(){
    CollectionReference collection = FirebaseFirestore.instance.collection('trips');
    DocumentReference newDocRef = collection.doc();
    emit(AddSupportLoadingState());
    SupportModel model= SupportModel(
        type: selectedSupportType!,
        latLong: '${selectedLatLng!.longitude},${selectedLatLng!.longitude}',
        //photo: image,
        id: newDocRef.id,
        cityId: city!['id'].toString(),
        governId: governorate!['id'].toString(),
        status: selectedStatus,
    );

    FirebaseFirestore.instance.collection('support').doc(newDocRef.id).set(model.toMap()).then((value) {
      emit(AddSupportSuccessState());
    }).catchError((error){

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

  List<SupportModel> ambulanceSupports=[];
  List<SupportModel> policeSupports=[];
  List<SupportModel> firFighterSupports=[];
  void getAllSupports(){
    FirebaseFirestore.instance.collection('support')
        .snapshots()
        .listen((event) {
      clearLists();
      event.docs.forEach((element) {
        SupportModel support= SupportModel.fromJson(element.data());
        if(support.type=='Police'){
          policeSupports.add(support);
        }else if(support.type=='FireFighter'){
          firFighterSupports.add(support);
        } else {
          ambulanceSupports.add(support);
        }
      });
      emit(GetSupportsSuccessState());
    });
  }

  void clearLists(){
    policeSupports.clear();
    firFighterSupports.clear();
    ambulanceSupports.clear();
  }

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






  var nearestSupportController = TextEditingController();
  List<SupportModel> allSupports=[];
  SupportModel? nearestSupport;
  void getAllNearestSupports(LatLng latLng) {
    FirebaseFirestore.instance.collection('support')
        .get().then((value) {
          value.docs.forEach((element) {
            allSupports.add(SupportModel.fromJson(element.data()));
          });
          nearestSupport= findClosestSupport(latLng, allSupports);
          nearestSupportController.text= nearestSupport!.id!;
          // markers.add(Marker(
          //   markerId: MarkerId('${latLng.latitude},${latLng.longitude}'),
          //   position: latLng,
          // ));todo add marker to report map
          emit(GetAllSupportsSuccessState());
    }).catchError((error) {
      emit(GetAllSupportsErrorState());
    });
  }


  double distance(LatLng from, LatLng to) {
    const R = 6371e3; // metres
    final phi1 = from.latitude * Math.pi / 180; // φ, λ in radians
    final phi2 = to.latitude * Math.pi / 180;
    final deltaPhi = (to.latitude - from.latitude) * Math.pi / 180;
    final deltaLambda = (to.longitude - from.longitude) * Math.pi / 180;

    final a = Math.sin(deltaPhi / 2) * Math.sin(deltaPhi / 2) +
        Math.cos(phi1) * Math.cos(phi2) *
            Math.sin(deltaLambda / 2) *
            Math.sin(deltaLambda / 2);
    final c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    final d = R * c; // in metres
    return d;
  }




  LatLng parseLatLng(String latlong) {
    final parts = latlong.split(',');
    final latitude = double.parse(parts[0]);
    final longitude = double.parse(parts[1]);
    return LatLng(latitude, longitude);
  }

  SupportModel findClosestSupport(LatLng target, List<SupportModel> list) {
    var closestSupport = list[0];
    var closestLatLng = parseLatLng(closestSupport.latLong!);
    var smallestDistance = distance(target, closestLatLng);

    for (var i = 1; i < list.length; i++) {
      final currentSupport = list[i];
      final currentLatLng = parseLatLng(currentSupport.latLong!);
      final currentDistance = distance(target, currentLatLng);

      if (currentDistance < smallestDistance) {
        closestSupport = currentSupport;
        closestLatLng = currentLatLng;
        smallestDistance = currentDistance;
      }
    }

    print(closestSupport.latLong.toString());
    return closestSupport;
  }


  bool isSupportSent= false;
  void sendSupport(ReportModel report){
    isSupportSent= true;
    emit(SendSupportLoadingState());
    report.nearestSupport= nearestSupport!.id;
    report.adminId= uId;
    report.confirmationTime= Timestamp.now();
    FirebaseFirestore.instance.collection('reports').doc(report.id)
        .delete().then((value) {
      FirebaseFirestore.instance.collection('archive').doc(report.id)
          .set(report.toMap()).then((value) {
            isSupportSent= false;
            emit(SendSupportSuccessState());
      });
    }).catchError((error){
      emit(SendSupportErrorState());
    });
  }


  bool isFakeSent= false;
  void sendFake(ReportModel report){
    isFakeSent= true;
    emit(SendFakeLoadingState());
    report.nearestSupport= nearestSupport!.id;
    report.adminId= uId;
    report.confirmationTime= Timestamp.now();
    FirebaseFirestore.instance.collection('reports').doc(report.id)
        .delete().then((value) {
      FirebaseFirestore.instance.collection('fakeReports').doc(report.id)
          .set(report.toMap()).then((value) {
        isFakeSent= false;
        emit(SendFakeSuccessState());
      });
    }).catchError((error){
      emit(SendFakeErrorState());
    });
  }
}

