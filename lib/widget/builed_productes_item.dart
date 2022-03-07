import 'package:flutter/material.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';

Widget ProducteItem(model,context,{bool IsSearch = false}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              color: Colors.white,
              child: Image(
                image: NetworkImage(
                    model.image),
                width: 120,
                height: 120,
              ),
            ),
            if (model.discount != 0 && IsSearch == false)
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
          width: 5,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text('${model.price}'),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0 && IsSearch == false)
                      Text(
                        ('${model.oldPrice}'),
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
          ),
        ),
      ],
    ),
  ),
);