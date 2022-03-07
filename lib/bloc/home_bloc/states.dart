
import 'package:shop_app/model/categories_model/categories_model.dart';
import 'package:shop_app/model/change_favorites/change_favorites_model.dart';
import 'package:shop_app/model/favorites_model/favorites_model.dart';
import 'package:shop_app/model/home_model/home_model.dart';
import 'package:shop_app/model/login/login_module.dart';

abstract class HomeStates {}

class HomeInitalState extends HomeStates {}

class HomeChangeNavBar extends HomeStates {}

class HomeLoadingstate extends HomeStates{}

class HomeSuccessesstate extends HomeStates{
  final HomeModel homeModel;

  HomeSuccessesstate(this.homeModel);
}

class HomeErrorstate extends HomeStates{}

class HomeCategoriesstate extends HomeStates{
  final CategoriesModel categoriesModel;

  HomeCategoriesstate(this.categoriesModel);
}

class HomeErrorCategoriesstate extends HomeStates{}

class HomeSuccessChangeFavorites extends HomeStates {
  final ChangeFavoritesModel model;

  HomeSuccessChangeFavorites(this.model);
}
class HomeSuccessChange extends HomeStates {
}

class HomeErrorChangeFavorites extends HomeStates {}


class HomeSuccessGetFavorites extends HomeStates {
  final FavoritesModel favoritesModel;

  HomeSuccessGetFavorites(this.favoritesModel);
}

class HomeErrorGetFavorites extends HomeStates {}


class HomeSuccessGetProfile extends HomeStates {
  final LoginModel loginModel;

  HomeSuccessGetProfile(this.loginModel);
}

class HomeErrorGetProfile extends HomeStates {}

class HomeLoadingGetProfile extends HomeStates {}


class HomeSuccessUpdateProfile extends HomeStates {
  final LoginModel loginModel;

  HomeSuccessUpdateProfile(this.loginModel);
}

class HomeErrorUpdateProfile extends HomeStates {}

class HomeLoadingUpdateProfile extends HomeStates {}
