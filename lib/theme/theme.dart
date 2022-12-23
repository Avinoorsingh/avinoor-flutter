import 'package:flutter/material.dart';
import 'package:colab/theme/button_themes.dart';
import 'package:colab/theme/text_styles.dart';

import '../constants/colors.dart';

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headline1: textStyleHeadline1.copyWith(color: fontColor),
    headline2: textStyleHeadline2.copyWith(color: fontColor),
    bodyText1: textStyleBodyText1.copyWith(color: fontColor),
    bodyText2: textStyleBodyText2,
    subtitle1: textStyleSubTitle1,
    subtitle2: textStyleSubTitle2,
    button: textStyleButton,
  ),
  // ignore: prefer_const_constructors
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.greenAccent,
    onPrimary: AppColors.white,
    secondary: const Color(0xff8A00D0),
    onSecondary: AppColors.white,
    error: Colors.red,
    onError: AppColors.white,
    background: AppColors.white,
    onBackground: const Color(0xff1D2028),
    surface: AppColors.white,
    onSurface: const Color(0xff1D2028),
  ),
  // elevatedButtonTheme: roundedButtonTheme,
  //lightElevatedButtonTheme,
  outlinedButtonTheme: lightOutlinedButtonTheme,
  textButtonTheme: lightTextButtonTheme,
  // inputDecorationTheme: inputDecorationTheme,
);

//Various Colors
Color dividerColor = const Color(0xff979797);
Color dividerColor2 = const Color(0xffeeeeee);
Color fontColor = const Color(0xff1D2028);
Color outlinedButtonColor = const Color(0xff42312E);
Color inputLabelColor = const Color(0xff8D9093);
Color placeholderColor = const Color(0xffF1F3F6);
Color placeholderDarkColor = const Color(0xff6C63FF);
Color imageOverlayColor = const Color(0xff21004E);

Color primaryGradientColor1 = const Color(0xff4F62FA);
Color primaryGradientColor2 = const Color(0xff8A00D0);
Color primaryGradientColor3 = const Color(0xff8C51A5);
Color primaryGradientColor4 = const Color(0xffCB5E98);
Color primaryGradientColorAlt = const Color(0xff2699FB);

//Gradients
List<Color> primaryGradient = <Color>[
  primaryGradientColor1,
  primaryGradientColor2,
];

List<Color> primaryGradientAlternate = <Color>[
  primaryGradientColorAlt,
  primaryGradientColor2,
];
List<Color> primaryGradientAlternate2 = <Color>[
  primaryGradientColor3,
  primaryGradientColor4,
];
