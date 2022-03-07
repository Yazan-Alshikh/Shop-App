import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';
import 'package:shop_app/bloc/home_bloc/states.dart';
import 'package:shop_app/network/cache_helper/cache_helper.dart';
import 'package:shop_app/screen/login_screen.dart';
import 'package:shop_app/screen/search_screen.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
              }, icon: Icon(Icons.search))
            ],
            title: Text ("Salla"),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: get.currintindex,
            onTap: (index){
              get.changenavbar(index);
            },
            items: get.botitem,
          ),
          body: get.lstbot[get.currintindex],
        );
      },
    );
  }
}
