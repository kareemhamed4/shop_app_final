class HomeModel {
  bool? status;
  String? ad;
  HomeDataModel? data;

  HomeModel({this.status,this.ad,this.data});

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json["status"];
    ad = json["ad"];
    data = json["data"] != null ? HomeDataModel.fromJson(json["data"]) : null;
  }
}

class HomeDataModel {
  List<BannerModel>? banners = [];
  List<ProductsModel>? products = [];

  HomeDataModel({this.banners,this.products});

  HomeDataModel.fromJson(Map<String,dynamic> json){
    json["banners"].forEach((element){
      banners!.add(BannerModel.fromJson(element));
    });
    json["products"].forEach((element){
      products!.add(ProductsModel.fromJson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel({this.id,this.image});

  BannerModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    image = json["image"];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductsModel({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.inFavorites,
    this.inCart,
});

  ProductsModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }

}