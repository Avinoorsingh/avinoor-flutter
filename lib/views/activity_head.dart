import 'package:colab/models/activity_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';

class ActivityHeadPage extends StatefulWidget {
   final Function(String,String)? onChanged;
   const ActivityHeadPage({Key? key,this.onChanged}) : super(key: key);
  @override
  _ActivityHeadPageState createState() => _ActivityHeadPageState();
}

class _ActivityHeadPageState extends State<ActivityHeadPage> {
  @override
  Widget build(BuildContext context) {
     return GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
      List<String> activityHead=[];
      var activityHeadActivity=[];
      var subSubLocationName=[];
       if(signInController.getActivityHeadList!.data!.isNotEmpty && activityHead.isEmpty){
        List<ACData>? subLocationList=signInController.getActivityHeadList?.data;
        for(var data in subLocationList!){
          activityHead.add(data.activityHead!);
          activityHeadActivity.add(data.subActivity);
        }
      }
    return Scaffold(
      body: ListView.builder(
        itemCount: activityHead.length,
        itemBuilder: (context, i) {
          var subSubLocation2=[];
          return ExpansionTile(
            title: Text(activityHead[i], style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,),),
            children: <Widget>[
              Column(
                children: [ 
                  if(activityHeadActivity[i].isNotEmpty)
                  for(int j=0;j<activityHeadActivity[i].length;j++)...{
                  ListTile(
                    onTap: () {
                    Navigator.pop(context,"${activityHead[i]}/${activityHeadActivity[i][j].activity}}${activityHeadActivity[i][j].linkingActivityId}:");
                    },
                    title: Text(activityHeadActivity[i][j].activity, style: const TextStyle(fontSize: 12.0,color: Colors.black54),),
                  ),
              }
              ],
              ),
            ],
          );
        },
      ),
    );
  }
     );
  }

  _buildExpandableContent( vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents) {
      columnContent.add(
        ListTile(
          onTap: () {
           Navigator.pop(context,content);
          },
          title: Text(content, style: const TextStyle(fontSize: 12.0,color: Colors.black54),),
        ),
      );
    }

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];

  Vehicle(this.title, this.contents,);
}

List<Vehicle> vehicles = [
  Vehicle(
    'Bike',
    ['Vehicle no. 1', 'Vehicle no. 2', 'Vehicle no. 7', 'Vehicle no. 10'],
  ),
  Vehicle(
    'Cars',
    ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
  ),
];