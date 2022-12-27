import 'package:colab/network/quality_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../theme/text_styles.dart';


class BottomTabBar3 extends StatefulWidget {
  const BottomTabBar3({Key? key}) : super(key: key);

  @override
  State<BottomTabBar3> createState() => _BottomTabBarState3();
}

class _BottomTabBarState3 extends State<BottomTabBar3> {
   final getNewCheckList = Get.find<GetNewCheckList>();
   final getOpenedCheckList=Get.find<GetOpenedCheckList>();
   final getClosedCheckList=Get.find<GetClosedCheckList>();
   final signInController=Get.find<SignInController>();

@override
void initState(){
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.all(10),
      color: Colors.transparent,
      height: 65,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors:[AppColors.white,AppColors.white,],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                spreadRadius: 1),
          ],
        ),
        child: TabBar(
          onTap: (int i) {
            setState(() {});
          },  
          padding: const EdgeInsets.all(0),
          controller: DefaultTabController.of(context),
          indicator: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: Color.fromRGBO(255, 192, 0, 1),
            boxShadow: [
          ],
          ),
          labelStyle: textStyleTabLabel,
          labelColor:Colors.black,
          unselectedLabelStyle: textStyleTabLabel,
          unselectedLabelColor: Colors.black,
          tabs:  [
            Tab(
              child: Text("CLOSED",style:textStyleBodyText2 ,),
            ),
            Tab(
            child: Text("NEW",style:textStyleBodyText2 ,),
            ),
            Tab(
              child: Text("OPEN",style:textStyleBodyText2 ,),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customBottomTabWidget(String iconPath, String tabLabel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(iconPath),
            height: 18,
            width: 18,
          ),
          const SizedBox(width: 5),
          Text(tabLabel),
        ],
      ),
    ],
  );
}
