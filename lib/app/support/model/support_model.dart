

class SupportModel{
  String? type;
  String? latLong;
  String? status;
  String? id;
  //String? photo;
  String? cityId;
  String? governId;

  SupportModel(
      {required this.type,
        required this.latLong,
        required this.id,
        //required this.photo,
        required this.cityId,
        required this.governId,
        required this.status});


  SupportModel.fromJson(Map<String,dynamic>json){
    type=json['type'];
    latLong=json['latLong'];
    cityId=json['cityId'];
    status=json['status'];
    id=json['id'];
   // photo=json['photo'];
    governId=json['governId'];
  }

  Map<String,dynamic> toMap(){
    return {
      'type':type,
      'latLong':latLong,
      'cityId':cityId,
      'status':status,
      'id':id,
      //'photo':photo,
      'governId':governId,
    };
  }
}