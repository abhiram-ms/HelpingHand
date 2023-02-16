
import 'package:flutter/material.dart';

const Color redhot = Color(0x00f80000);
const redbrown = Color(0x00a90011);
const Color redbrownlt = Color(0x00d11d27);
const white = Color(0x00ffffff);
const ltwhite2 = Color(0x00fffaef);
const ltwhite1 = Color(0x00fbebd8);

ThemeData lighttheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: redhot,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 40,vertical: 20,)
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
      ),
      backgroundColor: MaterialStateProperty.all<Color>(redbrownlt),

    )
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,elevation: 0),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.redAccent
  )
  // iconTheme:  IconThemeData(
  //   color: Colors.orange,
  // ),
);

ThemeData darktheme = ThemeData(
  brightness: Brightness.dark,
);