import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/layout/cubit/cubit.dart';
import 'package:shop_app_final/layout/cubit/states.dart';
import 'package:shop_app_final/models/shop_models/categories_model.dart';
import 'package:shop_app_final/network/local/shared_helper.dart';
import 'package:shop_app_final/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(size,
                ShopLayoutCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopLayoutCubit.get(context).categoriesModel!.data!.data!.length,
          ),
        );
      },
    );
  }

  Widget buildCatItem(Size size, DataModel model) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: size.width * 0.28,
          height: size.height * 0.15,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          "${model.name}",
          style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 16,
              fontFamily: "KareemB"),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {CacheHelper.clearData();}, icon: const Icon(Icons.arrow_forward_ios)),
      ],
    ),
  );
}
