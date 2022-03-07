import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/login_bloc/login_state.dart';
import 'package:shop_app/bloc/register_bloc/register_state.dart';
import 'package:shop_app/model/login/login_module.dart';
import 'package:shop_app/network/dio/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginModel loginModule;

  void userLogin({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,

  })
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: 'register',
      data:
      {
        'email': email,
        'password': password,
        'name': name,
        'phone' : phone
      },
    ).then((value)
    {
      loginModule =  LoginModel.fromjson(value.data);
      emit(ShopRegisterSuccessState(loginModule));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopChangePasswordVisibilityRegisterState());
  }
}