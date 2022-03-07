import 'package:shop_app/model/search_model/search_model.dart';

abstract class SearchStatues {}

class SearchInitialStatue extends SearchStatues {}

class SearchLoadingStatue extends SearchStatues {}

class SearchSuccessStatue extends SearchStatues {
 final SearchModel searchModel;

  SearchSuccessStatue(this.searchModel);
}

class SearchErrorStatue extends SearchStatues {}

