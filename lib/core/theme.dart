import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData themeData() {
  const outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: kBorderColor),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
  return ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: kBackgroundColor,
    primaryColor: Colors.red,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      prefixIconColor: kGreyColor,
      hintStyle: kTextStyleNormal,
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
    ),
  );
}
