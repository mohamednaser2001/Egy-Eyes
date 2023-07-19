import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel{
  String? name;
  String? phone;
  String? address;
  String? nationalId;
  String? image;
  String? email;


  AdminModel(
      {required this.name,
        required this.phone,
        required this.address,
        required this.nationalId,
        required this.email,
        required this.image});


  AdminModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    address=json['address'];
    email=json['email'];
    nationalId=json['id'];
    image=json['image'];
  }

}