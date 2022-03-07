


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/search_bloc/search_cubit.dart';
import 'package:shop_app/bloc/search_bloc/states.dart';
import 'package:shop_app/widget/builed_productes_item.dart';
import 'package:shop_app/widget/default_form_filed.dart';

class SearchScreen extends StatelessWidget {
  var searchcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStatues>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    DefaultFormFiled(
                        onsubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        controller: searchcontroller,
                        label: 'Search',
                        preifex: Icons.search,
                        type: TextInputType.text),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is SearchLoadingStatue) LinearProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is SearchSuccessStatue)
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => ProducteItem(SearchCubit.get(context).searchModel.data.data[index], context,IsSearch: true
                                  ),
                              separatorBuilder: (context, index) => Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                              itemCount: SearchCubit.get(context)
                                  .searchModel
                                  .data
                                  .data
                                  .length))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
