

import 'package:shop_app/model/login/login_module.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
 final LoginModel loginModule;

  ShopRegisterSuccessState(this.loginModule);
}

class ShopRegisterErrorState extends ShopRegisterStates
{
 final String error;

 ShopRegisterErrorState(this.error);
}

class ShopChangePasswordVisibilityRegisterState extends ShopRegisterStates {}