import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';
import 'package:shop_app/bloc/home_bloc/states.dart';
import 'package:shop_app/bloc/register_bloc/register_state.dart';
import 'package:shop_app/network/cache_helper/cache_helper.dart';
import 'package:shop_app/screen/login_screen.dart';
import 'package:shop_app/widget/default_button.dart';
import 'package:shop_app/widget/default_form_filed.dart';

class SettingsScreen extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeSuccessUpdateProfile)
          {
            if(state.loginModel.status)
              {
                Fluttertoast.showToast(
                    msg: state.loginModel.message,
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
                      msg: state.loginModel.message,
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
        var get = HomeCubit.get(context);

        namecontroller.text = get.profile.data.name;
        emailcontroller.text = get.profile.data.email;
        phonecontroller.text = get.profile.data.phone;

        return ConditionalBuilder(
          condition: get.profile != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if(state is HomeLoadingUpdateProfile)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 25,
                    ),
                    DefaultFormFiled(
                        controller: namecontroller,
                        label: "Name",
                        preifex: Icons.person,
                        type: TextInputType.text),
                    SizedBox(
                      height: 15,
                    ),
                    DefaultFormFiled(
                        controller: emailcontroller,
                        label: "Email Address",
                        preifex: Icons.email_outlined,
                        type: TextInputType.emailAddress),
                    SizedBox(
                      height: 15,
                    ),
                    DefaultFormFiled(
                        controller: phonecontroller,
                        label: "Phone",
                        preifex: Icons.phone,
                        type: TextInputType.phone),
                    SizedBox(
                      height: 25,
                    ),
                    DefaultButton(
                        onpressed: () {
                          if (formkey.currentState.validate()) {
                            HomeCubit.get(context).updateprofile(
                                name: namecontroller.text,
                                phone: phonecontroller.text,
                                email: emailcontroller.text);
                          }
                        },
                        label: "Update",
                        width: double.infinity),
                    SizedBox(
                      height: 15,
                    ),
                    DefaultButton(
                        onpressed: () {
                          CacheHelper.removeData(key: 'token').then((value) {
                            if (value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShopLoginScreen(),
                                  ));
                            }
                          }).catchError((error) {
                            print(error.toString());
                          });
                        },
                        label: "Log Out",
                        width: double.infinity),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
