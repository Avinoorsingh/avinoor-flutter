import 'package:flutter/material.dart';
import 'package:colab/theme/text_styles.dart';

ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(0),
      minimumSize: MaterialStateProperty.all<Size>(const Size(100, 50)),
      fixedSize: MaterialStateProperty.all<Size>(
          const Size.fromWidth(double.maxFinite)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
      )),
);

ElevatedButtonThemeData elevatedRoundedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0),
    minimumSize: MaterialStateProperty.all<Size>(const Size(80, 50)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100))),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    textStyle: MaterialStateProperty.all<TextStyle>(textStyleButton2),
  ),
);

OutlinedButtonThemeData lightOutlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(const Size(100, 50)),
    fixedSize:
    MaterialStateProperty.all<Size>(const Size.fromWidth(double.maxFinite)),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(width: 2, color: Color(0xff42312E))),
  ),
);

OutlinedButtonThemeData darkOutlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(const Size(100, 50)),
    fixedSize:
    MaterialStateProperty.all<Size>(const Size.fromWidth(double.maxFinite)),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(width: 2, color: Colors.white)),
  ),
);

TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      fixedSize:
      MaterialStateProperty.all<Size>(const Size.fromWidth(double.maxFinite)),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
          textStyleButton.copyWith(color: Colors.green)),
    ));


    ElevatedButtonThemeData roundedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
    minimumSize:  MaterialStateProperty.all<Size>(const Size(10, 50)),
    maximumSize:  MaterialStateProperty.all<Size>(const Size(10, 50)),
      fixedSize:
      MaterialStateProperty.all<Size>(const Size.fromWidth(double.maxFinite)),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
          textStyleButton.copyWith(color: Colors.green)),
    )
    );
