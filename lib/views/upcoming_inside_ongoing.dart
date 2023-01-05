import 'dart:convert';
import 'package:colab/network/onGoingSiteProgress/ongoing_site_network.dart';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:colab/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../models/ongoing_upcoming_progress.dart';
import '../network/progress_network.dart';
import '../services/container2.dart';
import '../theme/text_styles.dart';

class UpComingInsideOnGoing extends StatefulWidget {
  UpComingInsideOnGoing({Key? key, this.cID,this.pID,this.locID, this.subLocID, this.subSubLocID}) : super(key: key);

  final cID;
  final pID;
  final locID;
  final subLocID;
  final subSubLocID;

  @override
  State<UpComingInsideOnGoing> createState() => _OnProgressState();
}

bool show=false;
late var tapped;
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
     EasyLoading.show(maskType: EasyLoadingMaskType.black);
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
        list1=signInController.getOnGoingUpComingData!.data!;
       activityHead.add(list1[i].activityHead!);
       activity.add(list1[i].activity!);
       locationName.add(list1[i].locationName!);
       subLocationName.add(list1[i].subLocationName!);
       subSubLocationName.add(list1[i].subSubLocationName!);
       contractorName.add(list1[i].contractorName??"null");
       checkListAvail.add(list1[i].startTrigger);
       plannedDates.add(list1[i].createdAt.toString());
       finishDates.add(list1[i].updatedAt.toString());
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
      // physics: const NeverScrollableScrollPhysics(),
      children: [
      //      CustomContainer3(child: 
      //       Column(children: [
      //         Center(child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //           Center(child: Text("${locationController.text} / ${subLocationController.text} / ${subSubLocationController.text}",style: textStyleBodyText1.copyWith(color: AppColors.white,))),
      //           ]
      //         )
      //       )
      //     ]
      //   )
      // ),
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
                                // context.pushNamed("NEWPROGRESSENTRY");
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
                                    Center(child:Text(contractorName[index]!='null'?"${contractorName[index]}":"No Contractor",style: textStyleBodyText2,),),
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