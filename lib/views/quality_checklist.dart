import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/services/bottom_tab_bar3.dart';
import 'package:colab/views/closed_quality_checklist.dart';
import 'package:colab/views/new_quality_checklist.dart';
import 'package:colab/views/opened_quality_checklist.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: non_constant_identifier_names
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class QualityCheckList extends StatefulWidget {
  const QualityCheckList({Key? key}) : super(key: key);

  @override
  State<QualityCheckList> createState() => _QualityPageState();
}

class _QualityPageState extends State<QualityCheckList> {
  
    @override
  void initState() {
    super.initState(); 
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }

  bool iconPressed=false;
  @override
  Widget build(BuildContext context) {
    return
    DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Quality Control",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
        key: ScaffoldStateKey,
        body: TabBarView(
                key: Key(Random().nextInt(1000).toString()),
                physics:const NeverScrollableScrollPhysics(),
                children:const [
                ClosedQualityCheckList(),
                NewQualityCheckList(),
                OpenedCheckList(),
                ],
              ),
        floatingActionButton: const Visibility(
          visible: true,
          child: BottomTabBar3(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop),
    );
  }}