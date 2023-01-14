import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/services/bottom_tab_bar5.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:colab/views/completed_inside_ongoing.dart';
import 'package:colab/views/inquality_inside_ongoing.dart';
import 'package:colab/views/ongoing_inside_ongoing.dart';
import 'package:colab/views/upcoming_inside_ongoing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../network/onGoingSiteProgress/ongoing_site_network.dart';

// ignore: non_constant_identifier_names
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class OnGoingOnGoingScreen extends StatefulWidget {
  const OnGoingOnGoingScreen({Key? key, this.cID,this.pID,this.locID, this.subLocID, this.subSubLocID, this.locationName, this.subLocationName, this.subSubLocationName}) : super(key: key);
  
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
  State<OnGoingOnGoingScreen> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<OnGoingOnGoingScreen> {
   final getDataController=Get.find<GetOnGoingDetail>();
  
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
                children: [
                OnGoingInsideOnGoing(
                  cID: widget.cID,
                  pID: widget.pID,
                  locID: widget.locID,
                  subLocID: widget.subLocID,
                  subSubLocID: widget.subSubLocID,
                ),
                 UpComingInsideOnGoing(
                  cID: widget.cID,
                  pID: widget.pID,
                  locID: widget.locID,
                  subLocID: widget.subLocID,
                  subSubLocID: widget.subSubLocID,
                ),
                 CompletedInsideOngoing(
                  cID: widget.cID,
                  pID: widget.pID,
                  locID: widget.locID,
                  subLocID: widget.subLocID,
                  subSubLocID: widget.subSubLocID,
                 ),
                const InQualityInsideOnGoing(),
                ],
              ),
        floatingActionButton: Visibility(
          visible: true,
          child: BottomTabBar5(locationName: widget.locationName, subLocationName: widget.subLocationName, subSubLocationName: widget.subSubLocationName,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop),
    );
  }}