
import 'package:colab/constants/colors.dart';
import 'package:colab/network/client_project.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../controller/signInController.dart';
import '../theme/text_styles.dart';


class BottomTabBar2 extends StatefulWidget {
  const BottomTabBar2 ({Key? key}) : super(key: key);

  @override
  State<BottomTabBar2 > createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar2 > {
   final getSnag = Get.find<GetNewDeSnag>();
   final getOpenedSnag=Get.find<GetOpenedDeSnag>();
   final getClosedSnag=Get.find<GetClosedDeSnag>();
   final signInController=Get.find<SignInController>();
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
          borderRadius:BorderRadius.all(Radius.circular(40)),
          boxShadow:[
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
            color: AppColors.primary,
            boxShadow: [
            // BoxShadow(
            //     color: Colors.black,
            //     spreadRadius: 1),
          ],
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.25),
            //     offset: const Offset(0, 4),
            //     blurRadius: 1,
            //   ),
            // ],
          ),
          labelStyle: textStyleTabLabel,
          labelColor:Colors.black,
          unselectedLabelStyle: textStyleTabLabel,
          unselectedLabelColor: Colors.black,
          tabs:  [
            Tab(
              child: Text("NEW",style:textStyleBodyText2 ,),
            ),
            Tab(
            child: Text("IN REVIEW",style:textStyleBodyText2 ,),
            ),
            Tab(
              child: Text("CLOSED",style:textStyleBodyText2 ,),
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
