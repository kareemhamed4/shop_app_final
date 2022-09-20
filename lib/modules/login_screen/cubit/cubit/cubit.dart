import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/models/shop_models/login_model.dart';
import 'package:shop_app_final/modules/login_screen/cubit/states/states.dart';
import 'package:shop_app_final/network/end_points.dart';
import 'package:shop_app_final/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userModel({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      if (kDebugMode) {
        loginModel = LoginModel.fromJson(value.data);
      }
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopLoginErrorState());
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;

  void changeLoginSuffixIcon(){
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeLoginSuffixState());
  }
}
