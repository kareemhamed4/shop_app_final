import 'package:shop_app_final/models/shop_models/login_model.dart';

abstract class ShopSignUpStates {}

class ShopSignUpInitialState extends ShopSignUpStates {}

class ShopSignUpLoadingState extends ShopSignUpStates {}
class ShopSignUpSuccessState extends ShopSignUpStates {
  final LoginModel signup;

  ShopSignUpSuccessState(this.signup);
}
class ShopSignUpErrorState extends ShopSignUpStates {}

class ChangeSignUpSuffixState extends ShopSignUpStates {}
class ShopSignUpCheckBoxState extends ShopSignUpStates {}
