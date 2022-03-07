import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/states.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/model/categories_model/categories_model.dart';
import 'package:shop_app/model/change_favorites/change_favorites_model.dart';
import 'package:shop_app/model/favorites_model/favorites_model.dart';
import 'package:shop_app/model/home_model/home_model.dart';
import 'package:shop_app/model/login/login_module.dart';
import 'package:shop_app/network/dio/dio_helper.dart';
import 'package:shop_app/screen/categories_screen.dart';
import 'package:shop_app/screen/favorites_screen.dart';
import 'package:shop_app/screen/product_screen.dart';
import 'package:shop_app/screen/settings_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitalState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currintindex = 0;
  List<Widget> lstbot = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> botitem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  void changenavbar(int index) {
    currintindex = index;
    emit(HomeChangeNavBar());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getDataHome() {
    emit(HomeLoadingstate());
    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      emit(HomeSuccessesstate(homeModel));
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
      });
      print(favorites.toString());
    }).catchError((error) {
      print(error);
      emit(HomeErrorstate());
    });
  }

  CategoriesModel categoriesModel;

  void getDataCategories() {
    DioHelper.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(HomeCategoriesstate(categoriesModel));
    }).catchError((error) {
      print(error);
      emit(HomeErrorCategoriesstate());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void ChangeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(HomeSuccessChange());

    DioHelper.postData(
            url: 'favorites', data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getDataFavorites();
      }
      print(value.data.toString());
      emit(HomeSuccessChangeFavorites(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(HomeErrorChangeFavorites());
    });
  }

  FavoritesModel favoritesModel;

  void getDataFavorites() {
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      emit(HomeSuccessGetFavorites(favoritesModel));
    }).catchError((error) {
      print(error);
      emit(HomeErrorGetFavorites());
    });
  }

  LoginModel profile;

  void getprofile() {
    emit(HomeLoadingGetProfile());
    DioHelper.getData(url: 'profile', token: token).then((value) {
      profile = LoginModel.fromjson(value.data);
      emit(HomeSuccessGetProfile(profile));
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetProfile());
    });
  }
  void updateprofile({
    @required String name,
    @required String phone,
    @required String email,
  }) {
    emit(HomeLoadingUpdateProfile());
    DioHelper.putData(
            url: 'update-profile',
            token: token,
            data: {'name': name, 'phone': phone, 'email': email})
        .then((value) {
      profile = LoginModel.fromjson(value.data);
          emit(HomeSuccessUpdateProfile(profile));
    })
        .catchError((error) {
      print(error.toString());
      emit(HomeErrorUpdateProfile());
    });
  }
}
