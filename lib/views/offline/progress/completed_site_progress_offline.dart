import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../theme/text_styles.dart';

class CompletedSiteProgressOffline extends StatefulWidget {
  const CompletedSiteProgressOffline({Key? key,}) : super(key: key);

  @override
  State<CompletedSiteProgressOffline> createState() => _CompletedSiteProgressState();
}

bool show=false;

class _CompletedSiteProgressState extends State<CompletedSiteProgressOffline> {
 
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
    child: Center(child: Text("Work in progress",style: textStyleBodyText1.copyWith(color: AppColors.lightGrey),),)
),
);
}
}