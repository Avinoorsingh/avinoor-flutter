import 'dart:convert';
import 'package:colab/models/completed_progress.dart';
import 'package:http/http.dart' as http;
import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/container2.dart';
import '../theme/text_styles.dart';

// ignore: must_be_immutable
class CompletedParticularProgress extends StatefulWidget {
  CompletedParticularProgress({Key? key, this.from, this.completedModel, this.cID, this.pID, this.locationName, this.subLocationName, this.subSubLocationName, this.locId, this.subLocId, this.subSubLocId}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final from;
  dynamic completedModel;
  // ignore: prefer_typing_uninitialized_variables
  final cID;
  // ignore: prefer_typing_uninitialized_variables
  final pID;
  // ignore: prefer_typing_uninitialized_variables
  final locationName;
  // ignore: prefer_typing_uninitialized_variables
  final subLocationName;
  // ignore: prefer_typing_uninitialized_variables
  final subSubLocationName;
  // ignore: prefer_typing_uninitialized_variables
  final locId;
  // ignore: prefer_typing_uninitialized_variables
  final subLocId;
  // ignore: prefer_typing_uninitialized_variables
  final subSubLocId;

  @override
  State<CompletedParticularProgress> createState() => CompletedParticularProgressState();
}

bool show=false;

class CompletedParticularProgressState extends State<CompletedParticularProgress> {
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  List<String?> activity=[];
  List<String?> activityHead=[];
  List<int?> locationDraft=[];
  List<int?> locationCount=[];
  List<int?> subLocationCount=[];
  List<int?> subLocationID=[];
  List<int?> subLocationDraft=[];
  List<String?> contractorName=[];
  List<String?> checkListAvail=[];
  List<int?> subSubLocationCount=[];
  List<int?> subSubLocationDraft=[];
  List<String?> plannedDates=[];
  List<String?> finishDates=[];
  List<int?> locationID=[];
  CompletedProgress?  progressData;
  List<CompletedProgressListData> list1=[];
  TextEditingController locationIDController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  TextEditingController subLocationController=TextEditingController();
  TextEditingController subSubLocationController=TextEditingController();
  TextEditingController subLocationIDController=TextEditingController();
  TextEditingController subSubLocationIDController=TextEditingController();
 
