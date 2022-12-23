import 'package:flutter/material.dart';
import 'package:colab/theme/text_styles.dart';

import '../constants/colors.dart';

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
//   labelStyle: textStyleInputLabel.copyWith(color: AppColors.white),
//   border:
//       const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
//   enabledBorder: UnderlineInputBorder(
//       borderSide: BorderSide(color: AppColors.white.withOpacity(0.5))),
//   focusedBorder:
//       const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
// );

InputDecoration otpInputDecoration = InputDecoration(
  counterText: '',
  floatingLabelBehavior: FloatingLabelBehavior.never,
  filled: true,
  fillColor: AppColors.white.withOpacity(0.4),
  border: InputBorder.none,
  contentPadding: const EdgeInsets.symmetric(vertical: 20),

);
