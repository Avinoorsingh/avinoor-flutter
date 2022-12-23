import 'dart:math';

import 'package:colab/constants/colors.dart';
import 'package:colab/network/client_project.dart';
import 'package:colab/views/ClosedSnags.dart';
import 'package:colab/views/newSnags.dart';
import 'package:colab/views/openedSnags.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/bottom_tab_bar.dart';
import '../services/helper/dependency_injector.dart';

GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class Snags extends StatefulWidget {
  const Snags({Key? key}) : super(key: key);

  @override
  State<Snags> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<Snags> {
  
    @override
  void initState() {
    super.initState(); 
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
 
   void clearCache()async{
    EasyLoading.show();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
       // ignore: use_build_context_synchronously
       context.pushNamed('LOGINPAGE');
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
      title: Text("Snags",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
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