import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/models/shop_models/login_model.dart';
import 'package:shop_app_final/modules/signup_screen/cubit/states/states.dart';
import 'package:shop_app_final/network/end_points.dart';
import 'package:shop_app_final/network/remote/dio_helper.dart';

class ShopSignUpCubit extends Cubit<ShopSignUpStates> {
  ShopSignUpCubit() : super(ShopSignUpInitialState());

  static ShopSignUpCubit get(context) => BlocProvider.of(context);
  LoginModel? signupModel;

  void userModel({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ShopSignUpLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name' : name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      if (kDebugMode) {
        signupModel = LoginModel.fromJson(value.data);
      }
      emit(ShopSignUpSuccessState(signupModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopSignUpErrorState());
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;

  void changeSignUpSuffixIcon(){
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeSignUpSuffixState());
  }

  bool isCheckBox = false;

  void changeCheckBox(){
    isCheckBox = !isCheckBox;
    emit(ShopSignUpCheckBoxState());
  }
}
