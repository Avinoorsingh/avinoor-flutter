import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../network/progress_network.dart';
import '../theme/text_styles.dart';

class InQualityProgress extends StatefulWidget {
  const InQualityProgress({Key? key,}) : super(key: key);

  @override
  State<InQualityProgress> createState() => GetCompletedProgressDaState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class GetCompletedProgressDaState extends State<InQualityProgress> {
  List<String?> locationName=[];
  List<int?> locationID=[];
  TextEditingController locationIDController=TextEditingController();
  List<String?> subLocationName=[];
  List<int?> subLocationID=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  int? selectedIndex=-1;
  int? selectedIndex1=-1;
  int? selectedIndex2=-1;
 
 @override
 void initState(){
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return 
    GetBuilder<GetInEqualitySiteProgress>(builder: (_){
      final signInController=Get.find<SignInController>();
      if(signInController.getInEqualityProgressData!=null){
        if(signInController.getInEqualityProgressData!.data!=null){
     if(signInController.getInEqualityProgressData!.data!.isNotEmpty && locationName.isEmpty){
      for(int i=0;i<signInController.getInEqualityProgressData!.data!.length;i++){
       locationName.add(signInController.getInEqualityProgressData!.data![i].locationName!);
       locationID.add(signInController.getInEqualityProgressData!.data![i].locationId!);
      }
     }
    }
    }
    EasyLoading.dismiss();
    return 
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 90),
    child:
    ListView(
      key: Key(selectedIndex.toString()),
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: locationName.length,
              key:Key(selectedIndex.toString()),
              itemBuilder: (BuildContext context, int index){
              return 
              Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                ),
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: 
                    ExpansionTile(
                    key:Key(selectedIndex.toString()),
                    initiallyExpanded: index == selectedIndex,
                    childrenPadding:const EdgeInsets.only(left: 10,right: 10),
                    tilePadding: const EdgeInsets.only(bottom: 20,left: 10),
                    collapsedBackgroundColor: AppColors.navyblue,
                    collapsedIconColor: Colors.transparent,
                    iconColor: Colors.transparent,
                    backgroundColor: AppColors.navyblue,
                    trailing: null,
                    maintainState: true,
                    title: Text('${locationName[index]}',style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 18),),
                    onExpansionChanged:
                    (bool t)async{
                    if(t==true){
                      setState(() {selectedIndex = index;});
                      subLocationName.clear();
                      subLocationID.clear();
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      var token=sharedPreferences.getString('token');
                      var projectID=sharedPreferences.getString('projectIdd');
                      var clientID=sharedPreferences.getString('client_id');
                        try {
                            locationIDController.text=locationID[index].toString();
                            var getCompletedProgressListUrl=Uri.parse("${Config.getSubLocationProgressApi}$clientID/${projectID??"1"}/${locationID[index].toString()}/INQ");
                            var res=await http.get(getCompletedProgressListUrl,
                                headers:{
                                "Accept": "application/json",
                                "Authorization": "Bearer $token",
                                },
                              );
                            var cData4=jsonDecode(res.body);
                            if(cData4!=null){
                                subLocationName.clear();
                                subLocationID.clear();
                                for(int i=0;i<cData4['data'].length;i++){
                                  subLocationName.add(cData4['data'][i]['sub_location_name']);
                                  subLocationID.add(cData4['data'][i]['sub_loc_id']);
                                  }
                                }
                              setState(() {});
                            }
                            catch(e){
                              if (kDebugMode) {
                                  print("Error");
                                  print(e);
                                }
                              }
                            }else{
                              setState(() {
                                selectedIndex=-1;
                            });
                          }},
                        children: [
                          ListView.builder(
                            key: Key(selectedIndex1.toString()),
                            shrinkWrap: true,
                            itemCount: subLocationName.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: AppColors.navyblue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                            child:
                              ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child:
                              ExpansionTile(
                              key:Key(selectedIndex1.toString()),
                              initiallyExpanded: index == selectedIndex1,
                              childrenPadding:const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                              tilePadding: const EdgeInsets.only(left: 10,),
                              collapsedBackgroundColor: AppColors.lightBlue,
                              collapsedIconColor: Colors.transparent,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.lightBlue,
                              trailing: null,
                              maintainState: true,
                              onExpansionChanged:
                              (bool t)async{
                             if(t==true){
                             setState(() {selectedIndex1 = index;});
                             subSubLocationName.clear();
                             SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              var token=sharedPreferences.getString('token');
                              var projectID=sharedPreferences.getString('projectIdd');
                              var clientID=sharedPreferences.getString('client_id');
                                try {
                                var getCompletedProgressListUrl=Uri.parse("${Config.getSubSubLocationProgressApi}$clientID/${projectID??"1"}/${locationIDController.text}/${subLocationID[index]}/INQ");
                                  var res=await http.get(
                                      getCompletedProgressListUrl,
                                      headers:{
                                        "Accept": "application/json",
                                        "Authorization": "Bearer $token",
                                      },
                                    );
                                    var cData4=jsonDecode(res.body);
                                    subSubLocationName.clear();
                                    if(cData4!=null){
                                      for(int i=0;i<cData4['data'].length;i++){
                                      subSubLocationName.add(cData4['data'][i]['sub_sub_location_name']);
                                    }
                                    }
                                    setState(() {});
                                    }
                                    catch(e){
                                        subSubLocationName.clear();
                                        subLocationID.clear();
                                        setState(() {});
                                      if (kDebugMode) {
                                        print("Error is here");
                                        print(e);
                                      }
                                    }
                                 }else{
                                  setState(() {
                                     selectedIndex1=-1;
                                  });
                                 }},
                              title: Text(subLocationName[index]!,style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.normal),),
                              children: [
                              ListView.builder(
                                key: Key(selectedIndex2.toString()),
                                shrinkWrap: true,
                                itemCount: subSubLocationName.length,
                                itemBuilder: (BuildContext context, int index) {
                                return
                                Card(
                                color: AppColors.extraLightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              child:
                              ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child:
                              // ignore: sized_box_for_whitespace
                              Container(
                                height: 60,
                                child: 
                              ExpansionTile(
                              maintainState: true,
                              tilePadding: const EdgeInsets.only(left: 10,),
                              collapsedBackgroundColor: AppColors.extraLightBlue,
                              collapsedIconColor: Colors.transparent,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.extraLightBlue,
                              trailing: null,
                              title: InkWell(
                                onTap: (){
                                  context.pushNamed('COMPLETEDPARTICULARPROGRESS',
                                  );
                                },
                                child:  Text(subSubLocationName[index]!,style: textStyleHeadline3.copyWith(color: AppColors.white,fontSize: 14,fontWeight: FontWeight.normal),),
                                ),
                              )
                            )
                          )
                        );
                      }
                    )
                  ],
                ),
              )
            );
          }
        )
      ],
    ),
  )
);
}
)
),
],
)
)
);
});
}
}