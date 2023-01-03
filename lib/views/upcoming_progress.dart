import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../theme/text_styles.dart';

class UpcomingProgress extends StatefulWidget {
  const UpcomingProgress({Key? key,}) : super(key: key);

  @override
  State<UpcomingProgress> createState() => _UpcomingProgressState();
}

bool show=false;
late var tapped;

class _UpcomingProgressState extends State<UpcomingProgress> {
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
 
 @override
 void initState(){
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputFormat1 = DateFormat('dd/MM/yyyy');
    // return 
    // GetBuilder<GetCompletedSiteProgress>(builder: (_){
    //   final signInController=Get.find<SignInController>();
    //  if(signInController.getSnagDataList!.data!.isNotEmpty && subLocationName.isEmpty){
    //   for(int i=0;i<signInController.getSnagDataList!.data!.length;i++){
    //    subLocationName.add(signInController.getSnagDataList!.data![i].subLocation!.subLocationName);
    //    subSubLocationName.add(signInController.getSnagDataList!.data![i].subSubLocation!.subSubLocationName);
    //    locationName.add(signInController.getSnagDataList!.data![i].location!.locationName);
    //    remark.add(signInController.getSnagDataList!.data![i].remark);
    //    dueDates.add(signInController.getSnagDataList!.data![i].dueDate);
    //    createdDates.add(signInController.getSnagDataList!.data![i].createdAt);
    //    snagData.add(signInController.getSnagDataList!.data![i]);
    //    dateDifference.add(DateTime.parse(signInController.getSnagDataList!.data![i].dueDate!).difference(DateTime.parse(signInController.getSnagDataList!.data![i].createdAt!)).inDays);
    //   }
    //  }
    EasyLoading.dismiss();
    return 
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 90),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
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
                                    child:Center(child: Text("Column Reinforcement",
                                    style: textStyleHeadline4.copyWith(fontSize: 14,color: AppColors.white),),),),
                                    const SizedBox(height: 10,),
                                    Center(child:Text("Tower 2 / Gr Floor / Common 1",style: textStyleBodyText2),),
                                    Center(child:Text("Irshad Khan-COMP 3",style: textStyleBodyText2,),),
                                    Container(width: 200, 
                                    decoration:const BoxDecoration(
                                    color: Color.fromARGB(255, 6, 203, 6),
                                   ), 
                                   child:
                                    Center(child:Text("Checklist Available",style: textStyleBodyText2,),),),
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
                                    child:Center(child: Text("19/02/2022",
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
                                    child:Center(child: Text("19/02/2022",
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
  }))])));
  }
}