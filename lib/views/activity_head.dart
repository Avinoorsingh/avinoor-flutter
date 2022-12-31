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
      List<String> activityID=[];
      var activityHeadActivity=[];
       if(signInController.getActivityHeadList!.data!.isNotEmpty && activityHead.isEmpty){
        List<ACData>? subLocationList=signInController.getActivityHeadList?.data;
        for(var data in subLocationList!){
          activityHead.add(data.activityHead!);
          activityHeadActivity.add(data.subActivity);
          activityID.add(data.activityId.toString());
        }
      }
    return Scaffold(
      body: ListView.builder(
        itemCount: activityHead.length,
        itemBuilder: (context, i) {
          return ExpansionTile(
            title: Text(activityHead[i], style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,),),
            children: <Widget>[
              Column(
                children: [ 
                  if(activityHeadActivity[i].isNotEmpty)
                  for(int j=0;j<activityHeadActivity[i].length;j++)...{
                  ListTile(
                    onTap: () {
                    Navigator.pop(context,"${activityHead[i]}/${activityHeadActivity[i][j].activity}}${activityHeadActivity[i][j].linkingActivityId}:${activityID[i]}|");
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
}