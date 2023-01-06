import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:colab/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../network/progress_network.dart';
import '../theme/text_styles.dart';

class OnGoingProgress extends StatefulWidget {
  const OnGoingProgress({Key? key,}) : super(key: key);

  @override
  State<OnGoingProgress> createState() => _OnProgressState();
}

bool show=false;
late var tapped;
var update;

class _OnProgressState extends State<OnGoingProgress> {
  List<String?> locationName=[];
  List<int?> locationDraft=[];
  List<int?> locationCount=[];
  List<String?> subLocationName=[];
  List<int?> subLocationCount=[];
  List<int?> subLocationID=[];
  List<int?> subLocationDraft=[];
  List<String?> subSubLocationName=[];
  List<String?> subSubLocationID=[];
  List<int?> subSubLocationCount=[];
  List<int?> subSubLocationDraft=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<int?> locationID=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  TextEditingController locationIDController=TextEditingController();
  TextEditingController subLocationIDController=TextEditingController();
  TextEditingController clientIDController=TextEditingController();
  TextEditingController projectIDController=TextEditingController();
  TextEditingController subLocationNameController=TextEditingController();
  TextEditingController subSubLocationNameController=TextEditingController();
  TextEditingController locationNameController=TextEditingController();
  
 
 @override
 void initState(){
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return 
    GetBuilder<GetOnGoingSiteProgress>(builder: (_){
      final signInController=Get.find<SignInController>();
     if(signInController.getOnGoingProcessData!.data!.isNotEmpty && locationName.isEmpty){
      for(int i=0;i<signInController.getOnGoingProcessData!.data!.length;i++){
       locationName.add(signInController.getOnGoingProcessData!.data![i].locationName!);
       locationDraft.add(signInController.getOnGoingProcessData!.data![i].draftCount??0);
       locationID.add(signInController.getOnGoingProcessData!.data![i].locationId!);
       locationCount.add(signInController.getOnGoingProcessData!.data![i].count??0);
     }
     }
    EasyLoading.dismiss();
    return 
    Scaffold(
    floatingActionButton:FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            context.pushNamed('ADDPROGRESSENTRY');
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add,color: AppColors.black,),
        ),
    body: 
    Container(margin: const EdgeInsets.only(top: 90),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: locationName.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                       child:
                       ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: 
                        ExpansionTile(
                        childrenPadding:const EdgeInsets.only(left: 10,right: 10),
                        tilePadding: const EdgeInsets.only(bottom: 20,left: 10,right: 10),
                        collapsedBackgroundColor: AppColors.navyblue,
                        collapsedIconColor: AppColors.white,
                        iconColor: AppColors.white,
                        backgroundColor: AppColors.navyblue,
                        title:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Text(locationName[index]!,style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 18),),
                        locationCount[index]!=0?Text("${locationCount[index]} Activities ( ${locationDraft[index]} drafts )  ",style: textStyleBodyText3.copyWith(color: AppColors.white,fontWeight: FontWeight.w300,fontSize: 12),):const Text("")
                        ]),
                        onExpansionChanged:
                         (bool t)async{
                          if(t==true){
                             SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              var token=sharedPreferences.getString('token');
                              var projectID=sharedPreferences.getString('projectIdd');
                              var clientID=sharedPreferences.getString('client_id');
                                try {
                                  locationIDController.text=locationID[index].toString();
                                  locationNameController.text=locationName[index].toString();
                                var getCompletedProgressListUrl=Uri.parse("${Config.getSubLocationProgressApi}$clientID/${projectID??"1"}/${locationID[index].toString()}/ONG");
                                  var res=await http.get(
                                      getCompletedProgressListUrl,
                                      headers:{
                                        "Accept": "application/json",
                                        "Authorization": "Bearer $token",
                                      },
                                    );
                                    var cData4=jsonDecode(res.body);
                                    if(cData4!=null){
                                      subLocationName.clear();
                                      subLocationID.clear();
                                      subLocationCount.clear();
                                      subLocationDraft.clear();
                                      for(int i=0;i<cData4['data'].length;i++){
                                      subLocationName.add(cData4['data'][i]['sub_location_name']);
                                      subLocationID.add(cData4['data'][i]['sub_loc_id']);
                                      subLocationCount.add(cData4['data'][i]['draft_count']);
                                      subLocationDraft.add(cData4['data'][i]['count']);
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
                                 }},
                        children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: subLocationName.length,
                            itemBuilder: (BuildContext context, int index) {
                              return
                              Card(
                              color: AppColors.navyblue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                          child:
                        ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child:
                        ExpansionTile(
                        childrenPadding:const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        tilePadding: const EdgeInsets.only(left: 10,),
                        collapsedBackgroundColor: AppColors.lightBlue,
                        collapsedIconColor: Colors.transparent,
                        iconColor: Colors.transparent,
                        backgroundColor: AppColors.lightBlue,
                        trailing: null,
                        onExpansionChanged:
                              (bool t)  async{
                             if(t==true){
                             subLocationIDController.text=subLocationID[index].toString();
                             subLocationNameController.text=subLocationName[index].toString();
                             SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              var token=sharedPreferences.getString('token');
                              var projectID=sharedPreferences.getString('projectIdd');
                              var clientID=sharedPreferences.getString('client_id');
                              clientIDController.text=clientID.toString();
                              projectIDController.text=projectID.toString();
                                try {
                                var getOnGoingProgressListUrl=Uri.parse("${Config.getSubSubLocationProgressApi}$clientID/${projectID??"1"}/${locationIDController.text}/${subLocationID[index]}/ONG");
                                  var res=await http.get(
                                      getOnGoingProgressListUrl,
                                      headers:{
                                        "Accept": "application/json",
                                        "Authorization": "Bearer $token",
                                      },
                                    );
                                    var cData4=jsonDecode(res.body);
                                    subSubLocationName.clear();
                                    subSubLocationCount.clear();
                                    subSubLocationDraft.clear();
                                    subSubLocationID.clear();
                                    if(cData4!=null){
                                      for(int i=0;i<cData4['data'].length;i++){
                                      subSubLocationName.add(cData4['data'][i]['sub_sub_location_name']);
                                      subSubLocationCount.add(cData4['data'][i]['count']);
                                      subSubLocationDraft.add(cData4['data'][i]['draft_count']);
                                      subSubLocationID.add(cData4['data'][i]['sub_location_id'].toString());
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
                                 }},
                        title:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Text(subLocationName[index]!,style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.normal),),
                        // ignore: unrelated_type_equality_checks
                        (subLocationDraft[index]!=null)?Text("${subLocationDraft[index]} Activities ( ${subLocationCount[index]} drafts )    ",style: textStyleBodyText3.copyWith(color: AppColors.white,fontWeight: FontWeight.w300,fontSize: 12),):const Text("")
                        ]),
                        children: [
                            ListView.builder(
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
                        Container(
                          height: 60,
                          child: 
                        ExpansionTile(
                        tilePadding: const EdgeInsets.only(left: 10,),
                        collapsedBackgroundColor: AppColors.extraLightBlue,
                        collapsedIconColor: Colors.transparent,
                        iconColor: Colors.transparent,
                        backgroundColor: AppColors.extraLightBlue,
                        trailing: null,
                        title:
                            InkWell(
                            onTap: (){
                              context.pushNamed('ONGOINGHOMESCREEN',queryParams:{"cID":clientIDController.text,"pID":projectIDController.text,"locID":locationIDController.text.toString(),"subLocID":subLocationIDController.text.toString(),"subSubLocID":subSubLocationID[index]!,"loc":locationNameController.text,"subLoc":subLocationNameController.text,"subSubLoc":subSubLocationName[index]!} );
                            },
                            child: 
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(subSubLocationName[index]!,style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.normal),),
                          subSubLocationCount[index]!=null?Text("${subSubLocationCount[index]} Activities ( ${subSubLocationDraft[index]} drafts )    ",style: textStyleBodyText3.copyWith(color: AppColors.white,fontWeight: FontWeight.w300,fontSize: 12),):const Text("")
                          ]),
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
))
);
}
);
}
}