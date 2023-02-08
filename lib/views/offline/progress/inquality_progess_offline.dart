import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../theme/text_styles.dart';

class InQualityProgressOffline extends StatefulWidget {
  const InQualityProgressOffline({Key? key,}) : super(key: key);

  @override
  State<InQualityProgressOffline> createState() => GetCompletedProgressDaState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class GetCompletedProgressDaState extends State<InQualityProgressOffline> {
 
 @override
 void initState(){
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return 
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 90),
    child: Center(child: Text("Work in progress",style: textStyleBodyText1.copyWith(color: AppColors.grey),),)
),
);
}
}