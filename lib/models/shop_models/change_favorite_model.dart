class ChangeFavoriteModel {
  bool? status;
  String? message;
  Data? date;

  ChangeFavoriteModel({this.status,this.message,this.date});

  ChangeFavoriteModel.fromJson(Map<String,dynamic> json){
    status = json["status"];
    message = json["message"];
    date = json["data"] != null ? Data.fromJson(json["data"]) : null ;
  }
}

class Data {
  int? productId;

  Data({this.productId});

  Data.fromJson(Map<String,dynamic> json){
    productId = json["id"];
  }

}