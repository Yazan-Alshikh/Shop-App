import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';
import 'package:shop_app/bloc/home_bloc/states.dart';
import 'package:shop_app/model/categories_model/categories_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>BuldierCategories(get.categoriesModel.data.data[index]) ,
            separatorBuilder: (context, index) => Divider(color: Colors.grey,height: 1,),
            itemCount: get.categoriesModel.data.data.length);
      },
    );
  }

  Widget BuldierCategories(CatData model) =>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        Row(
          children: [
            Image(
              image: NetworkImage(
                  model.image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 20,),
            Text(model.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),

      ],
    ),
  );
}
