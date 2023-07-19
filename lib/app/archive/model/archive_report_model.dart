import 'package:cloud_firestore/cloud_firestore.dart';

class ArchiveReportModel{
  String? senderName;
  GeoPoint? latLong;
  String? nearestSupport;
  String? status;
  Timestamp? dateTime;
  String? description;
  String? id;
  String? photo;
  String? senderId;
  String? authority;
  int? cityId;
  int? governId;
  String? adminId;
  Timestamp? confirmationTime;

  ArchiveReportModel(
      {required this.senderName,
        required this.latLong,
        required this.nearestSupport,
        required this.status});


  ArchiveReportModel.fromJson(Map<String,dynamic>json){
    senderName=json['userName'];
    latLong=json['latLong'];
    senderId=json['userId'];
    dateTime=json['dateTime'];
    description=json['description'];
    id=json['id'];
    photo=json['photo'];
    authority=json['authority'];
    cityId=json['city_id'];
    governId=json['gov_id'];
    confirmationTime=json['confirmationTime'];
    status=json['status'];
  }

}