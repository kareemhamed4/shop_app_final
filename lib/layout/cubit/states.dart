import 'package:shop_app_final/models/shop_models/change_favorite_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialState extends ShopLayoutStates {}

class ShopChangeBottomNavState extends ShopLayoutStates {}

class ShopHomeLoadingState extends ShopLayoutStates {}
class ShopHomeSuccessState extends ShopLayoutStates {}
class ShopHomeErrorState extends ShopLayoutStates {}

class ShopHomeCategoriesSuccessState extends ShopLayoutStates {}
class ShopHomeCategoriesErrorState extends ShopLayoutStates {}

class ShopHomeChangeFavoriteSuccessState extends ShopLayoutStates {
  final ChangeFavoriteModel model;

  ShopHomeChangeFavoriteSuccessState(this.model);
}
class ShopHomeChangeFavoriteErrorState extends ShopLayoutStates {
  final ChangeFavoriteModel model;

  ShopHomeChangeFavoriteErrorState(this.model);
}

class ShopHomeChangeFavoriteState extends ShopLayoutStates {}

class ShopHomeGetFavoritesSuccessState extends ShopLayoutStates {}
class ShopHomeGetFavoritesErrorState extends ShopLayoutStates {}

class ShopHomeGetFavoritesLoadingState extends ShopLayoutStates {}

