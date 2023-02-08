import 'dart:convert';
import 'package:colab/models/upcoming_progress.dart';
import 'package:http/http.dart' as http;
import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/signInController.dart';
import '../../../theme/text_styles.dart';

class UpComingProgressOffline extends StatefulWidget {
  const UpComingProgressOffline({Key? key,}) : super(key: key);

  @override
  State<UpComingProgressOffline> createState() => _UpcomingProgressState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class _UpcomingProgressState extends State<UpComingProgressOffline> {
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

  
  // Function to perform the POST request and update the data list
  Future<void> _getData() async {
     EasyLoading.show(maskType: EasyLoadingMaskType.black);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token=sharedPreferences.getString('token');
    // Set up the POST request body
    Map<String, String> body = {
      'cid':'1',
      'pid':'1',
      'page_number':'$_page'
    };
    Map<String, String> requestHeaders={
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    // Perform the POST request
    var response = await http.post(
      Uri.parse('http://nodejs.hackerkernel.com/colab/api/get_upcoming_progress_add'),
      body: body,
      headers: requestHeaders,
    );
    // Update the data list with the response data
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
    // Get the initial data
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
    // Dispose of the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outputFormat1 = DateFormat('dd/MM/yyyy');
    final signInController=Get.find<SignInController>();
    EasyLoading.dismiss();
    return
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 90),
    child:(signInController.getSnagDataList!.data!=null)?
    ListView(
      controller: scrollController,
      // physics: const NeverScrollableScrollPhysics(),
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
                                context.pushNamed("NEWPROGRESSENTRY");
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
                                    child:Center(child: Text('${list1[index].activityHead!} ${list1[index].activity!}',
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
}