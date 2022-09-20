import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/models/shop_models/search_model.dart';
import 'package:shop_app_final/modules/search/cubit/cubit/cubit.dart';
import 'package:shop_app_final/modules/search/cubit/states/states.dart';
import 'package:shop_app_final/shared/components/components.dart';

//ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    MyTextFormField(
                      onChange: (String text) {
                        if (formKey.currentState!.validate()) {
                          ShopSearchCubit.get(context).search(text: text);
                        }
                      },
                      controller: searchController,
                      onTap: () {},
                      validator: (value) {
                        return null;
                      },
                      type: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is ShopSearchLoadingState)
                      LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.red[300],
                      ),
                    if (state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItem(
                              size,
                              ShopSearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data![index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: ShopSearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(Size size, Product model, BuildContext context,
          {bool isOldPrice = true}) =>
      Container(
        color: Colors.white,
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
                      image: NetworkImage('${model.image}'),
                    ),
                    if (model.discount != 0 && isOldPrice)
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
                        '${model.name}',
                        style: const TextStyle(
                            fontFamily: 'KareemB',
                            fontSize: 14,
                            color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price}',
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
                                fontFamily: 'KareemR',
                                fontSize: 8,
                                color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          /*const Spacer(),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: (){
                          ShopLayoutCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: ShopLayoutCubit.get(context).favorites![model.id!]! ? Colors.redAccent :  Colors.grey ,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),*/
                        ],
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                            fontFamily: 'KareemB',
                            fontSize: 14,
                            color: Colors.black54,
                            decoration: TextDecoration.lineThrough,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
