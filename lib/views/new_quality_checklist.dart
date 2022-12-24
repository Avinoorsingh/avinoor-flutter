import 'package:colab/constants/colors.dart';
import 'package:colab/network/quality_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controller/signInController.dart';
import '../theme/text_styles.dart';

class NewQualityCheckList extends StatefulWidget {
  const NewQualityCheckList({Key? key,}) : super(key: key);

  @override
  State<NewQualityCheckList> createState() => _NewQualityCheckListState();
}

bool show=false;
late var tapped;
var update;

class _NewQualityCheckListState extends State<NewQualityCheckList> {
  final getCheckList = Get.find<GetNewCheckList>();
  List<String?> activity=[];
  List<String?> activityHead=[];
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List qualityData=[];
  List dateDifference=[];
  List contractorNames=[];
  List workCompletionDate=[];
 
 @override
 void initState(){
  super.initState();
  getCheckList.getCheckListData(context: context);
 }

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('MMM-dd-yyyy');
    var outputFormat1 = DateFormat('dd/MM/yyyy');
    return 
    GetBuilder<GetNewCheckList>(builder: (_){
      final signInController=Get.find<SignInController>();
     if(signInController.getCheckListData!.new1!.isNotEmpty && subLocationName.isEmpty){
      for(int i=0;i<signInController.getCheckListData!.new1!.length;i++){
       activity.add(signInController.getCheckListData!.new1![i].activity);
       activityHead.add(signInController.getCheckListData!.new1![i].activityHead);
       subLocationName.add(signInController.getCheckListData!.new1![i].subLocationName);
       subSubLocationName.add(signInController.getCheckListData!.new1![i].subSubLocationName);
       locationName.add(signInController.getCheckListData!.new1![i].locationName);
       remark.add(signInController.getCheckListData!.new1![i].remarks);
       dueDates.add(signInController.getCheckListData!.new1![i].endDate);
       contractorNames.add(signInController.getCheckListData!.new1![i].contractorName??"No Contractor");
       workCompletionDate.add(signInController.getCheckListData!.new1![i].closeDate??"");
       qualityData.add(signInController.getCheckListData!.new1![i]);
      //  createdDates.add(signInController.getSnagDataList!.data![i].createdAt);
      //  snagData.add(signInController.getSnagDataList!.data![i]);
      signInController.getCheckListData!.new1![i].dueDate!=null?
       dateDifference.add((outputFormat.parse(signInController.getCheckListData!.new1![i].dueDate!)).difference(DateTime.parse(signInController.getCheckListData!.new1![i].createdAt!)).inDays):
       dateDifference.add(0);
      }
     }
    EasyLoading.dismiss();
    return 
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 110),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subLocationName.length,
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
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                // height: 0,
                                width: 350,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10,),
                                    Text("${activityHead[index]} / ${activity[index]}",style: textStyleHeadline4.copyWith(fontSize: 13),),
                                    const SizedBox(height: 10,),
                                    Text("${locationName[index]} / ${subLocationName[index]} / ${subSubLocationName[index]}",style: textStyleHeadline4.copyWith(fontSize: 13),),
                                    const SizedBox(height: 20,),
                                    const SizedBox(height: 10,),
                                  ],),
                            )),
                            ),
                            Positioned(
                              top: 10,
                              bottom: 20,
                              left: 335,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: 
                                  Container(
                                    width: 30.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color:dateDifference[index]<0?Colors.red:dateDifference[index]==0?Colors.green:AppColors.primary,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(child:
                                    Text(dateDifference[index].toString(),style: textStyleBodyText1,)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                              ),
                        Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 0),
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 90,
                            width: 350,
                            decoration: BoxDecoration(
                                    color:  Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                            child:InkWell(
                              onTap: (){
                                context.pushNamed('QUALITYCHECKDETAIL',
                                // queryParams: {"from": "new"},
                                extra: qualityData[index]);
                              },
                              child: 
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Container(
                                  padding:const EdgeInsets.only(top: 5,bottom: 5),
                                  height: 30,
                                  width: 250,
                                  color: Colors.grey[800],child:
                                  Text(contractorNames[index],style: textStyleHeadline3.copyWith(fontSize: 17,color: Colors.white),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                ),
                                const SizedBox(height: 10,),
                                Text(("Work Completion date : ${workCompletionDate[index]!=null? (workCompletionDate[index]!.length>30?"${workCompletionDate[index]!.substring(0,29)}...":workCompletionDate[index] ?? ""):""}"),style: textStyleBodyText2.copyWith(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                                ]),
                             ],)
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
  showDialog(
    useSafeArea: true,
    context: context,
    builder: (context1) {
      return 
      AlertDialog(
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          const Text('Dialog Title'),
          const SizedBox(width: 100,),
          Container(
            width: 40,
            height: 40,
            decoration:const BoxDecoration(
               color: AppColors.primary,
               borderRadius: BorderRadius.all(Radius.circular(100)),),
            child:
            Center(child:
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 1,
            icon: const Icon(Icons.close,color: Colors.white,),
            onPressed: () => Navigator.of(context1).pop(),
          ),
            )
          ),
        ]),
          shape: const RoundedRectangleBorder(
          borderRadius:
      BorderRadius.all(
        Radius.circular(10.0))),
        content:Stack(
          children: [ 
          // ignore: sized_box_for_whitespace
          Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            clipBehavior: Clip.none,
            itemCount: 2,
            itemBuilder: (BuildContext context1, int index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        ),
        ])
      );
    },
  );
        },
        backgroundColor:AppColors.primary,
        child: const Icon(Icons.add,color: Colors.black,),
      ),);
      }
      );
  }
}