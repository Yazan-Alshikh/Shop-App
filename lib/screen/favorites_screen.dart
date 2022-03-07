import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';
import 'package:shop_app/bloc/home_bloc/states.dart';
import 'package:shop_app/model/favorites_model/favorites_model.dart';
import 'package:shop_app/widget/builed_productes_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => ProducteItem(HomeCubit.get(context).favoritesModel.data.data[index].product,context),
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey,
            ),
            itemCount: HomeCubit.get(context).favoritesModel.data.data.length);
      },
    );
  }


}
