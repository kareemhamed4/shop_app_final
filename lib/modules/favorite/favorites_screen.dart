import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/layout/cubit/cubit.dart';
import 'package:shop_app_final/layout/cubit/states.dart';
import 'package:shop_app_final/models/shop_models/get_favorites_model.dart';
import 'package:shop_app_final/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: state is! ShopHomeGetFavoritesLoadingState,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildFavoritesItem(size,ShopLayoutCubit.get(context).favoritesModel!.data!.data![index],context),
              separatorBuilder: (context,index) => myDivider(),
              itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
    );
  }

  Widget buildFavoritesItem(Size size, FavoritesData model,BuildContext context) => Container(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: size.height * 0.18,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  width: size.width * 0.4,
                  height: size.height * 0.18,
                  image: NetworkImage('${model.product!.image}'),
                ),
                if ( model.product!.discount != 0)
                  CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    radius: size.width * 0.05,
                    child: const Text(
                      'Discount',
                      style: TextStyle(
                        fontSize: 7,
                        fontFamily: "KareemB",
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                     '${model.product!.name}',
                    style: const TextStyle(
                        fontFamily: 'KareemB', fontSize: 14, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price}',
                        style: const TextStyle(
                            fontFamily: 'KareemB',
                            fontSize: 18,
                            color: Colors.redAccent),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text(
                        "EGP",
                        style: TextStyle(
                            fontFamily: 'KareemR', fontSize: 8, color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Spacer(),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: (){
                          ShopLayoutCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: ShopLayoutCubit.get(context).favorites![model.product!.id!]! ? Colors.redAccent :  Colors.grey ,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if ( model.product!.discount != 0)
                    Text(
                      '${model.product!.oldPrice}',
                      style: const TextStyle(
                        fontFamily: 'KareemB',
                        fontSize: 14,
                        color: Colors.black54,
                        decoration: TextDecoration.lineThrough,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 5,)
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}