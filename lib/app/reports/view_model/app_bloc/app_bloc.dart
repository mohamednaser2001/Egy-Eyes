

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_eye_admin/app/authentication/model/admin_model.dart';
import 'package:egy_eye_admin/app/authentication/view/login_screen.dart';
import 'package:egy_eye_admin/app/campaigns/view/screens/add_campaigns_screen.dart';
import 'package:egy_eye_admin/app/reports/model/report_model.dart';
import 'package:egy_eye_admin/app/reports/view/screens/dashboard_screen.dart';
import 'dart:html' as html;
import 'package:egy_eye_admin/helpers/constants/constants.dart';
import 'package:egy_eye_admin/helpers/methods/navigation_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../archive/view/screens/archive_dashboard_screen.dart';
import '../../../support/view/screens/support_layout.dart';
import '../../view/screens/reports_types_pages/ambulance_reports_screen.dart';
import '../../view/screens/reports_types_pages/firefighter_reports_screen.dart';
import '../../view/screens/reports_types_pages/general_reports_screen.dart';
import '../../view/screens/reports_types_pages/traffic_reports_screen.dart';
import 'app_states.dart';


class AppCubit extends Cubit<AppStates>{

  AppCubit():super(InitialAppState());

  static AppCubit get(context) =>BlocProvider.of(context);


  List<Widget> screens=[
    DashboardScreen(),
    SupportScreen(),
    ArchiveDashboardScreen(),
    AddCampaignsScreen(),
  ];

  List<Widget> reportsScreens=[
    AmbulanceReportsScreen(),
    TrafficReportsScreen(),
    FireFighterReportsScreen(),
    GeneralReportsScreen(),
  ];

  int screenIndex=0;
  void changeDrawerIndex(int index){
    screenIndex=index;
    emit(ChangeDrawerItem());
  }




  int reportScreenTypeIndex=0;
  void changeReportsScreenType(int index){
    reportScreenTypeIndex= index;
    emit(ChangeReportsScreenTypeState());
  }







  List<ReportModel> trafficReports=[];
  List<ReportModel> generalReports=[];
  List<ReportModel> fireFighterReports=[];
  List<ReportModel> ambulanceReports=[];

  //List<ReportModel> allReports=[];
  bool loadingReports= false;
  void getAllReports(){
    loadingReports= true;
    emit(AppGetAllReportsLoadingState());
    FirebaseFirestore.instance.collection('reports')
        .snapshots()
        .listen((event) {
          clearLists();
      event.docs.forEach((element) {
        ReportModel model= ReportModel.fromJson(element.data());
        if(model.authority=='firefighter'){
          fireFighterReports.add(model);
        }else if(model.authority=='traffic'){
          trafficReports.add(model);
        }
        else if(model.authority=='ambulance'){
          ambulanceReports.add(model);
        }else {
          generalReports.add(model);
        }
        //allReports.add(ReportModel.fromJson(element.data()));
      });
      loadingReports= false;
      emit(AppGetAllReportsSuccessState());
    });
  }


  void clearLists(){
    generalReports.clear();
    trafficReports.clear();
    ambulanceReports.clear();
    fireFighterReports.clear();
  }


  void logout(context){
    html.window.localStorage.remove('uId');
    navigateWithoutBack(context, LoginScreen());
  }

  AdminModel? adminModel;
  void getAdminData(){
    emit(AppGetAdminDataLoadingState());

    FirebaseFirestore.instance.collection('admins')
        .doc(uId).get().then((value) {
        adminModel= AdminModel.fromJson(value.data()!);
          emit(AppGetAdminDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetAdminDataErrorState());
    });
  }





}