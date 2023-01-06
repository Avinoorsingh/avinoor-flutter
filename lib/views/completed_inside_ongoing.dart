import 'package:colab/constants/colors.dart';
import 'package:colab/models/ongoing_completed_progress_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controller/signInController.dart';
import '../network/onGoingSiteProgress/ongoing_site_network.dart';
import '../network/progress_network.dart';
import '../services/container2.dart';
import '../theme/text_styles.dart';

class CompletedInsideOngoing extends StatefulWidget {
  const CompletedInsideOngoing({Key? key, this.cID,this.pID,this.locID, this.subLocID, this.subSubLocID}) : super(key: key);

  final cID;
  final pID;
  final locID;
  final subLocID;
  final subSubLocID;

  @override
  State<CompletedInsideOngoing> createState() => _OnProgressState();
}

bool show=false;
late var tapped;
var update;

class _OnProgressState extends State<CompletedInsideOngoing> {
  List<String?> locationName=[];
  List<String?> activity=[];
  List<String?> activityHead=[];
  List<int?> locationDraft=[];
  List<int?> locationCount=[];
  List<String?> subLocationName=[];
  List<int?> subLocationCount=[];
  List<int?> subLocationID=[];
  List<int?> subLocationDraft=[];
  List<String?> subSubLocationName=[];
  List<String?> contractorName=[];
  List<String?> checkListAvail=[];
  List<int?> subSubLocationCount=[];
  List<int?> subSubLocationDraft=[];
  List<String?> plannedDates=[];
  List<String?> finishDates=[];
  List<int?> locationID=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  TextEditingController locationIDController=TextEditingController();
 List<OnGoingCompletedData> list1=[];
  TextEditingController locationController=TextEditingController();
  TextEditingController subLocationController=TextEditingController();
  TextEditingController subSubLocationController=TextEditingController();
  TextEditingController subLocationIDController=TextEditingController();
  TextEditingController subSubLocationIDController=TextEditingController();
  final signInController=Get.find<SignInController>();
  final scrollController=ScrollController();
  final getDataController=GetOnGoingCompletedDetail();
  List editModel=[];
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
     if(signInController.getOnGoingCompletedData!.data!=null){
     list1=list1+signInController.getOnGoingCompletedData!.data!;
     EasyLoading.dismiss();
     }
     else if(signInController.getOnGoingCompletedData!.data==null){
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
    return 
    GetBuilder<GetOnGoingSiteProgress>(builder: (_){
      final signInController=Get.find<SignInController>();
     if(signInController.getOnGoingCompletedData?.data!=null && locationName.isEmpty){
          for(int i=0;i<list1.length;i++){
            list1=signInController.getOnGoingCompletedData!.data!;
            locationName.add(list1[i].locationName!);
            activity.add(list1[i].activity!);
            activityHead.add(list1[i].activityHead!);
            subLocationName.add(list1[i].subLocationName!);
            subSubLocationName.add(list1[i].subSubLocationName!);
            contractorName.add(list1[i].contractorId.toString());
            plannedDates.add(list1[i].createdAt.toString());
            finishDates.add(list1[i].updatedAt.toString());
            editModel.add(list1[i]);
          }
          if(list1.isNotEmpty){
          locationController.text=list1[0].locationName!;
          subLocationController.text=list1[0].subLocationName!;
          subSubLocationController.text=list1[0].subSubLocationName!;
          }
     else{
           EasyLoading.show(maskType: EasyLoadingMaskType.black);
     }
     }
    EasyLoading.dismiss();
    return 
     Scaffold(
    body: (list1.isNotEmpty)?
    Container(margin: const EdgeInsets.only(top: 90),
    child:
    ListView(
      controller: scrollController,
      children: [
      //    CustomContainer3(child: 
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
                        tilePadding:const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
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
                        Text(' ${activityHead[index]} ${activity[index]}                  ',
                        style: textStyleBodyText1.copyWith(color: AppColors.black),
                        overflow: TextOverflow.ellipsis,),
                        ])),
                        Container(
                          margin:const EdgeInsets.only(right: 10),
                          child: 
                        Text("100%",style: textStyleBodyText1.copyWith(color:AppColors.white,fontSize: 18),),
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
                            Text("${locationName[index]} / ${subLocationName[index]} / ${subSubLocationName[index]}",style: textStyleBodyText2.copyWith(color: AppColors.white),),
                            Text(contractorName[index]!=null?"Contractor Available":"Contractor Not Available",style: textStyleBodyText2.copyWith(color: AppColors.white),)
                          ],
                        ),
                        ]),
                        ),
                            const SizedBox(height: 10,),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 0,bottom: 0),
                              padding:const EdgeInsets.symmetric(vertical: 0),
                              color: Colors.grey,
                              child: Center(child: Text("CheckList NA",style: textStyleBodyText2.copyWith(color: AppColors.black),)),)
                            ]),
                            children: [
                              InkWell(
                                onTap: (){ 
                                  context.pushNamed('GETCOMPLETEDPROGRESSENTRY',extra: editModel[index]);
                                },
                                child:
                            Column(children: [
                              Container(
                                padding:const EdgeInsets.only(left: 20,right: 20),
                                color:AppColors.lightGrey,
                                child: 
                            Column(
                              children: [
                                const Text(""),
                                Row(
                                  children: [Text("Quantity- 20 MT / 80 MT",style: textStyleBodyText1.copyWith(fontSize: 14),)],
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
)):Container()
);
}
);
}
}