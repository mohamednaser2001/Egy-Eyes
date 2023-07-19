
class CampaignModel{
  String? title;
  String? description;
  String? dateTime;
  String? image;


  CampaignModel(
      {required this.title,
        required this.description,
        required this.dateTime,
        required this.image});


  CampaignModel.fromJson(Map<String,dynamic>json){
    title=json['title'];
    description=json['description'];
    dateTime=json['dateTime'];
    image=json['image'];
  }

}