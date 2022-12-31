import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../theme/text_styles.dart';


class BottomTabBar4 extends StatefulWidget {
  const BottomTabBar4({Key? key}) : super(key: key);

  @override
  State<BottomTabBar4> createState() => _BottomTabBarState4();
}

class _BottomTabBarState4 extends State<BottomTabBar4> {
  //  final getNewCheckList = Get.find<GetNewCheckList>();
  //  final getOpenedCheckList=Get.find<GetOpenedCheckList>();
  //  final getClosedCheckList=Get.find<GetClosedCheckList>();
  //  final signInController=Get.find<SignInController>();

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
          isScrollable: true,
          tabs:  [
            Tab(
              child: Text("COMPLETED",style:textStyleBodyText2 ,),
            ),
            Tab(
            child: Text("ON GOING",style:textStyleBodyText2 ,),
            ),
            Tab(
              child: Text("IN QUALITY",style:textStyleBodyText2 ,),
            ),
            Tab(
              child: Text("UPCOMING",style:textStyleBodyText2 ,),
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
