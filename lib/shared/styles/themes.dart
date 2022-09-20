import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app_final/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.red,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.deepOrange,
    ),
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontFamily: "KareemR",color: myFavColor),
    bodyText2: TextStyle(fontFamily: "KareemR",color: myFavColor),
    subtitle1: const TextStyle(fontFamily: "KareemB",color: Colors.redAccent),
    headline5: const TextStyle(fontFamily: "KareemB",color: Colors.redAccent),
    headline6: const TextStyle(fontFamily: "KareemB",color: Colors.redAccent),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: Colors.redAccent),
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(fontFamily: "KareemB"),
    unselectedLabelStyle: TextStyle(fontFamily: "KareemR"),
    showUnselectedLabels: true,
  ),
);

ThemeData darkTheme = ThemeData(

  backgroundColor: myFavColor5,
  primarySwatch: Colors.deepPurple,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: myFavColor7,
    ),
    backgroundColor: myFavColor5,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: myFavColor5,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontFamily: "KareemR",color: myFavColor),
    bodyText2: TextStyle(fontFamily: "KareemR",color: myFavColor),
    subtitle2: const TextStyle(fontFamily: "KareemB",color: Colors.white),
    headline5: const TextStyle(fontFamily: "KareemB",color: Colors.white),
    headline6: const TextStyle(fontFamily: "KareemB",color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    selectedIconTheme: IconThemeData(color: myFavColor7),
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(fontFamily: "KareemB"),
    unselectedLabelStyle: TextStyle(fontFamily: "KareemR"),
    showUnselectedLabels: true,
  ),
);