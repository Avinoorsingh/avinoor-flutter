import 'package:colab/models/sub_location_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';

class SubLocation extends StatefulWidget {
   final Function(String,String)? onChanged;
   const SubLocation({Key? key,this.onChanged}) : super(key: key);
  @override
  _SubLocationState createState() => _SubLocationState();
}

class _SubLocationState extends State<SubLocation> {
  @override
  Widget build(BuildContext context) {
     return GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
      List<String> subLocation=[];
      var subSubLocation=[];
       if(signInController.getSubLocationList!.data!.isNotEmpty && subLocation.isEmpty){
        List<SubLocationData>? subLocationList=signInController.getSubLocationList?.data;
        for(var data in subLocationList!){
          subLocation.add(data.subLocationName!);
          subSubLocation.add(data.subSubLocationInfo);
        }
      }
    return Scaffold(
      body: ListView.builder(
        itemCount: subLocation.length,
        itemBuilder: (context, i) {
          // for(int i=0;i<subSubLocation.length;i++){
          // for(var data in subSubLocation[3]){
          //   subSubLocation2.add(data.subSubLocationName);
          // }
          // break;
        // }
          return ExpansionTile(
            title: Text(subLocation[i], style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,),),
            children: <Widget>[
              Column(
                children: [ 
                  if(subSubLocation[i].isNotEmpty)
                  for(int j=0;j<subSubLocation[i].length;j++)...{
                  ListTile(
                    onTap: () {
                    Navigator.pop(context,"${subLocation[i]}/${subSubLocation[i][j].subSubLocationName}?${subSubLocation[i][j].subLocationId}&${subSubLocation[i][j].clientId}*${subSubLocation[i][j].projectId}#${subSubLocation[i][j].locationId}:${subSubLocation[i][j].subLocId}@");
                    },
                    title: Text(subSubLocation[i][j].subSubLocationName, style: const TextStyle(fontSize: 12.0,color: Colors.black54),),
                  ),
              }],
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