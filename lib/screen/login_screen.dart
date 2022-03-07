import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/bloc/login_bloc/login_cubit.dart';
import 'package:shop_app/bloc/login_bloc/login_state.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/network/cache_helper/cache_helper.dart';
import 'package:shop_app/screen/register_screen.dart';
import 'package:shop_app/screen/shop_layout.dart';
import 'package:shop_app/widget/default_button.dart';
import 'package:shop_app/widget/default_form_filed.dart';





class ShopLoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState)
            {
              if (state.loginModule.status)
                {
                  CacheHelper.saveData(key: 'token', value: state.loginModule.data.token).then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopLayout()));
                    token = state.loginModule.data.token;
                  });


                  Fluttertoast.showToast(
                      msg: state.loginModule.message,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      fontSize: 16.0,
                    backgroundColor: Colors.green,
                    textColor: Colors.white
                  );

                }else
                  {
                    Fluttertoast.showToast(
                        msg: state.loginModule.message,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        fontSize: 16.0,
                        backgroundColor: Colors.red,
                        textColor: Colors.white
                    );
                  }
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        DefaultFormFiled(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          preifex: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DefaultFormFiled(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          onsubmit: (value)
                          {
                            if(formKey.currentState.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          Ispassword: ShopLoginCubit.get(context).isPassword,
                          onsuffixpressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          preifex: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => DefaultButton(
                            onpressed: ()
                            {
                              if(formKey.currentState.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            label: 'login',
                            width: double.infinity,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                              },
                              child: Text('register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}