import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/models/shop_models/search_model.dart';
import 'package:shop_app_final/modules/search/cubit/states/states.dart';
import 'package:shop_app_final/network/end_points.dart';
import 'package:shop_app_final/network/remote/dio_helper.dart';
import 'package:shop_app_final/shared/components/constants.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search({required String text}) {
    emit(ShopSearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
      'text': text,
    }).then((value){
      model = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopSearchErrorState());
    });
  }
}
