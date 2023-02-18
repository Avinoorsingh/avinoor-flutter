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
import '../theme/text_styles.dart';

class CompletedInsideOngoing extends StatefulWidget {
  const CompletedInsideOngoing({Key? key, this.cID,this.pID,this.locID, this.subLocID, this.subSubLocID}) : super(key: key);

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
  State<CompletedInsideOngoing> createState() => _OnProgressState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;
// ignore: prefer_typing_uninitialized_variables
var update;

class _OnProgressState extends State<CompletedInsideOngoing> {
  List<String?> locationName=[];
  List<num?> percentage=[];
  List<String?> activity=[];
  List<num?> triggerID=[];
  List<String?> uomName=[];
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
            triggerID.add(list1[i].triggerId??0);
            percentage.add(list1[i].progressPercentage);
            uomName.add(list1[i].uomName??"");
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
                return  Stack(children: [
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
                              context.pushNamed('GETCOMPLETEDPROGRESSENTRY', extra: editModel[index]);
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
//       Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       child:
//                       ClipRRect(
//                       borderRadius: BorderRadius.circular(5.0),
//                       child: 
//                         ExpansionTile(
//                         tilePadding:const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
//                         collapsedBackgroundColor: AppColors.navyblue,
//                         collapsedIconColor: Colors.transparent,
//                         iconColor: Colors.transparent,
//                         backgroundColor: AppColors.navyblue,
//                         collapsedTextColor: AppColors.black,
//                         trailing: null,
//                         title:
//                         Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                         Container(
//                         height: 30,
//                         margin: const EdgeInsets.only(left: 10,right: 10),
//                         padding:const EdgeInsets.symmetric(vertical: 0),
//                         color:AppColors.primary,
//                         child:
//                         Row(children: [
//                         Text(' ${activityHead[index]} ${activity[index]}                  ',
//                         style: textStyleBodyText1.copyWith(color: AppColors.black),
//                         overflow: TextOverflow.ellipsis,),
//                         ])),
//                         Container(
//                           margin:const EdgeInsets.only(right: 10),
//                           child: 
//                         Text("100%",style: textStyleBodyText1.copyWith(color:AppColors.white,fontSize: 18),),
//                         ),
//                         ]),
//                         subtitle:
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                         Center(
//                           child: 
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children:[
//                             Text("",style: textStyleBodyText2.copyWith(color: AppColors.white),),
//                             Text("${locationName[index]} / ${subLocationName[index]} / ${subSubLocationName[index]}",style: textStyleBodyText2.copyWith(color: AppColors.white),),
//                             Text(contractorName[index]!=null?"Contractor Available":"Contractor Not Available",style: textStyleBodyText2.copyWith(color: AppColors.white),)
//                           ],
//                           ),
//                           ]),
//                           ),
//                             const SizedBox(height: 10,),
//                             Container(
//                               width: double.infinity,
//                               margin: const EdgeInsets.only(top: 0,bottom: 0),
//                               padding:const EdgeInsets.symmetric(vertical: 0),
//                               color: Colors.grey,
//                               child: Center(child: Text("CheckList NA", style: textStyleBodyText2.copyWith(color: AppColors.black),)),)
//                             ]),
//                             children: [
//                               InkWell(
//                                 onTap: (){ 
//                                   context.pushNamed('GETCOMPLETEDPROGRESSENTRY', extra: editModel[index]);
//                                 },
//                                 child:
//                             Column(children: [
//                               Container(
//                                 padding:const EdgeInsets.only(left: 20, right: 20),
//                                 color:AppColors.lightGrey,
//                                 child: 
//                             Column(
//                               children: [
//                                 const Text(""),
//                                 Row(
//                                   children: [Text("Quantity- 20 MT / 80 MT", style: textStyleBodyText1.copyWith(fontSize: 14),)],
//                                 ),
//                               ])
//                             ),
//                             Container(
//                               padding:const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
//                               color:AppColors.lightGrey,
//                                 child: 
//                                 Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                         Text("Productivity",style: textStyleBodyText1.copyWith(fontSize: 14),),
//                                         Text("Rs. 600 / MT",style: textStyleBodyText1.copyWith(fontSize: 14),)
//                                       ],),
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                         Text("",style: textStyleBodyText1.copyWith(fontSize: 14),),
//                                         Text("",style: textStyleBodyText1.copyWith(fontSize: 14),)
//                                       ],),
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                         Text("",style: textStyleBodyText1.copyWith(fontSize: 14),),
//                                         Text("",style: textStyleBodyText1.copyWith(fontSize: 14),)
//                                       ],),
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                         Text("",style: textStyleBodyText1.copyWith(fontSize: 14),),
//                                         Text("",style: textStyleBodyText1.copyWith(fontSize: 14),)
//                                       ],),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                         Text("Material consum.",style: textStyleBodyText1.copyWith(fontSize: 14),),
//                                         Text("40%",style: textStyleBodyText1.copyWith(fontSize: 14),)
//                                       ],),
//                                         Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                         Text("",style: textStyleBodyText1.copyWith(fontSize: 14),),
//                                         Text("",style: textStyleBodyText1.copyWith(fontSize: 14),)
//                                       ],),
//                                     ],),
//                                   ]
//                                 )
//                               ),
//                                 Container(
//                                     padding:const EdgeInsets.only(left: 20,right: 20,top: 10),
//                                     color:AppColors.lightGrey,
//                                     child: 
//                                 Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                         Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                         Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                         Text("Start",style: textStyleBodyText2.copyWith(fontSize: 12),),
//                                         Text("20 dec - 21",style: textStyleBodyText2.copyWith(fontSize: 12),),
//                                         Text("PL Start",style: textStyleBodyText2.copyWith(fontSize: 12),),
//                                         Text("22 dec - 21",style: textStyleBodyText1.copyWith(fontSize: 12),)
//                                         ]),
//                                         ]),
//                                       ],),
//                                     Column(
//                                       children: [
//                                         Container(
//                                           height: 20,
//                                           width: 20,
//                                           color: Colors.deepOrangeAccent,
//                                           child:Center(child:FittedBox(child:Text("-10",style: textStyleBodyText4.copyWith(color: AppColors.white),)),))],),
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           children: [
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                         Text("Start",style:textStyleBodyText1.copyWith(fontSize: 12),),
//                                         Text("20 dec - 21",style: textStyleBodyText1.copyWith(fontSize: 12),),
//                                         Text("PL Start",style:textStyleBodyText1.copyWith(fontSize: 12),),
//                                         Text("22 dec - 21",style: textStyleBodyText1.copyWith(fontSize: 12),)
//                                         ]
//                                       ),
//                                     ]
//                                   ),
//                                 ],
//                               ),
//                             Column(children: [
//                               Container(
//                                 height: 20,
//                                 width: 20,
//                                 color: Colors.greenAccent,
//                                 child:Center(child:
//                                 FittedBox(child: 
//                                 Text("+26",
//                                 style: textStyleBodyText4.copyWith(
//                                   color: AppColors.white),
//                                 )
//                               ),
//                             )
//                           )
//                         ],
//                       ),
//                     ],
//                     ),
//                   ],
//                 )
//               )
//             ]
//           )
//         )
//       ]
//     )
//   )
// );
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