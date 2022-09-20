import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/bloc_observer.dart';
import 'package:shop_app_final/layout/home_layout.dart';
import 'package:shop_app_final/modules/login_screen/login_screen.dart';
import 'package:shop_app_final/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:shop_app_final/network/local/shared_helper.dart';
import 'package:shop_app_final/network/remote/dio_helper.dart';
import 'package:shop_app_final/shared/styles/themes.dart';

import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  token = CacheHelper.getData(key: "token");

  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeShopScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}
