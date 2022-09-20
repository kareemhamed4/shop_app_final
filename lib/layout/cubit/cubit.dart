import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/layout/cubit/states.dart';
import 'package:shop_app_final/models/shop_models/categories_model.dart';
import 'package:shop_app_final/models/shop_models/change_favorite_model.dart';
import 'package:shop_app_final/models/shop_models/get_favorites_model.dart';
import 'package:shop_app_final/models/shop_models/get_home_data_model.dart';
import 'package:shop_app_final/modules/categories/categories_screen.dart';
import 'package:shop_app_final/modules/favorite/favorites_screen.dart';
import 'package:shop_app_final/modules/products/products_screen.dart';
import 'package:shop_app_final/modules/setting/setting_screen.dart';
import 'package:shop_app_final/network/end_points.dart';
import 'package:shop_app_final/network/remote/dio_helper.dart';
import 'package:shop_app_final/shared/components/constants.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> shopLayoutScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNavIndex({required int index}) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products!) {
        favorites!.addAll({
          element.id!: element.inFavorites!,
        });
      }
      if (kDebugMode) {
        print(favorites.toString());
      }
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopHomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesModel() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopHomeCategoriesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopHomeCategoriesErrorState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(int? productId) {
    favorites![productId!] = !favorites![productId]!;
    emit(ShopHomeChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
      if (!changeFavoriteModel!.status!) {
        favorites![productId] = !favorites![productId]!;
      } else {
        getFavoritesModel();
      }
      emit(ShopHomeChangeFavoriteSuccessState(changeFavoriteModel!));
    }).catchError((error) {
      favorites![productId] = !favorites![productId]!;
      emit(ShopHomeChangeFavoriteErrorState(changeFavoriteModel!));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesModel() {
    emit(ShopHomeGetFavoritesLoadingState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopHomeGetFavoritesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopHomeGetFavoritesErrorState());
    });
  }
}
