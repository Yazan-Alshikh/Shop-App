import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/bloc/register_bloc/register_cubit.dart';
import 'package:shop_app/bloc/register_bloc/register_state.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/network/cache_helper/cache_helper.dart';
import 'package:shop_app/screen/shop_layout.dart';
import 'package:shop_app/widget/default_button.dart';
import 'package:shop_app/widget/default_form_filed.dart';

class RegisterScreen extends StatelessWidget {
  var namecontrooler = TextEditingController();
  var emailcontrooler = TextEditingController();
  var phonecontrooler = TextEditingController();
  var passwordcontrooler = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => ShopRegisterCubit(),
          child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
            listener: (context, state) {
              if(state is ShopRegisterSuccessState){
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
                  }else{
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
              var get = ShopRegisterCubit.get(context);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DefaultFormFiled(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Name must not bee empty';
                              return null;
                            },
                            controller: namecontrooler,
                            label: 'Name',
                            preifex: Icons.person,
                            type: TextInputType.text),
                        SizedBox(
                          height: 15,
                        ),
                        DefaultFormFiled(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Email must not bee empty';
                              return null;
                            },
                            controller: emailcontrooler,
                            label: 'Email Address',
                            preifex: Icons.email,
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: 15,
                        ),
                        DefaultFormFiled(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Phone must not bee empty';
                              return null;
                            },
                            controller: phonecontrooler,
                            label: 'Phone',
                            preifex: Icons.phone,
                            type: TextInputType.phone),
                        SizedBox(
                          height: 15,
                        ),
                        DefaultFormFiled(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Password must not bee empty';
                              return null;
                            },
                            controller: passwordcontrooler,
                            label: 'Password',
                            preifex: Icons.lock,
                            type: TextInputType.visiblePassword),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is ! ShopRegisterLoadingState,
                          builder: (context) =>DefaultButton(
                              label: 'Register',
                              onpressed: () {
                                if (formkey.currentState.validate()) {
                                  get.userLogin(
                                      email: emailcontrooler.text,
                                      password: passwordcontrooler.text,
                                      name: namecontrooler.text,
                                      phone: phonecontrooler.text);
                                }
                              },
                              width: double.infinity) ,
                          fallback: (context) => Center(child: CircularProgressIndicator(),),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
