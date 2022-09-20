import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_final/layout/cubit/cubit.dart';
import 'package:shop_app_final/layout/cubit/states.dart';
import 'package:shop_app_final/models/shop_models/categories_model.dart';
import 'package:shop_app_final/models/shop_models/get_home_data_model.dart';
import 'package:shop_app_final/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopHomeChangeFavoriteSuccessState){
          if(!state.model.status!){
            Fluttertoast.showToast(
                msg: "${state.model.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red[300],
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        if(state is ShopHomeChangeFavoriteErrorState){
          if(!state.model.status!){
            Fluttertoast.showToast(
                msg: "${state.model.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red[300],
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).homeModel != null &&
              ShopLayoutCubit.get(context).categoriesModel != null,
          builder: (context) => productBuilder(
              ShopLayoutCubit.get(context).homeModel!,
              ShopLayoutCubit.get(context).categoriesModel!,
              size,context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(
          HomeModel model, CategoriesModel categoriesModel, Size size,context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: model.data!.banners!
                    .map(
                      (e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: size.height * 0.2,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Categories',
                        style: TextStyle(
                            fontFamily: "KareemB",
                            fontSize: 22,
                            color: Colors.black)),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCategoriesItemHorizontal(
                                categoriesModel.data!.data![index], size),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 8,
                        ),
                        itemCount: categoriesModel.data!.data!.length,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    const Text('Products u may like!',
                        style: TextStyle(
                            fontFamily: "KareemR",
                            fontSize: 18,
                            color: Colors.black)),
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.5,
                children: List.generate(
                    model.data!.products!.length,
                    (index) =>
                        buildGridProduct(model.data!.products![index], size,context)),
              ),
            ],
          ),
        ),
      );

  Widget buildGridProduct(
    ProductsModel model,
    Size size,
    BuildContext context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  height: size.height * 0.15,
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                ),
                if (model.discount != 0)
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
              height: 8,
            ),
            Text(
              "${model.name}",
              style: const TextStyle(
                  fontFamily: 'KareemB', fontSize: 14, color: Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "${model.price}",
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
                  width: 4,
                ),
                const Spacer(),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: (){
                    ShopLayoutCubit.get(context).changeFavorites(model.id!);
                  },
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopLayoutCubit.get(context).favorites![model.id]! ? Colors.redAccent :  Colors.grey ,
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            if (model.discount != 0)
              Text(
                "${model.oldPrice}",
                style: const TextStyle(
                  fontFamily: 'KareemB',
                  fontSize: 14,
                  color: Colors.black54,
                  decoration: TextDecoration.lineThrough,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      );

  Widget buildCategoriesItemHorizontal(DataModel model, Size size) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              '${model.image}',
            ),
            width: size.width * 0.28,
            height: size.height * 0.12,
            fit: BoxFit.fill,
          ),
          Container(
              color: Colors.black87,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                "${model.name}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'KareemB', color: Colors.white, fontSize: 14),
              )),
        ],
      );
}
