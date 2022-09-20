import 'package:shop_app_final/models/shop_models/login_model.dart';

abstract class ShopSettingsStates {}

class ShopSettingInitialState extends ShopSettingsStates {}

class ShopUserProfileLoadingState extends ShopSettingsStates {}
class ShopUserProfileSuccessState extends ShopSettingsStates {
  final LoginModel loginModel;

  ShopUserProfileSuccessState(this.loginModel);

}
class ShopUserProfileErrorState extends ShopSettingsStates {}
class ChangeEditingProfileState extends ShopSettingsStates {}

class ShopUpdateProfileLoadingState extends ShopSettingsStates {}
class ShopUpdateProfileSuccessState extends ShopSettingsStates {
  final LoginModel loginModel;
  ShopUpdateProfileSuccessState(this.loginModel);
}
class ShopUpdateProfileErrorState extends ShopSettingsStates {}