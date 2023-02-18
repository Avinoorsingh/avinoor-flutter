import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/services/bottom_tab_bar5.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:colab/views/offline/progress/ongoing_screens/completed_inside_ongoing_offline.dart';
import 'package:colab/views/offline/progress/ongoing_screens/upcoming_inside_ongoing_offline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../completed_site_progress_offline.dart';
import 'ongoing_inside_ongoing_offline.dart';

// ignore: non_constant_identifier_names
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class OnGoingOnGoingOfflineScreen extends StatefulWidget {
  const OnGoingOnGoingOfflineScreen({Key? key, this.cID,this.pID,this.locID, this.subLocID, this.subSubLocID, this.locationName, this.subLocationName, this.subSubLocationName}) : super(key: key);
  
  // ignore: prefer_typing_uninitialized_variables
  final cID;
  // ignore: prefer_typing_uninitialized_variables
  final pID;
  // ignore: prefer_typing_uninitialized_variables
  final locID;
  // ignore: prefer_typing_uninitialized_variables
  final subLocID;
  // ignore: prefer_typing_uninitialized_variables
  final subSubLocID;
  // ignore: prefer_typing_uninitialized_variables
  final locationName;
  // ignore: prefer_typing_uninitialized_variables
  final subLocationName;
  // ignore: prefer_typing_uninitialized_variables
  final subSubLocationName;
  @override
  State<OnGoingOnGoingOfflineScreen> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<OnGoingOnGoingOfflineScreen> {


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
      title: Text("ON GOING", style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
        key: ScaffoldStateKey,
        body: TabBarView(
                key: Key(Random().nextInt(1000).toString()),
                physics:const NeverScrollableScrollPhysics(),
                children: [
                CompletedInsideOnGoingOffline(
                  cID: widget.cID,
                  pID: widget.pID,
                  locID: widget.locID,
                  subLocID: widget.subLocID,
                  subSubLocID: widget.subSubLocID,
                ),
                OnGoingInsideOnGoingOffline(
                  cID: widget.cID,
                  pID: widget.pID,
                  locID: widget.locID,
                  subLocID: widget.subLocID,
                  subSubLocID: widget.subSubLocID,
                ),
                 const CompletedSiteProgressOffline(),
                UpComingInsideOngoingOffline(
                  cID: widget.cID,
                  pID: widget.pID,
                  locID: widget.locID,
                  subLocID: widget.subLocID,
                  subSubLocID: widget.subSubLocID,
                ),
                ],
              ),
        floatingActionButton: Visibility(
          visible: true,
          child: BottomTabBar5(locationName: widget.locationName, subLocationName: widget.subLocationName, subSubLocationName: widget.subSubLocationName,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop),
    );
  }
}