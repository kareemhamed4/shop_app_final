import 'package:shop_app_final/models/shop_models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}
class ShopLoginSuccessState extends ShopLoginStates {
  final LoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates {}

class ChangeLoginSuffixState extends ShopLoginStates {}
