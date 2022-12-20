import 'package:colab/services/bottom_tab_bar2.dart';
import 'package:colab/views/closed_desnags.dart';
import 'package:colab/views/new_deSnags.dart';
import 'package:colab/views/opened_de_snags.dart';
import 'package:go_router/go_router.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/helper/dependency_injector.dart';
GlobalKey<ScaffoldState> ScaffoldStateKey = GlobalKey<ScaffoldState>();

class DeSnags extends StatefulWidget {
  const DeSnags({Key? key}) : super(key: key);

  @override
  State<DeSnags> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<DeSnags> {
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
      title: Text("De-snags",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),

        key: ScaffoldStateKey,
        body:  const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                NewDeSnag(),
                OpenedDeSnags(),
                ClosedDeSnags(),
                ],
              ),
        floatingActionButton: const Visibility(
          visible: true,
          child: BottomTabBar2(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop),
    );
  }}