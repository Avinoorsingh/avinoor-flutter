import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProjectLevelPage2 extends StatefulWidget {
  const ProjectLevelPage2 ({Key? key}) : super(key: key);

  @override
  State<ProjectLevelPage2 > createState() => _ProjectLevelPage1State();
}

class _ProjectLevelPage1State extends State<ProjectLevelPage2 > {
  List<String> itemNames=[
    "ACTIVITY TASK",
    "NON CONSTRUCTION TASKS",
    "DESIGN RELATED TASKS",
    "LAISONING TASKS"
  ];

  List<Color> itemBackGroundColors=[
    const Color.fromRGBO(218,227,244,1),
    const Color.fromRGBO(254, 248, 224,1),
    const Color.fromRGBO(248,202,169,1),
    const Color.fromRGBO(190,227,149,1)
  ];

  List<String> items = [
    "assets/images/activity_task_img.png",
    "assets/images/construction_img.png",
    "assets/images/design_task_img.png",
    "assets/images/liasonning_task_img.png",
  ];

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children:[
      Center(
        child: Container(
                     padding: const EdgeInsets.only(top: 8,bottom: 8),
                     child: CircularPercentIndicator( //circular progress indicator
                      startAngle: 270,
                      radius: 50.0, //radius for circle
                      lineWidth: 12.0, //width of circle line
                      animation: false, //animate when it shows progress indicator first
                      percent: 80/100, //vercentage value: 0.6 for 60% (60/100 = 0.6)
                      center: const Text("80%",style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25.0),
                      ), //center text, you can set Icon as well/footer text 
                      backgroundColor: Colors.white, //backround of progress bar//corner shape of progress bar at start/end
                      progressColor: const Color.fromARGB(255, 29, 51, 88), //progress bar color
                    )
                  ),
            ),
            Padding(padding: const EdgeInsets.only(left: 10,right: 10),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
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
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 5,
                              child:
                              Container(
                                  decoration:  BoxDecoration(
                                    color: itemBackGroundColors[index],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                height: 70,
                                width: 335,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("        ${itemNames[index]}",style: textStyleHeadline4.copyWith(fontSize: 14),)
                                  ],),
                            )),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              child: 
                                Card(
                                    clipBehavior: Clip.none,
                                      shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 5,
                              child:
                              Container(
                                alignment: Alignment.topLeft,
                                height: 70,
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
                            Positioned(
                              top: 20,
                              bottom: 20,
                              left: 310,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child:  const Center(
                                  child: CircleAvatar(
                                    backgroundColor: Color.fromRGBO(239,247,253,1),
                                    radius: 22.0,
                                    child: Text("0",style: TextStyle(color: Colors.black),),
                                  ),
                                ),
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