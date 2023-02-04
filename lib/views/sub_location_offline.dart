import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signInController.dart';

class SubLocationOffline extends StatefulWidget {
   final Function(String,String)? onChanged;
   const SubLocationOffline({Key? key,this.onChanged}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SubLocationState createState() => _SubLocationState();
}

class _SubLocationState extends State<SubLocationOffline> {
  @override
  Widget build(BuildContext context) {
      final signInController=Get.find<SignInController>();
      List<String> subLocationOffline=[];
      var subSubLocation=[];
       if(signInController.getSubLocationList.isNotEmpty && subLocationOffline.isEmpty){
        var subLocationList=signInController.getSubLocationList;
        for(var data in subLocationList!){
          subLocationOffline.add(data.subLocationName!);
          subSubLocation.add(data.subSubLocationInfo);
        }
      }
    return Scaffold(
      body: ListView.builder(
        itemCount: subLocationOffline.length,
        itemBuilder: (context, i) {
          return ExpansionTile(
            title: Text(subLocationOffline[i], style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,),),
            children: <Widget>[
              Column(
                children: [ 
                  if(subSubLocation[i].isNotEmpty)
                  for(int j=0;j<subSubLocation[i].length;j++)...{
                  ListTile(
                    onTap: () {
                    Navigator.pop(context,"${subLocationOffline[i]}/${subSubLocation[i][j].subSubLocationName}?${subSubLocation[i][j].subLocationId}&${1}*${1}#${subSubLocation[i][j].locationId}:${subSubLocation[i][j].subLocId}@");
                    },
                    title: Text(subSubLocation[i][j].subSubLocationName, style: const TextStyle(fontSize: 12.0,color: Colors.black54),),
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