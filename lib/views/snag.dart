import 'dart:async';
import 'dart:io';
import 'package:colab/views/ClosedSnags.dart';
import 'package:colab/views/newSnags.dart';
import 'package:colab/views/openedSnags.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../services/bottom_tab_bar.dart';
import '../services/helper/dependency_injector.dart';
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class Snags extends StatefulWidget {
  const Snags({Key? key}) : super(key: key);

  @override
  State<Snags> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<Snags> {
  final fullNameController = TextEditingController();
  final emergencyContactPersonController = TextEditingController();
  final emergencyContactMobileNumberController = TextEditingController();
  final emergencyAlternateMobileNumberController= TextEditingController();
  
    @override
  void initState() {
    super.initState(); 
    DependencyInjector.initializeControllers();
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
        backgroundColor: const Color.fromRGBO(255, 192, 0, 1),
      title: Text("Snags",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),

        key: ScaffoldStateKey,
        body:  const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
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