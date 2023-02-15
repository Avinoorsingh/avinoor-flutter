import 'package:colab/models/all_offline_data2.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:colab/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import '../../../../models/snag_offline.dart';
import '../../../../services/local_database/local_database_service.dart';

class UpComingInsideOngoingOffline extends StatefulWidget {
  const UpComingInsideOngoingOffline({Key? key, this.cID, this.pID, this.locID, this.subLocID, this.subSubLocID}) : super(key: key);

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
  State<UpComingInsideOngoingOffline> createState() => _OnProgressState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;
// ignore: prefer_typing_uninitialized_variables
var update;

class _OnProgressState extends State<UpComingInsideOngoingOffline> {
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
  TextEditingController locationController=TextEditingController();
  TextEditingController subLocationController=TextEditingController();
  TextEditingController subSubLocationController=TextEditingController();
  List<LocationOfflineData> list1=[];
  List upComingModel=[];
  late DatabaseProvider databaseProvider;
  List formDataList = [];

   @override
  void initState(){
    databaseProvider = DatabaseProvider();
    databaseProvider.init();
    super.initState();
    fetchSnagData();
    super.initState();
  }

  List<SnagDataOffline> snagDataOffline=[];

  Future<List<SnagDataOffline>> fetchSnagData() async {
    snagDataOffline= await databaseProvider.getSnagModel();
    await fetchSnagsFromLocal();
    return snagDataOffline;
  }

