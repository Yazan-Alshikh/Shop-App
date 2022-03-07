import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/search_bloc/states.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/model/search_model/search_model.dart';

import 'package:shop_app/network/dio/dio_helper.dart';

class SearchCubit extends Cubit<SearchStatues> {
  SearchCubit() : super(SearchInitialStatue());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void search(String text) {
    emit(SearchLoadingStatue());

    DioHelper.postData(
        url: 'products/search',
        token: token,
        data: {'text': text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessStatue(searchModel));
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStatue());
    });
  }
}
