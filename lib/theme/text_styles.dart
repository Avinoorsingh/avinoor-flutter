import 'package:flutter/material.dart';
import 'package:colab/theme/theme.dart';

TextStyle textStyleHeadline1 =
    const TextStyle(fontSize: 32, fontWeight: FontWeight.w700);

TextStyle textStyleHeadline2 =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 1.2);
TextStyle textStyleHeadline3 =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, height: 1.2);
TextStyle textStyleHeadline4 = const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold,);
TextStyle textStyleSubTitle1 =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

TextStyle textStyleSubTitle2 =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

TextStyle textStyleBodyText1 =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.3);

TextStyle textStyleBodyText2 =
    const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, height: 1.3);
TextStyle textStyleBodyText3 =
    const TextStyle(fontSize: 12, height: 1.3, color: Colors.grey);

TextStyle inCardText1 =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

TextStyle inCardText2 =
    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

TextStyle inCardHeadline =
    const TextStyle(fontSize: 28, fontWeight: FontWeight.w700);

TextStyle textStyleButton =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

TextStyle textStyleButton2 =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

TextStyle textStyleTextButton = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  decoration: TextDecoration.underline,
);

TextStyle textStyleTextButtonCompact = const TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

TextStyle textStyleInputLabel = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, color: inputLabelColor);
TextStyle textStyleTabContent = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w500, color: placeholderColor);

TextStyle otpStyleInputLabel = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w400, color: inputLabelColor);

TextStyle textStyleTabLabel = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w900, color: placeholderDarkColor);

getadaptiveTextSize(BuildContext context, dynamic value) {
  // 720 is medium screen height
  return (value / 720) * MediaQuery.of(context).size.height;
}
