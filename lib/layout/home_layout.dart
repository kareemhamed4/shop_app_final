import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/layout/cubit/cubit.dart';
import 'package:shop_app_final/layout/cubit/states.dart';
import 'package:shop_app_final/modules/search/search_screen.dart';
import 'package:shop_app_final/shared/components/components.dart';

class HomeShopScreen extends StatelessWidget {
  const HomeShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLayoutCubit()..getHomeData()..getCategoriesModel()..getFavoritesModel(),
      child: BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context,state) => {},
        builder: (context,state) {
          ShopLayoutCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MARKET",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text("El Market",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              actions: [
                IconButton(onPressed: (){
                  NavigateTo(context: context, widget: SearchScreen());
                }, icon: const Padding(
                  padding: EdgeInsetsDirectional.only(end: 20.0),
                  child: Icon(Icons.search,color: Colors.black87,),
                ),
                ),
              ],
            ),
            body: cubit.shopLayoutScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Image.asset('assets/icons/Product Icon.png',width: 30,height: 30),label: "Products"),
                BottomNavigationBarItem(icon: Image.asset('assets/icons/categories icon.png'),label: "Categories"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border,color: Colors.grey[800],),label: "Favorites"),
                BottomNavigationBarItem(icon: Icon(Icons.settings_outlined,color: Colors.grey[800],),label: "Settings"),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavIndex(index: index);
              },
            ),
          );
        },
      ),
    );
  }
}
