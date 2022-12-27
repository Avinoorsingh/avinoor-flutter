import 'dart:convert';
import 'package:colab/config.dart';
import 'package:colab/constants/colors.dart';
import 'package:colab/models/manual_check_list.dart';
import 'package:colab/models/quality_activity_head.dart';
import 'package:colab/models/quality_activity_list.dart';
import 'package:colab/models/quality_location_list.dart';
import 'package:colab/models/quality_sublocation_list.dart';
import 'package:colab/network/quality_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../models/quality_sub_sub_location_list.dart';
import '../services/custom_dropdown.dart';
import '../theme/text_styles.dart';
import 'package:http/http.dart' as http;

class OpenedCheckList extends StatefulWidget {
  const OpenedCheckList({Key? key,}) : super(key: key);

  @override
  State<OpenedCheckList> createState() => _OpenedCheckListState();
}

bool show=false;
late var tapped;
var update;

class _OpenedCheckListState extends State<OpenedCheckList> {
  final getCheckList = Get.find<GetOpenedCheckList>();
  List<String?> activity=[];
  List<String?> activityHead=[];
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List qualityData=[];
  List dateDifference=[];
  List contractorNames=[];
  List workCompletionDate=[];
 
 @override
 void initState(){
  super.initState();
  getCheckList.getCheckListData(context: context);
 }

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('MMM-dd-yyyy');
    var outputFormat1 = DateFormat('dd/MM/yyyy');
    return 
    GetBuilder<GetOpenedCheckList>(builder: (_){
      final signInController=Get.find<SignInController>();
     if(signInController.getOpenedCheckListData!.new1!.isNotEmpty && subLocationName.isEmpty){
      for(int i=0;i<signInController.getOpenedCheckListData!.new1!.length;i++){
       activity.add(signInController.getOpenedCheckListData!.new1![i].activity);
       activityHead.add(signInController.getOpenedCheckListData!.new1![i].activityHead);
       subLocationName.add(signInController.getOpenedCheckListData!.new1![i].subLocationName);
       subSubLocationName.add(signInController.getOpenedCheckListData!.new1![i].subSubLocationName);
       locationName.add(signInController.getOpenedCheckListData!.new1![i].locationName);
       remark.add(signInController.getOpenedCheckListData!.new1![i].remarks);
       dueDates.add(signInController.getOpenedCheckListData!.new1![i].endDate);
       contractorNames.add(signInController.getOpenedCheckListData!.new1![i].contractorName??"No Contractor");
       workCompletionDate.add(signInController.getOpenedCheckListData!.new1![i].closeDate??"");
       qualityData.add(signInController.getOpenedCheckListData!.new1![i]);
      //  createdDates.add(signInController.getSnagDataList!.data![i].createdAt);
      //  snagData.add(signInController.getSnagDataList!.data![i]);
      signInController.getOpenedCheckListData!.new1![i].dueDate!=null?
       dateDifference.add((outputFormat.parse(signInController.getOpenedCheckListData!.new1![i].dueDate!)).difference(DateTime.parse(signInController.getOpenedCheckListData!.new1![i].createdAt!)).inDays):
       dateDifference.add(0);
      }
     }
    EasyLoading.dismiss();
    return 
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 110),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subLocationName.length,
              itemBuilder: (BuildContext context, int index){
                return 
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: 
                    Column(
                      children:[
                        Center(child: 
                        Stack(
                          clipBehavior: Clip.none,
                          children: [ 
                            InkWell(
                            splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  show=!show;
                                  tapped=index;
                                });
                              },
                              child:
                            Card(
                              borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                // height: 0,
                                width: 350,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10,),
                                    Text("${activityHead[index]} / ${activity[index]}",style: textStyleHeadline4.copyWith(fontSize: 13),),
                                    const SizedBox(height: 10,),
                                    Text("${locationName[index]} / ${subLocationName[index]} / ${subSubLocationName[index]}",style: textStyleHeadline4.copyWith(fontSize: 13),),
                                    const SizedBox(height: 20,),
                                    const SizedBox(height: 10,),
                                  ],),
                            )),
                            ),
                            Positioned(
                              top: 10,
                              bottom: 20,
                              left: 335,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: 
                                  Container(
                                    width: 30.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color:dateDifference[index]<0?Colors.red:dateDifference[index]==0?Colors.green:AppColors.primary,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(child:
                                    Text(dateDifference[index].toString(),style: textStyleBodyText1,)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                              ),
                        Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 0),
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 90,
                            width: 350,
                            decoration: BoxDecoration(
                                    color:  Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                            child:InkWell(
                              onTap: (){
                                context.pushNamed('QUALITYCHECKDETAIL',
                                // queryParams: {"from": "new"},
                                extra: qualityData[index]);
                              },
                              child: 
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Container(
                                  padding:const EdgeInsets.only(top: 5,bottom: 5),
                                  height: 30,
                                  width: 250,
                                  color: Colors.grey[800],child:
                                  Text(contractorNames[index],style: textStyleHeadline3.copyWith(fontSize: 17,color: Colors.white),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                ),
                                const SizedBox(height: 10,),
                                Row(children: [
                                Text("Work Completion date :",style: textStyleBodyText2.copyWith(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis),
                                Text("${workCompletionDate[index]!=null? (workCompletionDate[index]!.length>30?"${workCompletionDate[index]!.substring(0,29)}...":workCompletionDate[index] ?? ""):""}",style: textStyleBodyText2.copyWith(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis)
                                ])
                                ]),
                             ],)
                            )
                            ),
                            ]
                          )
                        );
                    }
                  )
        ),
      ],
    )),
    floatingActionButton: FloatingActionButton(
        onPressed: () async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        var token=sharedPreferences.getString('token');
        var projectID=sharedPreferences.getString('projectIdd');
        var clientID=sharedPreferences.getString('client_id');
        var getOpenedCheckListUrl=Uri.parse("${Config.getCheckListManualApi}$clientID/$projectID");
        var res=await http.get(
            getOpenedCheckListUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          var cData4=jsonDecode(res.body);
          ManualCheckList result5=ManualCheckList.fromJson(cData4['data']);
    showDialog(
    useSafeArea: true,
    context: context,
    builder: (context1) {
      return 
      Container(
        height: 200,
        width: 200,
        child: 
        // FittedBox(child:
      AlertDialog(
        insetPadding: const EdgeInsets.only(left: 10,right: 10),
        actionsPadding: const EdgeInsets.only(left: 10,right: 10),
        contentPadding: const EdgeInsets.only(left: 10,right: 10,top: 10,),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          const Text('Inspection Checklist',style: TextStyle(fontWeight: FontWeight.normal),),
          const SizedBox(width: 100,),
          Container(
            width: 40,
            height: 40,
            decoration:const BoxDecoration(
               color: AppColors.primary,
               borderRadius: BorderRadius.all(Radius.circular(100)),
               ),
            child:
            Center(child:
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 1,
            icon: const Icon(Icons.close,color: Colors.white,),
            onPressed: () => Navigator.of(context1).pop(),
          ),
            )
          ),
        ]),
          shape: const RoundedRectangleBorder(
          borderRadius:
      BorderRadius.all(
        Radius.circular(10.0))),
        content:Stack(
          children: [ 
          // ignore: sized_box_for_whitespace
          const Divider(color: Colors.grey,thickness: 1,),
          Container(
          margin: const EdgeInsets.only(top:10,),
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            clipBehavior: Clip.none,
            itemCount: result5.data?.length,
            itemBuilder: (BuildContext context1, int index) {
              return ListTile(
                horizontalTitleGap: 10,
                title: 
                Column(
                 children: [
                 Row(children: [
                 Icon(Icons.circle,color: Colors.grey[300],size: 5,),
                 const SizedBox(width: 2,),
                 Text('CHECKLIST NAME:',softWrap: true,style: textStyleBodyText3.copyWith(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                 Expanded(child: 
                 Text("${result5.data?[index].checklistId}",style: textStyleBodyText2.copyWith(fontWeight: FontWeight.bold),))],  
                ),
                 Row(children: [
                 const Icon(Icons.circle,color: Colors.transparent,size: 5,),
                 const SizedBox(width: 2,),
                 Text('DESCRIPTION:',softWrap: true,style: textStyleBodyText3.copyWith(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                 Expanded(child:
                 Text("${result5.data?[index].description}",style: textStyleBodyText2.copyWith(fontWeight: FontWeight.bold),))
                 ],),
                ]
                ),
                trailing: ElevatedButton(onPressed: () {
                  _showModal(context1);
                },
                style: ElevatedButton.styleFrom(backgroundColor:Colors.pinkAccent),
                child: Text("Add\nCheckList",style: textStyleBodyText2.copyWith(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),
              );
            },
          ),
        ),
        ])
      )
        // )
      );
    },
  );
        },
        backgroundColor:AppColors.primary,
        child: const Icon(Icons.add,color: Colors.black,),
      ),);
      }
      );
  }
}

