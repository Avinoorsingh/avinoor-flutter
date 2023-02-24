

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colab/theme/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
import '../models/ongoing_upcoming_progress.dart';
import '../network/onGoingSiteProgress/ongoing_site_network.dart';
import '../network/progress_network.dart';

class UpComingInsideOnGoing extends StatefulWidget {
  const UpComingInsideOnGoing({Key? key, this.cID,this.pID,this.locID, this.subLocID, this.subSubLocID}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final cID;
  // ignore: prefer_typing_uninitialized_variables
  final pID;
  // ignore: prefer_typing_uninitialized_variables
  final locID;
  // ignore: prefer_typing_uninitialized_variables
  final subLocID;
  // ignore: prefer_typing_uninitialized_variables
  final subSubLocID;

  @override
  State<UpComingInsideOnGoing> createState() => _OnProgressState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;
// ignore: prefer_typing_uninitialized_variables
var update;

class _OnProgressState extends State<UpComingInsideOnGoing> {
  List<String?> activity=[];
  List<String?> activityHead=[];
  List<int?> locationCount=[];
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> contractorName=[];
  List<int?> checkListAvail=[];
  List<int?> subLocationCount=[];
  List<int?> subLocationID=[];
  List<int?> subactivityHead=[];
  List<String?> subSubLocationName=[];
  List<int?> subSubLocationCount=[];
  List<int?> subSubactivityHead=[];
  List<String?> finishDates=[];
  List<String?> plannedDates=[];
  List<int?> locationID=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  TextEditingController locationIDController=TextEditingController();
  final signInController=Get.find<SignInController>();
  final scrollController=ScrollController();
  final getDataController=GetOnUpComingData();
  TextEditingController locationController=TextEditingController();
  TextEditingController subLocationController=TextEditingController();
  TextEditingController subSubLocationController=TextEditingController();
  List<OnGoingUpcomingData> list1=[];
  final getOnGoingSiteProgressDataController=Get.find<GetOnGoingSiteProgress>();
  List upComingModel=[];
  int _page = 1;
 
 @override
 void initState(){
  super.initState();
   scrollController.addListener(_scrollController);
    // Get the initial data
    _getData();
    setState(() {});
 }

   Future<void> _getData() async {
    //  EasyLoading.show(maskType: EasyLoadingMaskType.black);
     await getDataController.getDetail(cID: widget.cID, pID: widget.pID, locID: widget.locID, subLocID: widget.subLocID, subSubLocID: widget.subSubLocID, pageNumber: _page.toString());
    setState(() {
     if(signInController.getOnGoingUpComingData!.data!=null){
     list1=list1+signInController.getOnGoingUpComingData!.data!;
     EasyLoading.dismiss();
     }
     else if(signInController.getOnGoingUpComingData!.data==null){
      EasyLoading.dismiss();
     }
    });
  }
  
    @override
  void dispose() {
    scrollController.dispose();
    // Dispose of the PageController
    super.dispose();
  }

  void _scrollController(){
  if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
    setState(() {
      if (kDebugMode) {
        print(_page);
      }
      _page++;
      _getData();
    });
  }
  else{}
 }

  @override
  Widget build(BuildContext context) {
     var outputFormat1 = DateFormat('dd/MM/yyyy');
    return 
    GetBuilder<GetOnUpComingData>(builder: (_){
      final signInController=Get.find<SignInController>();
      for(int i=0;i<list1.length;i++){
        if(signInController.getOnGoingUpComingData!.data!=null){
      list1=signInController.getOnGoingUpComingData!.data!;
        }
       activityHead.add(list1[i].activityHead!);
       activity.add(list1[i].activity!);
       locationName.add(list1[i].locationName!);
       subLocationName.add(list1[i].subLocationName!);
       subSubLocationName.add(list1[i].subSubLocationName!);
       contractorName.add(list1[i].contractorName??"null");
       checkListAvail.add(list1[i].startTrigger);
       plannedDates.add(list1[i].createdAt.toString());
       finishDates.add(list1[i].updatedAt.toString());
       upComingModel.add(list1[i]);
     }
     if(list1.isNotEmpty){
     locationController.text=list1[0].locationName!;
     subLocationController.text=list1[0].subLocationName!;
     subSubLocationController.text=list1[0].subSubLocationName!;
     }
     else{
           EasyLoading.show(maskType: EasyLoadingMaskType.black);
     }
    EasyLoading.dismiss();
    return 
     Scaffold(
    body:(list1.isNotEmpty)?
    Container(margin: const EdgeInsets.only(top: 90),
    child:  ListView(
      controller: scrollController,
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 60),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: locationName.length,
              itemBuilder: (BuildContext context, int index){
                return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: (){
                                // print(list1[index].startTrigger);
                                  if(list1[index].startTrigger!=null){
                                showDialog(
                                useSafeArea: true,
                                context: context,
                                builder: (context1) {
                                  return 
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    height: 200,
                                    width: 200,
                                    child: 
                                    AlertDialog(
                                          insetPadding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                          actionsPadding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                          contentPadding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                          title:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: const [
                                            Text('Do you want to trigger quality inspection ?',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),),
                                          ]),
                                          shape: const RoundedRectangleBorder(
                                          borderRadius:
                                            BorderRadius.all(
                                           Radius.circular(10.0))),
                                          content:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [ 
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  gradient: const LinearGradient(
                                                    begin: Alignment(-0.95, 0.0),
                                                    end: Alignment(1.0, 0.0),
                                                    colors: [Color.fromRGBO(49,140,231, 0.7),Color.fromRGBO(21, 96, 198, 2.0)],
                                                    stops: [0.0, 1.0],
                                                  ),
                                                ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                                                  backgroundColor: Colors.transparent,
                                                  splashFactory: NoSplash.splashFactory,
                                                  disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                                                  shadowColor: Colors.transparent,
                                                ),
                                                onPressed: () async {
                                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                                  var tokenValue=sharedPreferences.getString('token');
                                                  var res=await http.get(
                                                        Uri.parse('${Config.getCheckActivityStart}${list1[index].activityId}/${list1[index].linkingActivityId}'),
                                                        headers: {
                                                          "Content-Type": "application/json",
                                                          "Accept": "application/json",
                                                          "Authorization": "Bearer $tokenValue",
                                                        }
                                                      );
                                                if(res.body.isNotEmpty){
                                                if (kDebugMode) {
                                                  print(jsonDecode(res.body)['data'][0]['id'].toString());
                                                }
                                                List data=[];
                                                for(int i=0;i<jsonDecode(res.body)['data'].length;i++){
                                                data.add({
                                                    "checklist_id":jsonDecode(res.body)['data'][i]['id'],
                                                    "checklist_section_id": jsonDecode(res.body)['data'][i]['check_sec_id'],
                                                    "checklist_section_linking_id":jsonDecode(res.body)['data'][i]['check_sec_link_id'],
                                                    "trigger_id":jsonDecode(res.body)['data'][i]['trigger_id'],
                                                    "link_activity_id": list1[index].linkingActivityId,
                                                    "activity_head_id": list1[index].activityId,
                                                    "created_by": jsonDecode(res.body)['data'][i]['created_by'],
                                                });
                                                }
                                                if (kDebugMode) {
                                                  print(data);
                                                }
                                                var res2=await http.post(
                                                      Uri.parse(Config.saveManualCheckList),
                                                      headers: {
                                                      "Accept": "application/json",
                                                      "Authorization": "Bearer $tokenValue",
                                                      },
                                                    body: jsonEncode([data])
                                                  );
                                                var projectID=sharedPreferences.getString('projectIdd');
                                                var clientID=sharedPreferences.getString('client_id');
                                                var id=sharedPreferences.getString('id');
                                               if(res2.statusCode==200){
                                                var dio=Dio();
                                                FormData formData=FormData();
                                                formData.fields.add(MapEntry('progress_data', jsonEncode(
                                                  {
                                                    "id": "",
                                                    "client_id": clientID,
                                                    "project_id": projectID,
                                                    "link_activity_id": list1[index].linkingActivityId,
                                                    "achived_quantity": "",
                                                    "total_quantity": list1[index].quantity,
                                                    "contractor_id": "",
                                                    "remarks": "",
                                                    "progress_percentage": "",
                                                    "debet_contactor":"",
                                                    "progress_date": DateTime.now().toString(),
                                                    "cumulative_quantity": "",
                                                    "type": "2",
                                                    "created_by": id.toString(),
                                                    "contractorLabourDetails": [
                                                        {
                                                            "contractor_labour_linking_id": "",
                                                            "time": ""
                                                        }
                                                    ],
                                                    "PWRLabourDetails": [
                                                        {
                                                            "pwr_type": "0",
                                                            "labour_count": ""
                                                        }
                                                    ],
                                                    "save_type": "save",
                                                    "progressDetails": [
                                                        {
                                                            "contractor_id": "",
                                                            "labours": [],
                                                            "contractorLabourDetails": [
                                                                {
                                                                    "contractor_labour_linking_id": "",
                                                                    "time": ""
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                }
                                                )),);
                                                formData.fields.add(const MapEntry('progress_image', ""));
                                                await dio.post(
                                                  Config.saveLabourSupplyProgressApi,
                                                  data: formData,
                                                  options: Options(
                                                    followRedirects: false,
                                                    validateStatus: (status) {
                                                      return status! < 500;
                                                    },
                                                    headers: {
                                                      "authorization": "Bearer $tokenValue",
                                                      "Content-type": "application/json",
                                                    },
                                                  ),
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.pop(context1);
                                                await getOnGoingSiteProgressDataController.getOnGoingListData(context: context);
                                                // ignore: use_build_context_synchronously
                                                context.pushNamed('ACTIVITIES');
                                                // ignore: use_build_context_synchronously
                                                Navigator.pop(context);
                                                  // ignore: use_build_context_synchronously
                                                // Navigator.pop(context);
                                                setState(() {});
                                               }
                                              else{
                                                EasyLoading.showToast('Something went wrong',toastPosition: EasyLoadingToastPosition.bottom);
                                               }
                                              }
                                               else{
                                                EasyLoading.showToast('Something went wrong',toastPosition: EasyLoadingToastPosition.bottom);
                                               }
                                                }, child:const Text("   Trigger   ",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12),),
                                              )),
                                                Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  gradient: const LinearGradient(
                                                    begin: Alignment(-0.95, 0.0),
                                                    end: Alignment(1.0, 0.0),
                                                    colors: [Color.fromARGB(175, 215, 78, 78),Color.fromARGB(249, 236, 97, 97)],
                                                    stops: [0.0, 1.0],
                                                  ),
                                                ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                                                  backgroundColor: Colors.transparent,
                                                  splashFactory: NoSplash.splashFactory,
                                                  disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                                                  shadowColor: Colors.transparent,
                                                ),
                                                onPressed: (){
                                                    Navigator.pop(context1);
                                                }, child:const Text("Don't Trigger",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12)),
                                              )),
                                                Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  gradient: const LinearGradient(
                                                    begin: Alignment(-0.95, 0.0),
                                                    end: Alignment(1.0, 0.0),
                                                    colors: [Color.fromARGB(177, 0, 0, 0),Color.fromARGB(253, 195, 210, 231)],
                                                    stops: [0.0, 1.0],
                                                  ),
                                                ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                                                  backgroundColor: Colors.transparent,
                                                  splashFactory: NoSplash.splashFactory,
                                                  disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                                                  shadowColor: Colors.transparent,
                                                ),
                                                onPressed: (){
                                                  Navigator.pop(context1);
                                                }, child:const Text("    Cancel   ",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12)),
                                              ))
                                            // ignore: sized_box_for_whitespace
                                        ]
                                      ),
                                    ),
                                  );
                                }
                              );
                            }else{
                                context.pushNamed("NEWPROGRESSENTRY2",extra: list1[index]);
                            }
                                // context.pushNamed("UPCOMINGPROGRESSENTRY",extra:upComingModel[index]);
                                // if (kDebugMode) {
                                //   print(upComingModel[index]);
                                // }
                              },
                              child: 
                              Card(
                              color: Colors.orangeAccent,
                              borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                // height: 0,
                                width: 230,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width: 200, 
                                    decoration: BoxDecoration(
                                    color: AppColors.navyblue,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(4)
                                   ), 
                                    child:Center(child: Text('${activity[index]} ${activityHead[index]}',
                                    style: textStyleHeadline4.copyWith(fontSize: 14,color: AppColors.white),),),),
                                    const SizedBox(height: 10,),
                                    Center(child:Text('${locationName[index]} / ${subLocationName[index]} / ${subSubLocationName[index]}',style: textStyleBodyText2),),
                                    Center(child:Text(contractorName[index]!='null'?"${contractorName[index]}":"Contractor Not Available",style: textStyleBodyText2,),),
                                    Container(width: 200, 
                                    decoration:BoxDecoration(
                                    color:checkListAvail[index]!=null?const Color.fromARGB(255, 6, 203, 6):Colors.grey,
                                   ), 
                                   child:
                                    Center(child:Text(checkListAvail[index]!=null?"Checklist Available":"Checklist NA",style: textStyleBodyText2,),),),
                                    const SizedBox(height: 10,),
                                  ],),
                            )),
                            ),
                          Positioned(
                           right: 0,
                           left: 225,
                              child:
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
                              color: AppColors.extraLightBlue,
                              borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                // height: 0,
                                width: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   Center(child: 
                                   Text("Planned Start",
                                    style: textStyleHeadline4.copyWith(fontSize: 14,color: AppColors.white),),
                                    ),
                                    Container(width: 100, 
                                    decoration: BoxDecoration(
                                    color: AppColors.navyblue,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(4)
                                   ), 
                                    child:Center(child: Text(plannedDates[index]!='null'?outputFormat1.format(DateTime.parse(plannedDates[index].toString())):"",
                                    style: textStyleBodyText2.copyWith(color: AppColors.white),),),),
                                    const SizedBox(height: 10,),
                                    Center(child: 
                                    Text("Planned Finish",
                                    style: textStyleHeadline4.copyWith(fontSize: 14,color: AppColors.white),),
                                    ),
                                     Container(width: 100, 
                                    decoration: BoxDecoration(
                                    color: AppColors.navyblue,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(4)
                                   ), 
                                     child:Center(child: Text(finishDates[index]!='null'?outputFormat1.format(DateTime.parse(finishDates[index].toString())):"",
                                    style: textStyleBodyText2.copyWith(color: AppColors.white),),),),
                                    const SizedBox(height: 12,),
                                  ],),
                            )),
                            ),
                             ),
                            Positioned(
                              top: 10,
                              bottom: 20,
                              left: 355,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    color:Colors.orange,
                                    child: const Center(child:Text("-00",style: TextStyle(color: AppColors.white),),),
                                  ),
                                ),
                              ),
                            ),
                          ],);
  }))])):Container());
}
);
}
}