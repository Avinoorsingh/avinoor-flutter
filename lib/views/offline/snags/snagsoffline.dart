import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/views/closed_snags.dart';
import 'package:colab/views/offline/snags/snags/closed_snags_offline.dart';
import 'package:colab/views/offline/snags/snags/new_snags_offline.dart';
import 'package:colab/views/offline/snags/snags/opened_snags_offline.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../services/bottom_tab_bar.dart';

// ignore: non_constant_identifier_names
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class SnagsOffline extends StatefulWidget {
  const SnagsOffline({Key? key}) : super(key: key);

  @override
  State<SnagsOffline> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<SnagsOffline> {
  
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
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("SnagsOffline",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
        key: ScaffoldStateKey,
        body: TabBarView(
                key: Key(Random().nextInt(1000).toString()),
                physics:const NeverScrollableScrollPhysics(),
                children:const [
                NewSnagOffline(),
                OpenedSnagsOffline(),
                ClosedSnagsOffline(),
                ],
              ),
        floatingActionButton:const Visibility(
          visible: true,
          child: BottomTabBar(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop),
    );
  }}