// First, define a function to show the modal
void _showModal(BuildContext context1) async {
  List<String> locationList=[];
  late List<String> subLocationList=[];
  late List<String> subSubLocationList=[];
  List<String> locationIdList=["0"];
  List<String> subLocationIdList=["0"];
  List<String> subSubLocationIdList=["0"];
  List<String> activityHeadList=[];
  List<String> activityHeadIdList=["0"];
  List<String> activityList=[];
  List<String> activityIdList=["0"];
  TextEditingController onlyActivityID = TextEditingController();
  TextEditingController subLocationID = TextEditingController();
  TextEditingController subSubLocationID = TextEditingController();
  TextEditingController activityID = TextEditingController();
  TextEditingController locationID=TextEditingController();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token=sharedPreferences.getString('token');
  var projectID=sharedPreferences.getString('projectIdd');
  var clientID=sharedPreferences.getString('client_id');
  var getLocationListUrl=Uri.parse(Config.getCheckListLocationApi);
        var res=await http.post(
            getLocationListUrl,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
              "client_id":clientID,
              "project_id":projectID,
            }
            );
          Map<String,dynamic> cData3=jsonDecode(res.body);
          QualityLocationList result3=QualityLocationList.fromJson(cData3['data']);
          List<QualityCheckListLocationData>? locationList1=result3.data;
          locationList.add("Select Location");
          for(var data in locationList1!){
            locationList.add(data.locationName!);
            locationIdList.add(data.locationId.toString());
            }
      showDialog(
    context: context1,
    builder: (context1) {
      return StatefulBuilder(builder: (context1, setState) {
        return
      AlertDialog(
        insetPadding: const EdgeInsets.only(left: 10,right: 10,top: 100,bottom: 100),
        actionsPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.only(left: MediaQuery.of(context1).size.width/11,right: MediaQuery.of(context1).size.width/11,top: 10,),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text('Select Location for the\n activity',
          textAlign: TextAlign.center,
          style: textStyleBodyText1,),
          const SizedBox(width: 20,),
          Container(
            width: 40,
            height: 40,
            decoration:const BoxDecoration(
               color: AppColors.primary,
               borderRadius: BorderRadius.all(Radius.circular(100)),),
            child:Center(child:
            IconButton(
              splashColor: Colors.transparent,
              splashRadius: 1,
              icon: const Icon(Icons.close,color: Colors.white,),
              onPressed: () => Navigator.of(context1).pop(),
              ),
            )
          ),
        ]),
          shape: const RoundedRectangleBorder(
          borderRadius:BorderRadius.all(
            Radius.circular(10.0))),
            content:Column(
              children: [ 
          // ignore: sized_box_for_whitespace
              const Divider(color: Colors.grey,thickness: 1,),
              CustomDropdown(hint: "Select Location",
              items:locationList.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items,style: textStyleBodyText2,),
                );
              }).toList(),
              onChanged:(String? newValue) async{
                  try {
                    locationID.text=locationIdList[locationList.indexOf(newValue!)].toString();
                    var getSubLocationListUrl=Uri.parse(Config.getCheckListSubLocationApi);
                    var res=await http.post(
                    getSubLocationListUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                              "client_id":clientID,
                              "project_id":projectID,
                              "location_id":locationID.text,
                            }
                            );
                  Map<String,dynamic> cData3=jsonDecode(res.body);
                  QualitySubLocationList result3=QualitySubLocationList.fromJson(cData3['data']);
                  List<QualityCheckListSubLocationData>? subLocationList1=result3.data; 
                  setState((){
                  subLocationList.add("Select Sub Location");
                      for(var data in subLocationList1!){
                        subLocationList.add(data.subLocationName!);
                        subLocationIdList.add(data.subLocationId!.toString());
                      }
                  });
                  } catch (e) {
                    if (kDebugMode) {
                      print("Error");
                      print(e);
                      }
                    }
                  },),
                  CustomDropdown(hint: "Select Sub Location", 
                  items:subLocationList.map((String items){
                    return
              DropdownMenuItem(
                value: items,
                child: Text(items,style: textStyleBodyText2,),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                subLocationID.text=subLocationIdList[subLocationList.indexOf(newValue!)].toString();
                  try {
                    var getSubSubLocationListUrl=Uri.parse(Config.getCheckListSubSubLocationApi);
                    var res=await http.post(
                    getSubSubLocationListUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                              "client_id":clientID,
                              "project_id":projectID,
                              "location_id":locationID.text,
                              "sub_loc_id":subLocationID.text,
                            }
                            );
                  Map<String,dynamic> cData3=jsonDecode(res.body);
                  QualitySubSubLocationList result3=QualitySubSubLocationList.fromJson(cData3['data']);
                  List<QualityCheckListSubSubLocationData>? subSubLocationList1=result3.data;
                  setState((){
                  subSubLocationList.clear();
                  subSubLocationList.add("Select Sub Sub Location");
                      for(var data in subSubLocationList1!){
                        subSubLocationList.add(data.subSubLocationName!);
                        subSubLocationIdList.add(data.subLocationId!.toString());
                      }
                  }); 
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                      }
                    }
                  },
                ),
                CustomDropdown(hint: "Select Sub Sub Location", items: 
                subSubLocationList.map((String items){
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,style: textStyleBodyText2,),
                        );}).toList(),
                        onChanged: (String? newValue) async{
                          subSubLocationID.text=subSubLocationIdList[subSubLocationList.indexOf(newValue!)].toString();
                          var map = <String, dynamic>{};
                          map['client_id'] = clientID;
                          map['project_id'] = projectID;
                          map['location_id'] = locationID.text;
                          map['sub_loc_id'] = subLocationID.text;
                          map['sub_sub_loc_id'] = subSubLocationID.text;
                          try {
                            var getActivityHeadApi=Uri.parse(Config.getCheckListActivityHeadApi);
                            var res=await http.post(
                            getActivityHeadApi,
                            headers: {
                                      "Accept": "application/json",
                                      "Authorization": "Bearer $token",
                                    },
                              body: map);
                              Map<String,dynamic> cData3=jsonDecode(res.body);
                              QualityActivityHead result3=QualityActivityHead.fromJson(cData3['data']);
                              List<QualityActivityHeadData>? activityHeadList1=result3.data; 
                              setState((){
                                activityHeadList.clear();
                                activityHeadList.add("Select Activity Head");
                                  for(var data in activityHeadList1!){
                                    activityHeadList.add(data.activityHead!.toString());
                                    activityHeadIdList.add(data.activityId!.toString());
                                  }
                              });
                              } catch (e) {
                            if (kDebugMode) {
                              print("Error");
                              print(e);
                            }
                          }
                        },
                      ),
            CustomDropdown(hint: "Select Activity Head",
              items: activityHeadList.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items,style: textStyleBodyText2,),
                );
              }).toList(),
              onChanged: (String? newValue) async{
                  activityID.text=activityHeadIdList[activityHeadList.indexOf(newValue!)].toString();
                  try {
                    var getActivityApi=Uri.parse(Config.getCheckListActivityListApi);
                    var res=await http.post(
                    getActivityApi,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                              "client_id":clientID,
                              "project_id":projectID,
                              "location_id":locationID.text,
                              "sub_loc_id":subLocationID.text,
                              "sub_sub_loc_id":subSubLocationID.text,
                              "activity_id":activityID.text,
                            }
                            );
                  Map<String,dynamic> cData3=jsonDecode(res.body);
                  QualityActivityList result3=QualityActivityList.fromJson(cData3['projectActivityHead']);
                  List<ProjectActivityHead>? activityList1=result3.data; 
                  setState((){
                     activityList.clear();
                     activityList.add("Select Activity");
                      for(var data in activityList1!){
                        activityList.add(data.activity!);
                        activityIdList.add(data.linkingActivityId!.toString());
                      }
                  });
                          } catch (e) {
                            if (kDebugMode) {
                              print("Error");
                              print(e);
                            }
                          }
              },
              ),
              CustomDropdown(hint: "Select Activity", 
              items: activityList.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items,style: textStyleBodyText2,),
                );
              }).toList(),
              onChanged: (String? newValue) async{
                  onlyActivityID.text=activityIdList[activityList.indexOf(newValue!)].toString();
              }
              ),
              const SizedBox(height: 20,),
              Container(margin:const EdgeInsets.only(left: 20,right: 20),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120,50),
                  backgroundColor: const Color.fromRGBO(240, 105, 101,1)), 
                child: Text("Save",style: textStyleButton,),),
                const SizedBox(width: 20,),
                ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120,50),
                  backgroundColor: const Color.fromRGBO(60, 70, 80,1)), 
                child: Text("Cancel",style: textStyleButton,),)
              ],),)
        ])
      );
      });
    },
  );
}
