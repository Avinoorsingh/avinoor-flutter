import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/views/closed_snags.dart';
import 'package:colab/views/new_snags.dart';
import 'package:colab/views/opened_snags.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../network/client_project.dart';
import '../services/bottom_tab_bar.dart';

// ignore: non_constant_identifier_names
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class Snags extends StatefulWidget {
  const Snags({Key? key}) : super(key: key);

  @override
  State<Snags> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<Snags> {
  final getNewSnagDataController=Get.find<GetNewSnag>();
  final getOpenedSnagDataController=Get.find<GetOpenedSnag>();
  final getClosedSnagDataController=Get.find<GetClosedSnag>();
  
    @override
  void initState() {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    getSnags();
    super.initState(); 
  }

  getSnags() async {
    await getNewSnagDataController.getSnagData(context: context);
    setState(() {});
  }

  @override
  void dispose(){
    super.dispose();
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
      title: Text("Snags", style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
        key: ScaffoldStateKey,
        body: TabBarView(
                key: Key(Random().nextInt(1000).toString()),
                physics:const NeverScrollableScrollPhysics(),
                children:const [
                NewSnag(),
                OpenedSnags(),
                ClosedSnags(),
                ],
              ),
        floatingActionButton: const Visibility(
          visible: true,
          child: BottomTabBar(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop),
    );
  }}