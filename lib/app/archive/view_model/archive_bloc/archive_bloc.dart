

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/archive_report_model.dart';
import '../../view/screens/archived_reports_types_pages/archived_ambulance_reports_screen.dart';
import '../../view/screens/archived_reports_types_pages/archived_firefighter_reports_screen.dart';
import '../../view/screens/archived_reports_types_pages/archived_general_reports_screen.dart';
import '../../view/screens/archived_reports_types_pages/archived_traffic_reports_screen.dart';
import 'archive_states.dart';


class ArchiveCubit extends Cubit<ArchiveStates>{

  ArchiveCubit():super(InitialArchiveState());

  static ArchiveCubit get(context) =>BlocProvider.of(context);


  List<Widget> reportsScreens=[
    ArchivedAmbulanceReportsScreen(),
    ArchivedTrafficReportsScreen(),
    ArchivedFireFighterReportsScreen(),
    ArchivedGeneralReportsScreen(),
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




  List<ArchiveReportModel> trafficReports=[];
  List<ArchiveReportModel> generalReports=[];
  List<ArchiveReportModel> fireFighterReports=[];
  List<ArchiveReportModel> ambulanceReports=[];
  bool loadingReports= false;

  void getAllArchivedReports(){
    loadingReports= true;
    emit(ArchiveGetAllReportsLoadingState());
    FirebaseFirestore.instance.collection('archive')
        .snapshots()
        .listen((event) {
          clearLists();
      event.docs.forEach((element) {
        ArchiveReportModel model= ArchiveReportModel.fromJson(element.data());
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
      });
      loadingReports= false;
      emit(ArchiveGetAllReportsSuccessState());
    });
  }


  void clearLists(){
    generalReports.clear();
    trafficReports.clear();
    ambulanceReports.clear();
    fireFighterReports.clear();
  }






}