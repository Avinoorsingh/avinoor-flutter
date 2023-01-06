import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:colab/models/progress_sublocation_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../models/progress_subSublocation_data.dart';
import '../network/client_project.dart';

class SubLocationProgress extends StatefulWidget {
   final Function(String,String)? onChanged;
   const SubLocationProgress({Key? key,this.onChanged, this.locID}) : super(key: key);
   final locID;
  @override
  // ignore: library_private_types_in_public_api
  _SubLocationState createState() => _SubLocationState();
}

class _SubLocationState extends State<SubLocationProgress> {
   List<String> subSubLocation=[];
   List<String> subSubLocationID=[];
   TextEditingController clientIDController=TextEditingController();
   TextEditingController projectIDController=TextEditingController();
   List<bool> _isExpanded= [];

  @override
  Widget build(BuildContext context) {
     return GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
      List<String> subLocation=[];
      var subLocationID=[];
       if(signInController.getProgressSubLocationData!.data!.isNotEmpty && subLocation.isEmpty){
        List<ProgressSubLocationListData>? subLocationList=signInController.getProgressSubLocationData!.data;
        for(var data in subLocationList!){
          subLocation.add(data.subLocationName!);
          subLocationID.add(data.subLocId.toString());
        }
      }
    return Scaffold(
      body: ListView.builder(
        itemCount: subLocation.length,
        itemBuilder: (context, i) {
          for(int i=0;i<subLocation.length;i++){
            _isExpanded.add(false);
          }
          return ExpansionTile(
            onExpansionChanged: (bool b)async{
              if(b==true){
                  subSubLocation.clear();
                  subSubLocationID.clear();
                {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    var token=sharedPreferences.getString('token');
                    var projectID=sharedPreferences.getString('projectIdd');
                    var clientID=sharedPreferences.getString('client_id');
                    clientIDController.text=clientID!;
                    projectIDController.text=projectID!;
                    try {
                    var getSubSubLocationListUrl=Uri.parse(Config.getProgressSubSubLocationListApi);
                    var res=await http.post(
                    getSubSubLocationListUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                              "client_id":clientID,
                              "project_id":projectID,
                              "location_id":widget.locID,
                              "sub_loc_id":subLocationID[i]
                            }
                        );
                  Map<String,dynamic> cData3=jsonDecode(res.body);
                  ProgressSubSubLocationData result3=ProgressSubSubLocationData.fromJson(cData3);
                  if(result3.data!.isNotEmpty){
                    for(int i=0;i<result3.data!.length;i++){
                      subSubLocation.add(result3.data![i].subSubLocationName!);
                      subSubLocationID.add(result3.data![i].subLocationId.toString());
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
            title: Text(subLocation[i], style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,),),
            children: [
                  ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subSubLocation.length,
                  itemBuilder: (context, j) {
                    return
                   ListTile(
                    onTap: () {
                      Navigator.pop(context,"${subLocation[i]}/${subSubLocation[j]}?${subSubLocationID[j]}&${clientIDController.text}*${projectIDController.text}#${widget.locID}:${subLocationID[i]}@");
                    },
                    title: Text(subSubLocation.isNotEmpty?subSubLocation[j].toString():"", style: const TextStyle(fontSize: 14.0,color: Colors.black54),),
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