class HomeModel {
  bool status;
  HomeData data;

  HomeModel.fromjson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = HomeData.fromjson(json['data']);
  }

}

class HomeData {
  List<HomeBanners> banners = [];
  List<HomeProduct> products = [];

  HomeData.fromjson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(HomeBanners.fromjson(element));
    });
    json['products'].forEach((element){
      products.add(HomeProduct.fromjson(element));
    });
  }


}

class HomeBanners {
  int id;
  String image;

  HomeBanners.fromjson(Map <String,dynamic> json){
    id = json['id'];
    image = json ['image'];
  }


}


class HomeProduct {

  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  bool in_favorites;
  bool in_cart;

  HomeProduct.fromjson (Map <String,dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];



  }


}