  final scrollController=ScrollController();
  // ignore: prefer_final_fields
  int _page = 1;
  int _offset=0;

  
  // Function to perform the POST request and update the data list
  Future<void> _getData() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token=sharedPreferences.getString('token');
    // Set up the POST request body
    Map<String, String> body = {
      "offset": '$_offset',
      "cid": '${widget.cID}',
      "pid":'${widget.pID}',
      "loc_id":'${widget.locId}',
      "sub_loc_id": '${widget.subLocId}',
      "sub_sub_loc_id": '${widget.subSubLocId}',
      'page_number':'$_page'
    };
    Map<String, String> requestHeaders={
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    // Perform the POST request
    var response = await http.post(
      Uri.parse('http://nodejs.hackerkernel.com/colab/api/get_completed_progress_add'),
      body: body,
      headers: requestHeaders,
    );
    // Update the data list with the response data
    setState(() {
     progressData = CompletedProgress.fromJson(jsonDecode(response.body));
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
  EasyLoading.show(maskType: EasyLoadingMaskType.black);
  scrollController.addListener(_scrollController);
    // Get the initial data
    _getData();
 }

 void _scrollController(){
  if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
    setState(() {
      _page++;
      _offset=_offset+10;
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
    EasyLoading.dismiss();
    return 
    Scaffold(
    appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("COMPLETED", style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
    body: 
    ListView(
      children: [
        CustomContainer3(
          child: 
            Column(
              children: [
              Center(
                child: 
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Center(child: Text("${widget.locationName} / ${widget.subLocationName} / ${widget.subSubLocationName}", style: textStyleBodyText1.copyWith(color: AppColors.white,))),
                  ]
                )
              )
            ]
          )
        ),
        const SizedBox(height: 20,),
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list1.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                       child:
                       ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: 
                        ExpansionTile(
                        tilePadding:const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        collapsedBackgroundColor: AppColors.navyblue,
                        collapsedIconColor: Colors.transparent,
                        iconColor: Colors.transparent,
                        backgroundColor: AppColors.navyblue,
                        collapsedTextColor: AppColors.black,
                        trailing: null,
                        title:
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                        height: 30,
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        padding:const EdgeInsets.symmetric(vertical: 0),
                        color:AppColors.primary,
                        child:
                        Row(children: [
                        Text(' ${list1[index].activityHead} ${list1[index].activity}                  ',
                        style: textStyleBodyText1.copyWith(color: AppColors.black),
                        overflow: TextOverflow.ellipsis,),
                        ])),
                        Container(
                          margin:const EdgeInsets.only(right: 10),
                          child: 
                        Text("${list1[index].progressPercentage}%",style: textStyleBodyText1.copyWith(color:AppColors.white,fontSize: 18),),
                        ),
                        ]),
                        subtitle:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                        Center(
                          child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            Text("",style: textStyleBodyText2.copyWith(color: AppColors.white),),
                            Text("${list1[index].locationName} / ${list1[index].subLocationName} / ${list1[index].subSubLocationName}", style: textStyleBodyText2.copyWith(color: AppColors.white),),
                            Text(list1[index].contractorId!=null?"Contractor Not Available":"Contractor Available", style: textStyleBodyText2.copyWith(color: AppColors.white),),
                          ],
                          ),
                          ]),
                          ),
                            const SizedBox(height: 10,),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 0,bottom: 0),
                              padding:const EdgeInsets.symmetric(vertical: 0),
                              color:list1[index].contractorId!=null?AppColors.green:Colors.grey,
                              child: Center(child: Text(list1[index].contractorId!=null?"CheckList Available":"CheckList NA", style: textStyleBodyText2.copyWith(color: AppColors.black),)),)
                            ]),
                            children: [
                              InkWell(
                                onTap: (){
                                  context.pushNamed('COMPLETEDSITEPROGRESSDETAIL',extra: list1[index]);
                                },
                                child:
                            Column(children: [
                              Container(
                                padding:const EdgeInsets.only(left: 20, right: 20),
                                color:AppColors.lightGrey,
                                child: 
                            Column(
                              children: [
                                const Text(""),
                                Row(
                                  children: [Text("Quantity- 20 MT / 80 MT", style: textStyleBodyText1.copyWith(fontSize: 14),)],
                                ),
                            ])
                              ),
                            Container(
                                    padding:const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                    color:AppColors.lightGrey,
                                    child: 
                            Column(
                              children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                        Text("Productivity",style: textStyleBodyText1.copyWith(fontSize: 14),),
                                        Text("Rs. 600 / MT",style: textStyleBodyText1.copyWith(fontSize: 14),)
                                    ],),
                                    Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                        Text("", style: textStyleBodyText1.copyWith(fontSize: 14),),
                                        Text("", style: textStyleBodyText1.copyWith(fontSize: 14),)
                                      ],),
                                    Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                        Text("",style: textStyleBodyText1.copyWith(fontSize: 14),),
                                        Text("",style: textStyleBodyText1.copyWith(fontSize: 14),)
                                      ],),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                        Text("",style: textStyleBodyText1.copyWith(fontSize: 14),),
                                        Text("",style: textStyleBodyText1.copyWith(fontSize: 14),)
                                      ],),
                                    Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                       Text("Material consum.",style: textStyleBodyText1.copyWith(fontSize: 14),),
                                       Text("40%",style: textStyleBodyText1.copyWith(fontSize: 14),)
                                      ],),
                                    Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                       Text("",style: textStyleBodyText1.copyWith(fontSize: 14),),
                                       Text("",style: textStyleBodyText1.copyWith(fontSize: 14),)
                                      ],),
                                    ],),
                                  ]
                                )
                              ),
                                Container(
                                    padding:const EdgeInsets.only(left: 20,right: 20,top: 10),
                                    color:AppColors.lightGrey,
                                    child: 
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                      Text("Start",style: textStyleBodyText2.copyWith(fontSize: 12),),
                                      Text("20 dec - 21",style: textStyleBodyText2.copyWith(fontSize: 12),),
                                      Text("PL Start",style: textStyleBodyText2.copyWith(fontSize: 12),),
                                      Text("22 dec - 21",style: textStyleBodyText1.copyWith(fontSize: 12),)
                                      ]),
                                    ]),
                                  ],),
                                    Column(children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          color: Colors.deepOrangeAccent,
                                          child:Center(child:FittedBox(child:Text("-10",style: textStyleBodyText4.copyWith(color: AppColors.white),)),))],),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                        Text("Start",style:textStyleBodyText1.copyWith(fontSize: 12),),
                                        Text("20 dec - 21",style: textStyleBodyText1.copyWith(fontSize: 12),),
                                        Text("PL Start",style:textStyleBodyText1.copyWith(fontSize: 12),),
                                        Text("22 dec - 21",style: textStyleBodyText1.copyWith(fontSize: 12),)
                                        ]
                                      ),
                                    ]
                                  ),
                                ],
                              ),
                            Column(children: [
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.greenAccent,
                                child:Center(child:
                                FittedBox(child: 
                                Text("+26",
                                style: textStyleBodyText4.copyWith(
                                  color: AppColors.white),
                                )
                              ),
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            )
          ]
        )
      )
    ]
  )
)
);
}
)
)
],
)
);
}
}