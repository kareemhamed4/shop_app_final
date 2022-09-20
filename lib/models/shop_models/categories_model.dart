class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel({this.status,this.data});

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json["status"];
    data =  json["data"] != null ? CategoriesDataModel.fromJson(json["data"]) : null;
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data = [];

  CategoriesDataModel({this.currentPage,this.data});

  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    currentPage = json["current_page"];
    json["data"].forEach((element){
      data!.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel({this.id,this.name,this.image});

  DataModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}