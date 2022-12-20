import 'package:flutter/material.dart';
import 'package:colab/theme/text_styles.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  labelStyle: textStyleInputLabel,
);

InputDecoration lightTextInputDecoration = const InputDecoration(
  prefixIcon: Padding(
    padding: EdgeInsets.all(5.0),
  ),
  prefixIconConstraints: BoxConstraints(maxHeight: 34, maxWidth: 34),
);

// InputDecoration darkTextInputDecoration = InputDecoration(
//   prefixIcon: const Padding(
//     padding: EdgeInsets.all(5.0),
//   ),
//   prefixIconConstraints: const BoxConstraints(maxHeight: 34, maxWidth: 34),
//   labelStyle: textStyleInputLabel.copyWith(color: Colors.white),
//   border:
//       const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//   enabledBorder: UnderlineInputBorder(
//       borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
//   focusedBorder:
//       const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
// );

InputDecoration otpInputDecoration = InputDecoration(
  counterText: '',
  floatingLabelBehavior: FloatingLabelBehavior.never,
  filled: true,
  fillColor: Colors.white.withOpacity(0.4),
  border: InputBorder.none,
  contentPadding: const EdgeInsets.symmetric(vertical: 20),

);
