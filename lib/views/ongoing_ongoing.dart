import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/services/bottom_tab_bar4.dart';
import 'package:colab/services/bottom_tab_bar5.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:colab/views/completed_inside_ongoing.dart';
import 'package:colab/views/inquality_inside_ongoing.dart';
import 'package:colab/views/ongoing_inside_ongoing.dart';
import 'package:colab/views/upcoming_inside_ongoing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: non_constant_identifier_names
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class OnGoingOnGoingScreen extends StatefulWidget {
  const OnGoingOnGoingScreen({Key? key}) : super(key: key);

  @override
  State<OnGoingOnGoingScreen> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<OnGoingOnGoingScreen> {
  
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
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("ON GOING",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
        key: ScaffoldStateKey,
        body: TabBarView(
                key: Key(Random().nextInt(1000).toString()),
                physics:const NeverScrollableScrollPhysics(),
                children:const [
                OnGoingInsideOnGoing(),
                UpComingInsideOnGoing(),
                CompletedInsideOngoing(),
                InQualityInsideOnGoing(),
                ],
              ),
        floatingActionButton: const Visibility(
          visible: true,
          child: BottomTabBar5(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop),
    );
  }}