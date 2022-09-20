import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/models/shop_models/login_model.dart';
import 'package:shop_app_final/modules/setting/cubit/states.dart';
import 'package:shop_app_final/network/end_points.dart';
import 'package:shop_app_final/network/remote/dio_helper.dart';
import 'package:shop_app_final/shared/components/constants.dart';

class ShopSettingCubit extends Cubit<ShopSettingsStates> {
  ShopSettingCubit() : super(ShopSettingInitialState());

  static ShopSettingCubit get(context) => BlocProvider.of(context);

  LoginModel? userModel;

  void getUserData() {
    emit(ShopUserProfileLoadingState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopUserProfileSuccessState(userModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopUserProfileErrorState());
    });
  }

  bool isEnabled = false;
  IconData icon = Icons.edit_outlined;

  void editProfile() {
    isEnabled = !isEnabled;
    icon = isEnabled ? Icons.check : Icons.edit_outlined;
    emit(ChangeEditingProfileState());
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateProfileLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopUpdateProfileSuccessState(userModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopUpdateProfileErrorState());
    });
  }
}
