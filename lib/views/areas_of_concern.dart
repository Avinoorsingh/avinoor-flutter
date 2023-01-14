import 'package:colab/constants/colors.dart';
import 'package:colab/network/area_of_concern_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controller/signInController.dart';
import '../theme/text_styles.dart';

class AreasOfConcern extends StatefulWidget {
  const AreasOfConcern({Key? key,}) : super(key: key);

  @override
  State<AreasOfConcern> createState() => _NewSnagState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class _NewSnagState extends State<AreasOfConcern> {
  final getAreaOfConcern = Get.find<GetAreaOfConcern>();
  List<String?> locationName=[];
  List<String?> activity=[];
  List<String?> activityHead=[];
  List<String?> date=[];
  List<String?> description=[];
  List<String?> status=[];
  List areaData=[];
  List dateDifference=[];
 
 @override
 void initState(){
  super.initState();
  getAreaOfConcern.getAreaOfConcernData(context: context);
 }

  @override
  Widget build(BuildContext context) {
    var outputFormat1 = DateFormat('dd/MM/yyyy hh:mm a');
    return 
    GetBuilder<GetAreaOfConcern>(builder: (_){
      final signInController=Get.find<SignInController>();
     if(signInController.getAreaOfConcData!.data!.isNotEmpty && locationName.isEmpty){
      for(int i=0;i<signInController.getAreaOfConcData!.data!.length;i++){
        locationName.add(signInController.getAreaOfConcData!.data![i].locationName??"");
        activity.add(signInController.getAreaOfConcData!.data![i].activity??"");
        activityHead.add(signInController.getAreaOfConcData!.data![i].activityHead??"");
        status.add(signInController.getAreaOfConcData!.data![i].status??"Resolved");
        description.add(signInController.getAreaOfConcData!.data![i].description??"");
        date.add(signInController.getAreaOfConcData!.data![i].updatedAt??"");
        areaData.add(signInController.getAreaOfConcData!.data![i]);
      }
     }
    EasyLoading.dismiss();
    return 
    Scaffold(
    appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Areas of concern",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
    body: 
    Container(margin: const EdgeInsets.only(top: 10),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: locationName.length,
              itemBuilder: (BuildContext context, int index){
                return 
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: 
                    Column(
                      children:[
                        Center(child: 
                        Stack(
                          clipBehavior: Clip.none,
                          children: [ 
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
                              borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(left: 10,top: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                // height: 0,
                                width: 335,
                                child: Stack(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      width: 70,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: status[index]=="Resolved"?AppColors.green:AppColors.primary,
                                          shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(8),bottomLeft: Radius.circular(3))
                                      ),
                                      child: Center(child: Text(status[index]!,style: const TextStyle(color: AppColors.white,fontWeight: FontWeight.normal,fontSize: 10),),) ,
                                    ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    const SizedBox(height: 10,),
                                    Text(locationName[index]!,style: textStyleHeadline4.copyWith(fontSize: 12),),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text("${activityHead[index]} / ${activity[index]}",style: textStyleHeadline4.copyWith(fontSize: 12),),
                                      Container(
                                        margin:const EdgeInsets.only(right: 10),
                                        child: 
                                      Text("Date: ${outputFormat1.format(DateTime.parse(date[index]!))}",style: textStyleHeadline4.copyWith(fontSize: 10,color: Colors.grey),),
                                      ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                  ],),
                                  ])
                            )),
                            ),
                          ],
                        ),
                      ),
                      if(show==true && index==tapped)
                        Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 0),
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 50,
                            width: 330,
                            decoration: BoxDecoration(
                                    color:  Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                            child:InkWell(
                              onTap: (){
                                context.pushNamed('AREAOFCONCERNDETAIL',
                                queryParams: {"from": "clicked"},
                                extra: areaData[index]
                                );
                              },
                              child: 
                              Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                               Text("Description: ",style: textStyleHeadline4,overflow: TextOverflow.ellipsis,),
                               Flexible(
                               fit: FlexFit.tight,
                               child:
                               Text("${description[index]}",overflow: TextOverflow.clip,
                                )),
                              ],),
                            )
                            ),
                            ]
                          )
                        );
                    }
                  )
        ),
      ],
    )),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('ADDAREAOFCONCERN');
        },
        backgroundColor:AppColors.primary,
        child: const Icon(Icons.add,color: Colors.black,),
      ));
  });
}
}