import 'package:colab/network/onGoingSiteProgress/ongoing_site_network.dart';
import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../controller/signInController.dart';
import '../../../../models/snag_offline.dart';
import '../../../../services/local_database/local_database_service.dart';
import '../../../../theme/text_styles.dart';

class OnGoingInsideOnGoingOffline extends StatefulWidget {
  const OnGoingInsideOnGoingOffline({Key? key, this.cID,this.pID,this.locID, this.subLocID, this.subSubLocID}) : super(key: key);

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
  State<OnGoingInsideOnGoingOffline> createState() => _OnProgressState();
}

bool show=false;

class _OnProgressState extends State<OnGoingInsideOnGoingOffline> {
  List<String?> activityHead=[];
  List<String?> activity=[];
  List<String?> uomName=[];
  List<String?> subactivityHead=[];
  List<int?> subLocationCount=[];
  List<int?> subLocationID=[];
  List<int?> subactivity=[];
  List<String?> subSubactivityHead=[];
  List<int?> subSubLocationCount=[];
  List<String?> finishDates=[];
  List<String?> plannedDates=[];
  List<num?> percentage=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<num?> triggerID=[];
  List<String?> remark=[];
  List editData=[];
  List dateDifference=[];
  List list1=[];
  TextEditingController locationController=TextEditingController();
  TextEditingController subLocationController=TextEditingController();
  TextEditingController subSubLocationController=TextEditingController();
  TextEditingController locationIDController=TextEditingController();
  TextEditingController subLocationIDController=TextEditingController();
  TextEditingController subSubLocationIDController=TextEditingController();
  final signInController=Get.find<SignInController>();
  final getDataController=GetOnGoingDetail();
  late DatabaseProvider databaseProvider;
  List formDataList = [];
  List<SnagDataOffline> snagDataOffline=[];
 
  @override
 void initState(){
    databaseProvider = DatabaseProvider();
    databaseProvider.init();
    super.initState();
    fetchSnagData();
    super.initState();
 }

  Future<List<SnagDataOffline>> fetchSnagData() async {
    snagDataOffline= await databaseProvider.getSnagModel();
    await fetchSnagsFromLocal();
    return snagDataOffline;
  }

  fetchSnagsFromLocal() async {
     formDataList=await databaseProvider.getAllOfflineModel();
     setState(() {});
  }


  @override
  Widget build(BuildContext context) {
     if(activityHead.isEmpty){
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
                           if(formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo[l].subSubLocationActivity[m].progressAdd!=null){
                              activityHead.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subSubLocationInfo![l].subSubLocationActivity![m].activityHead!);
                              activity.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subSubLocationInfo![l].subSubLocationActivity![m].activity!);
                              uomName.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subSubLocationInfo![l].subSubLocationActivity![m].uomName!);
                              percentage.add(formDataList[i].locationOfflineData[j].subLocationInfo![k].subSubLocationInfo![l].subSubLocationActivity![m].progressAdd?.progressDailyInfo[0]?.progressPercentage??0);
                              triggerID.add(0);
                              //  percentage.add(list1[i].progressAdd?.progressDailyInfo[0]?.progressPercentage??0);
                              editData.add(formDataList[i]);
                           }
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
       setState(() {});
    }
    EasyLoading.dismiss();
    return 
     Scaffold(
    body: (formDataList.isNotEmpty)?
    Container(margin: const EdgeInsets.only(top: 150,),
    child: ListView(
      children: [
        const SizedBox(height: 20,),
        Stack(children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: activity.length,
          itemBuilder: (BuildContext context, int index){
            return 
             Stack(children: [
              Container(
                padding: const EdgeInsets.only(left: 10,right: 25,bottom: 20),
                child:
            Card(
                shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(5.0),
                    ),
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: 
                    ExpansionTile(
                    tilePadding:const EdgeInsets.only(right: 30),
                    collapsedIconColor: Colors.transparent,
                    iconColor: Colors.transparent,
                    collapsedTextColor: AppColors.black,
                    textColor: AppColors.black,
                    trailing: null,
                    title:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text('${activityHead[index]} ${activity[index]}',
                    style: textStyleHeadline3.copyWith(fontSize: 16,color: AppColors.black),
                    overflow: TextOverflow.ellipsis,),
                    ]),
                    subtitle:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const SizedBox(height: 10,),
                    Center(
                      child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ignore: sized_box_for_whitespace
                       Text("  In draft",style: textStyleHeadline4.copyWith(fontSize: 12,fontWeight: FontWeight.w500)),
                       Text("        Submit",style: textStyleHeadline4.copyWith(fontSize: 12,fontWeight: FontWeight.w500)),
                       Text("      Completed",style:textStyleHeadline4.copyWith(fontSize: 12,fontWeight: FontWeight.w500))
                    ]),
                    ),
                    const SizedBox(height: 10,),
                    Center(child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 5,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 90,
                            height: 5,
                            color: AppColors.navyblue,
                          ),
                          Container(
                            width: 90,
                            height: 5,
                            color: AppColors.navyblue,
                          ),
                        ],
                      )
                    ),
                        const SizedBox(height: 30,),
                        ]),
                        children: [
                          InkWell(
                            onTap: (){
                              context.pushNamed('EDITPROGRESSENTRYOFFLINE',extra: editData[index]);
                            },
                            child:
                        Column(children: [
                          Container(
                            padding:const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            color:AppColors.lightGrey,
                            child: 
                        Column(
                          children: [
                            const Text(""),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Quantity: 0.0 ${uomName[index]} | 8.0 ${uomName[index]}",style: textStyleBodyText1.copyWith(fontSize: 14),)],
                            ),
                        ])
                          ),
                        Container(
                                padding:const EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 10),
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
                                      height: 25,
                                      width: 25,
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
                                height: 25,
                                width: 25,
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
                              ],
                            )
                          ),
                ]
              )
            )
          ], 
        )
          ),
        ),
        ),
         Positioned(
          top: 30,
          right: 5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.navyblue,
              borderRadius: BorderRadius.circular(10),
            ),
            height:40,
            width:50,
            margin: const EdgeInsets.only(top: 0,bottom: 0),
            child: Center(child: Text("${percentage[index]} %",style: textStyleBodyText1.copyWith(color: AppColors.white),
            )
          )
        ),
        ),
        Positioned(
          left: 0,
          right: 20,
          top: 80,
          child: Center(
        child:Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            width:250,
            height: 30,
            margin: const EdgeInsets.only(top: 0,bottom: 0),
            child: Center(child: Text(triggerID[index]!=0?"Checklist Closed":"Checklist NA",style: textStyleBodyText1.copyWith(color: AppColors.white),
            )
          )
        ),
          )
        )
      ]);
      }
    ),
      ]),
],
)
):Container()
);
}
}