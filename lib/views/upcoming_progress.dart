import 'dart:convert';
import 'package:colab/config.dart';
import 'package:colab/constants/colors.dart';
import 'package:colab/controller/signInController.dart';
import 'package:colab/models/upcoming_progress.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/client_project.dart';
import '../network/progress_network.dart';


class UpcomingProgress extends StatefulWidget {
  const UpcomingProgress({Key? key,}) : super(key: key);

  @override
  State<UpcomingProgress> createState() => _UpcomingProgressState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class _UpcomingProgressState extends State<UpcomingProgress> {
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List dateDifference=[];
  UpcomingProgress1?  progressData;
  List<UpcomingProgressData> list1=[];
  // PageController for pagination
  final scrollController=ScrollController();
  // ignore: prefer_final_fields
  int _page = 1;
  final getProgressCount=Get.find<GetProgressCount>();
  final getOnGoingSiteProgressDataController=Get.find<GetOnGoingSiteProgress>();

  Future<void> _getData() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token=sharedPreferences.getString('token');
    Map<String, String> body = {
      'cid':'1',
      'pid':'1',
      'page_number':'$_page'
    };
    Map<String, String> requestHeaders={
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    var response = await http.post(
      Uri.parse(Config.getUpcomingProgress),
      body: body,
      headers: requestHeaders,
    );
    setState(() {
     progressData = UpcomingProgress1.fromJson(jsonDecode(response.body));
     if(progressData!.data!=null){
     list1=list1+progressData!.data!;
     EasyLoading.dismiss();
     }
     else if(progressData!.data==null){
      EasyLoading.dismiss();
     }
    });
  }

 
 @override
 void initState(){
  super.initState();
  scrollController.addListener(_scrollController);
    _getData();
 }

 void _scrollController(){
  if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
    setState(() {
      _page++;
      _getData();
    });
  }
  else{}
 }

 @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outputFormat1 = DateFormat('dd/MM/yyyy');
    return 
    GetBuilder<GetCompletedSiteProgress>(builder: (_){
    final signInController=Get.find<SignInController>();
    EasyLoading.dismiss();
    return
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 90),
    child:(signInController.getSnagDataList!.data!=null)?
    ListView(
      controller: scrollController,
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list1.length,
              itemBuilder: (BuildContext context, int index){
                return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: (){
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
                                                await getProgressCount.getProgressData(context: context);
                                                await getOnGoingSiteProgressDataController.getOnGoingListData(context: context);
                                                // ignore: use_build_context_synchronously
                                                context.pushNamed('ACTIVITIES');
                                                // ignore: use_build_context_synchronously
                                                Navigator.pop(context);
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
                          },
                            child: 
                             Card(
                              color: Colors.orangeAccent,
                              borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                                    borderRadius: BorderRadius.circular(4),
                                   ), 
                                    child:Center(child: Text(' ${list1[index].activity!} ${list1[index].activityHead!}',
                                    style: textStyleHeadline4.copyWith(fontSize: 14,color: AppColors.white),),),),
                                    const SizedBox(height: 10,),
                                    Center(child:Text('${list1[index].locationName!} / ${list1[index].subLocationName!} / ${list1[index].subSubLocationName!}',style: textStyleBodyText2),),
                                    Center(child:Text(list1[index].contractorName??"No Contractor",style: textStyleBodyText2,),),
                                    Container(width: 200, 
                                    decoration:BoxDecoration(
                                    color:list1[index].startTrigger!=null?const Color.fromARGB(255, 6, 203, 6):Colors.grey,
                                   ), 
                                   child:
                                    Center(child:Text(list1[index].startTrigger!=null? 'Checklist Available':'No Checklist Available',style: textStyleBodyText2,),),),
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
                                    child:Center(child: Text(outputFormat1.format(DateTime.parse(list1[index].createdAt.toString())),
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
                                    child:Center(child:Text(list1[index].updatedAt!=null?outputFormat1.format(DateTime.parse(list1[index].updatedAt.toString())):"",
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
  }))]):Container()));
  }
  );}
}