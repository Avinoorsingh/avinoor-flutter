import 'package:flutter/material.dart';
import '../theme/text_styles.dart';


class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
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
              colors: [Colors.white,Colors.white,],
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
            BoxShadow(
                color: Colors.black,
                spreadRadius: 1),
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
              child: Text("NEW",style:textStyleBodyText1 ,),
            ),
            Tab(
            child: Text("IN REVIEW",style:textStyleBodyText1 ,),
            ),
            Tab(
              child: Text("CLOSED",style:textStyleBodyText1 ,),
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
