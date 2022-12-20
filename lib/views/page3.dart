import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';

class ProjectLevelPage3 extends StatefulWidget {
  const ProjectLevelPage3 ({Key? key}) : super(key: key);

  @override
  State<ProjectLevelPage3 > createState() => _ProjectLevelPage3State();
}

class _ProjectLevelPage3State extends State<ProjectLevelPage3> {
  List<String> itemNames=[
    "VIEW DPR",
    "VIEW STOCK CONSUMPTION",
    "VIEW LABOUR TREND",
    "VIEW RESOURCE REQUESTS",
    "VIEW DIRECTORY",
  ];

  List<Color> itemBackGroundColors=[
    const Color.fromRGBO(218,227,244,1),
    const Color.fromRGBO(254, 248, 224,1),
    const Color.fromRGBO(248,202,169,1),
    const Color.fromRGBO(190,227,149,1),
    const Color.fromRGBO(190,227,149,1),
  ];

  List<String> items = [
    "assets/images/activity_task_img.png",
    "assets/images/construction_img.png",
    "assets/images/design_task_img.png",
    "assets/images/liasonning_task_img.png",
    "assets/images/liasonning_task_img.png",
  ];

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children:[
            Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return 
                FittedBox(
                          fit: BoxFit.fitWidth,
                          child: 
                          Center(
                            child: 
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Card(
                              margin:const EdgeInsets.only(bottom: 10),
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 5,
                              child:
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                  decoration:  BoxDecoration(
                                    color: itemBackGroundColors[index],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                height: 85,
                                width: 335,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(itemNames[index],style: textStyleHeadline4.copyWith(fontSize: 14),)
                                  ],),
                            )),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              child: 
                                Card(
                                    margin:const EdgeInsets.only(bottom: 10),
                                    clipBehavior: Clip.none,
                                      shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 5,
                              child:
                              Container(
                                alignment: Alignment.topLeft,
                                height: 85,
                                width: 60,
                                  // margin: const EdgeInsets.all(3),
                                  decoration:  BoxDecoration(
                                    color:  itemBackGroundColors[index],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: 
                                  Image.asset(items[index].toString(),
                                  height: 40,
                                  width: 40,
                                  ),
                              )
                                  )
                              ),
                              ),
                          ],
                        ),
                          )
                        );
                    }
                  )
                ),
          ]
      );
  }
}