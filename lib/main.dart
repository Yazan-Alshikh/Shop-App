import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';
import 'package:shop_app/network/cache_helper/cache_helper.dart';
import 'package:shop_app/network/dio/dio_helper.dart';
import 'package:shop_app/screen/boarding_screen.dart';
import 'package:shop_app/screen/login_screen.dart';
import 'package:shop_app/screen/shop_layout.dart';

import 'bloc/bloc_observer.dart';
import 'constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool onboarding = CacheHelper.getData(key: 'onboarding');
  token = CacheHelper.getData(key: 'token');
  print(token.toString());
  Widget widget;
  if (onboarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else
    widget = OnBoardingScreen();

  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp({this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeCubit()
              ..getDataHome()
              ..getDataCategories()
              ..getDataFavorites()
              ..getprofile())
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(headline4: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 20,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
            ),
            primaryColor: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            primaryTextTheme:
                TextTheme(headline4: TextStyle(color: Colors.black)),
            primarySwatch: Colors.deepOrange,
            primaryIconTheme: IconThemeData(color: Colors.black),
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
            )),
        home: widget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
