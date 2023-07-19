import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel{
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

  ReportModel(
      {required this.senderName,
        required this.latLong,
        required this.nearestSupport,
        required this.status});


  ReportModel.fromJson(Map<String,dynamic>json){
    senderName=json['userName'];
    latLong=json['location'];
    senderId=json['userId'];
    dateTime=json['dateTime'];
    description=json['description'];
    id=json['id'];
    photo=json['photo'];
    authority=json['authority'];
    cityId=json['city_id'];
    governId=json['gov_id'];
  }

  Map<String,dynamic> toMap(){
    return {
      'userName':senderName,
      'senderId':senderId,
      'latLong':latLong,
      'city_id':cityId,
      'status':status,
      'id':id,
      //'photo':photo,
      'gov_id':governId,
      'authority':authority,
      'description':description,
      'dateTime':dateTime,
      'nearestSupport':nearestSupport,
      'adminId':adminId,
      'confirmationTime':confirmationTime,
    };
  }
}