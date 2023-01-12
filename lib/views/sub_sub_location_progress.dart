import 'dart:convert';
import 'package:colab/models/progress_activityHead_data.dart';
import 'package:colab/models/progress_activity_data.dart';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';

class SubSubLocationProgress extends StatefulWidget {
   final Function(String,String)? onChanged;
   const SubSubLocationProgress({Key? key,this.onChanged, this.locID, this.subLocID, this.subSubLocID}) : super(key: key);
   final locID;
   final subLocID;
   final subSubLocID;
  @override
  // ignore: library_private_types_in_public_api
  _activityHeadState createState() => _activityHeadState();
}

class _activityHeadState extends State<SubSubLocationProgress> {
   List<String> subactivityHead=[];
   List<String> subactivityHeadID=[];
   TextEditingController clientIDController=TextEditingController();
   TextEditingController projectIDController=TextEditingController();
   final List<bool> _isExpanded= [];

  @override
  Widget build(BuildContext context) {
     return GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
      List<String> activityHead=[];
      var activityID=[];
       if(signInController.getProgressActivityHeadApi!.data!.isNotEmpty && activityHead.isEmpty){
        List<ProgressActivityHeadDataList>? activityHeadList=signInController.getProgressActivityHeadApi!.data;
        for(var data in activityHeadList!){
          activityHead.add(data.activityHead!);
          activityID.add(data.activityId.toString());
        }
      }
    return Scaffold(
      body: ListView.builder(
        itemCount: activityHead.length,
        itemBuilder: (context, i) {
          for(int i=0;i<activityHead.length;i++){
            _isExpanded.add(false);
          }
          return ExpansionTile(
            onExpansionChanged: (bool b)async{
              if(b==true){
                  subactivityHead.clear();
                  subactivityHeadID.clear();
                {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    var token=sharedPreferences.getString('token');
                    var projectID=sharedPreferences.getString('projectIdd');
                    var clientID=sharedPreferences.getString('client_id');
                    clientIDController.text=clientID!;
                    projectIDController.text=projectID!;
                    try {
                    var getactivityListUrl=Uri.parse(Config.getProgressActivityListApi);
                    var res=await http.post(
                    getactivityListUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                              "client_id":clientID,
                              "project_id":projectID,
                              "location_id":widget.locID,
                              "sub_loc_id":widget.subLocID,
                              "sub_sub_loc_id":widget.subSubLocID,
                              "activity_id":activityID[i],
                            }
                        );
                  Map<String,dynamic> cData3=jsonDecode(res.body);
                  ProgressActivityData result3=ProgressActivityData.fromJson(cData3);
                  if(result3.projectActivityHead!.isNotEmpty){
                    for(int i=0;i<result3.projectActivityHead!.length;i++){
                      subactivityHead.add(result3.projectActivityHead![i].activity!);
                      subactivityHeadID.add(result3.projectActivityHead![i].linkingActivityId.toString());
                    }
                  }
                  setState(() {});
                  } catch (e) {
                    if (kDebugMode) {
                    print(e);
                  }
                }
                    }
              }
           },
            title: Text(activityHead[i], style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,),),
            children: [
                  ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subactivityHead.length,
                  itemBuilder: (context, j) {
                    return
                   ListTile(
                    onTap: () {
                       Navigator.pop(context,"${activityHead[i]}/${subactivityHead[j]}}${subactivityHeadID[j]}:${activityID[i]}|");
                    },
                    title: Text(subactivityHead.isNotEmpty?subactivityHead[j].toString():"", style: const TextStyle(fontSize: 14.0,color: Colors.black54),),
                  );
                  }
                  )
            ],
          );
        },
      ),
    );
  }
);
}
}