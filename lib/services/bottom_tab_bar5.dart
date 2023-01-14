import 'package:colab/services/container2.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../theme/text_styles.dart';


class BottomTabBar5 extends StatefulWidget {
  const BottomTabBar5({Key? key, this.locationName, this.subLocationName, this.subSubLocationName}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final locationName;
  // ignore: prefer_typing_uninitialized_variables
  final subLocationName;
  // ignore: prefer_typing_uninitialized_variables
  final subSubLocationName;
  @override
  State<BottomTabBar5> createState() => _BottomTabBarState5();
}

class _BottomTabBarState5 extends State<BottomTabBar5> {
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
    return 
    Container(
      margin: const EdgeInsets.only(top: 150),
      color: Colors.transparent,
      height: 150,
      child: Column(
        children:[
        CustomContainer3(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Center(child: Text(" ${widget.locationName} / ${widget.subLocationName} / ${widget.subSubLocationName}",style: textStyleBodyText1.copyWith(color: AppColors.white,))),
                ]
              )
            ),]),),
           const SizedBox(height: 10,),
           Container(
             margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors:[AppColors.white,AppColors.white,],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
            color: Colors.transparent,
            boxShadow: [
          ],
          ),
          labelStyle: textStyleTabLabel,
          labelColor:AppColors.primary,
          unselectedLabelStyle: textStyleTabLabel,
          unselectedLabelColor: Colors.black,
          isScrollable: true,
          tabs:  [
            Tab(
              child: Text("ONGOING",style:textStyleBodyText1 ,),
            ),
            Tab(
            child: Text("UPCOMING",style:textStyleBodyText1 ,),
            ),
            Tab(
              child: Text("COMPLETED",style:textStyleBodyText1 ,),
            ),
            Tab(
              child: Text("IN QUALITY",style:textStyleBodyText1 ,),
            ),
          ],
        ),
      ),])
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
