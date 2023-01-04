import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:colab/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../network/progress_network.dart';
import '../services/container2.dart';
import '../theme/text_styles.dart';

class OnGoingInsideOnGoing extends StatefulWidget {
  const OnGoingInsideOnGoing({Key? key,}) : super(key: key);

  @override
  State<OnGoingInsideOnGoing> createState() => _OnProgressState();
}

bool show=false;
late var tapped;
var update;

class _OnProgressState extends State<OnGoingInsideOnGoing> {
  List<String?> locationName=[];
  List<int?> locationDraft=[];
  List<int?> locationCount=[];
  List<String?> subLocationName=[];
  List<int?> subLocationCount=[];
  List<int?> subLocationID=[];
  List<int?> subLocationDraft=[];
  List<String?> subSubLocationName=[];
  List<int?> subSubLocationCount=[];
  List<int?> subSubLocationDraft=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<int?> locationID=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  TextEditingController locationIDController=TextEditingController();
 
 @override
 void initState(){
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return 
    GetBuilder<GetOnGoingSiteProgress>(builder: (_){
      final signInController=Get.find<SignInController>();
     if(signInController.getOnGoingProcessData!.data!.isNotEmpty && locationName.isEmpty){
      for(int i=0;i<signInController.getOnGoingProcessData!.data!.length;i++){
       locationName.add(signInController.getOnGoingProcessData!.data![i].locationName!);
       locationDraft.add(signInController.getOnGoingProcessData!.data![i].draftCount??0);
       locationID.add(signInController.getOnGoingProcessData!.data![i].locationId!);
       locationCount.add(signInController.getOnGoingProcessData!.data![i].count??0);
     }
     }
    EasyLoading.dismiss();
    return 
     Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 90,),
    child: ListView(
      children: [
        CustomContainer3(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Center(child: Text("Tower 1 / 1st Floor / U1",style: textStyleBodyText1.copyWith(color: AppColors.white,))),
                ]
              )
            )
          ]
        )
      ),
        const SizedBox(height: 20,),
        Stack(children: [
        Container(
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index){
                return 
                 Stack(children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10,right: 25,),
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
                        Text('Slab Reinforcement',
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
                                  // context.pushNamed('COMPLETEDSITEPROGRESSDETAIL');
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
                child: Center(child: Text("0 %",style: textStyleBodyText1.copyWith(color: AppColors.white),
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
    // padding:const EdgeInsets.symmetric(vertical: 10),
                child: Center(child: Text("Checklist Closed",style: textStyleBodyText1.copyWith(color: AppColors.white),
                )
              )
            ),
          )
        )
      ]);
      }
    )
  ),
      ])
],
)
)
);
}
);
}
}