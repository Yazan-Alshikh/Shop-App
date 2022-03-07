import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';
import 'package:shop_app/bloc/home_bloc/states.dart';
import 'package:shop_app/model/categories_model/categories_model.dart';
import 'package:shop_app/model/home_model/home_model.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomeSuccessChangeFavorites){
          if(!state.model.status)
            {
              Fluttertoast.showToast(
                  msg: state.model.message,
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
        return ConditionalBuilder(
          condition: get.homeModel != null && get.categoriesModel != null,
          builder: (context) =>
              HomeBuldier(get.homeModel, get.categoriesModel, context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget HomeBuldier(HomeModel model, CategoriesModel catmod, context) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: model.data.banners
                      .map((e) => Image(
                            image: NetworkImage('${e.image}'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    initialPage: 0,
                    reverse: false,
                    viewportFraction: 1.0,
                    scrollDirection: Axis.horizontal,
                    height: 250,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 3),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Categories",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              Container(
                height: 135,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        CategoriesBuldier(catmod.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 5,
                        ),
                    itemCount: catmod.data.data.length),
              ),
              Text(
                "New Product",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  color: Colors.white,
                  child: GridView.count(
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1 / 1.6,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(
                      model.data.products.length,
                      (index) =>
                          ProductBuldier((model.data.products[index]), context),
                    ),
                  ))
            ],
          ),
        ),
      );

  Widget ProductBuldier(HomeProduct model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                color: Colors.white,
                child: Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
              ),
              if (model.discount != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Text(
                        "Discount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              model.name,
              style: TextStyle(
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text("${model.price.round()}"),
                SizedBox(
                  width: 5,
                ),
                if (model.discount != 0)
                  Text(
                    "${model.old_price.round()}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      HomeCubit.get(context).ChangeFavorites(model.id);
                      },
                    icon: HomeCubit.get(context).favorites[model.id]
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border)),
              ],
            ),
          )
        ],
      );

  Widget CategoriesBuldier(CatData model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image(
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    image: NetworkImage(model.image)),
                Container(
                    width: 100,
                    color: Colors.black.withOpacity(0.7),
                    child: Text(
                      model.name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
