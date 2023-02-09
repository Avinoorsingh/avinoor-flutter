import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/services/bottom_tab_bar4.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:colab/views/offline/progress/completed_site_progress_offline.dart';
import 'package:colab/views/offline/progress/inquality_progess_offline.dart';
import 'package:colab/views/offline/progress/upcoming_progress_offline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'ongoing_progress_offline.dart';

// ignore: non_constant_identifier_names
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class ActivityProgressOffline extends StatefulWidget {
  const ActivityProgressOffline({Key? key}) : super(key: key);

  @override
  State<ActivityProgressOffline> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityProgressOffline> {
  
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
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
        title: Text("Site Progress Offline",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
        ),
        key: ScaffoldStateKey,
        body: TabBarView(
                key: Key(Random().nextInt(1000).toString()),
                physics:const NeverScrollableScrollPhysics(),
                children:const [
                CompletedSiteProgressOffline(),
                OnGoingProgressOffline(),
                InQualityProgressOffline(),
                UpComingProgressOffline(),
                ],
              ),
        floatingActionButton: const Visibility(
          visible: true,
          child: BottomTabBar4(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop),
    );
  }}