  fetchSnagsFromLocal() async {
     formDataList = await databaseProvider.getAllOfflineModel();
     if(formDataList.isNotEmpty){
      for(int i=0;i<formDataList.length;i++){
        for(int j=0;j<formDataList[i].locationOfflineData.length;j++){
            if(formDataList[i].locationOfflineData[j].locationId==int.parse(widget.locID)){
                for(int k=0;k<formDataList[i].locationOfflineData[j].subLocationInfo.length;k++){
                  if(formDataList[i].locationOfflineData[j].subLocationInfo[k].subLocId==int.parse(widget.subLocID)){
                    for(int l=0;l<formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo.length;l++){
                      if(formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subLocationId==int.parse(widget.subSubLocID)
                      && formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].locationId==int.parse(widget.locID) 
                      && formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subLocId==int.parse(widget.subLocID)){
                        for(int m=0;m<formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subSubLocationActivity.length;m++){
                           if(formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subSubLocationActivity[m].progressAdd==null){
                           list1.add(formDataList[i].locationOfflineData[j]);
                          //  break;
                           }
                        }
                      // break;
                      }
                    }
                  }
                }
               }
            }
        setState(() {});
      }
     EasyLoading.dismiss();
     }
     else if(formDataList.isEmpty){
      EasyLoading.dismiss();
     }
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
     var outputFormat1 = DateFormat('dd/MM/yyyy');
        if(formDataList.isNotEmpty){
        for(int i=0;i<formDataList.length;i++){
        for(int j=0;j<formDataList[i].locationOfflineData.length;j++){
            if(formDataList[i].locationOfflineData[j].locationId==int.parse(widget.locID)){
                for(int k=0;k<formDataList[i].locationOfflineData[j].subLocationInfo.length;k++){
                  if(formDataList[i].locationOfflineData[j].subLocationInfo[k].subLocId==int.parse(widget.subLocID)){
                    for(int l=0;l<formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo.length;l++){
                      if(formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subLocationId==int.parse(widget.subSubLocID)
                      && formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].locationId==int.parse(widget.locID) 
                      && formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subLocId==int.parse(widget.subLocID)){
                        for(int m=0;m<formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subSubLocationActivity.length;m++){
                           if(formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subSubLocationActivity[m].progressAdd==null){
                              locationName.add(formDataList[i].locationOfflineData[j].locationName!);
                              subLocationName.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subLocationName!);
                              subSubLocationName.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subSubLocationInfo![l].subSubLocationName!);
                              contractorName.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subSubLocationInfo![l].subSubLocationActivity![m].contractorName??"null");
                              activityHead.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subSubLocationInfo![l].subSubLocationActivity![m].activityHead!);
                              activity.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subSubLocationInfo![l].subSubLocationActivity![m].activity!);
                              checkListAvail.add(0);
                              plannedDates.add("2023-01-08T15:34:12.000Z".toString());
                              finishDates.add("2024-01-09T15:34:12.000Z".toString());
                              upComingModel.add(list1[i]);
                           }
                        }
                      }
                    }
                  }
                }
            }
      }
     EasyLoading.dismiss();
     }
    }
    EasyLoading.dismiss();
    return 
    Scaffold(
    body:(list1.isNotEmpty)?
    Container(margin: const EdgeInsets.only(top: 90),
    child: ListView(
      children: [
        Padding(padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 60
        ),
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
                                context.pushNamed("UPCOMINGPROGRESSENTRYOFFLINE",
                                extra:upComingModel[index]);
                                if (kDebugMode) {
                                  print(upComingModel[index]);
                                }
                              },
                              child: Card(
                              color: Colors.orangeAccent,
                              borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                                bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                width: 230,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                    width: 200, 
                                    decoration: BoxDecoration(
                                    color: AppColors.navyblue,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                    ), 
                                    child:Center(
                                    child: Text('${activity[index]} ${activityHead[index]}',
                                    style: textStyleHeadline4.copyWith(fontSize: 14,color: AppColors.white),),),),
                                    const SizedBox(height: 10,),
                                    Center(
                                      child:Text('${locationName[index]} / ${subLocationName[index]} / ${subSubLocationName[index]}',style: textStyleBodyText2),),
                                    Center(
                                      child:Text(contractorName[index]!='null'?"${contractorName[index]}":"Contractor Not Available",style: textStyleBodyText2,),),
                                    Container(
                                    width: 200, 
                                    decoration:BoxDecoration(
                                    color:checkListAvail[index]!=null?const Color.fromARGB(255, 6, 203, 6):Colors.grey,
                                    ), 
                                    child:
                                    Center(child:Text(checkListAvail[index]!=null?"Checklist Available":"Checklist NA",style: textStyleBodyText2,),),),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              )
                            ),
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 0,
                                bottom: 0
                                ),
                                decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                ),
                                width: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   Center(
                                   child: 
                                   Text("Planned Start",
                                    style: textStyleHeadline4.copyWith(fontSize: 14,color: AppColors.white),
                                    ),
                                    ),
                                    Container(
                                    width: 100, 
                                    decoration: BoxDecoration(
                                    color: AppColors.navyblue,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                    ), 
                                    child:Center(child: Text(plannedDates[index]!='null'?outputFormat1.format(DateTime.parse(plannedDates[index].toString())):"",
                                    style: textStyleBodyText2.copyWith(color: AppColors.white),),),),
                                    const SizedBox(height: 10,),
                                    Center(
                                      child: 
                                      Text("Planned Finish",
                                      style: textStyleHeadline4.copyWith(fontSize: 14,color: AppColors.white),),
                                    ),
                                    Container(
                                    width: 100, 
                                    decoration: BoxDecoration(
                                    color: AppColors.navyblue,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                    ), 
                                    child:Center(
                                      child: Text(finishDates[index]!='null'?outputFormat1.format(DateTime.parse(finishDates[index].toString())):"",
                                    style: textStyleBodyText2.copyWith(color: AppColors.white),
                                    ),
                                    ),
                                    ),
                                    const SizedBox(height: 12,),
                                  ],
                                ),
                              )
                            ),
                            ),
                            ),
                            Positioned(
                              top: 10,
                              bottom: 20,
                              left: 355,
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    color:Colors.orange,
                                    child: const Center(child:
                                    Text("-00",
                                    style: TextStyle(color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  )
                )
              ]
            )
          ):Container()
        );
      }
  }