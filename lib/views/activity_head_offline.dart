import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signInController.dart';

class ActivityHeadOffline extends StatefulWidget {
   final Function(String,String)? onChanged;
   const ActivityHeadOffline({Key? key,this.onChanged}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ActivityHeadPageState createState() => _ActivityHeadPageState();
}

class _ActivityHeadPageState extends State<ActivityHeadOffline> {
  @override
  Widget build(BuildContext context) {
      final signInController=Get.find<SignInController>();
      List<String> activityHead=[];
      List<String> activityID=[];
      var activityHeadActivity=[];
       if(signInController.getActivityHeadList!.isNotEmpty && activityHead.isEmpty){
        var subLocationList=signInController.getActivityHeadList;
          for(var data2 in subLocationList[0]){
          activityHead.add(data2.activityHead);
          activityHeadActivity.add(subLocationList[0]);
          activityID.add(data2.activity);
          }
      }
    return Scaffold(
      body: ListView.builder(
        itemCount: activityHeadActivity.length,
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
}
