import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../theme/text_styles.dart';

class InQualityProgress extends StatefulWidget {
  const InQualityProgress({Key? key,}) : super(key: key);

  @override
  State<InQualityProgress> createState() => _InQualityProgressState();
}

bool show=false;
late var tapped;

class _InQualityProgressState extends State<InQualityProgress> {
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
              return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      child:
                      ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: 
                        ExpansionTile(
                        childrenPadding:const EdgeInsets.only(left: 10,right: 10),
                        tilePadding: const EdgeInsets.only(bottom: 20,left: 10),
                        collapsedBackgroundColor: AppColors.navyblue,
                        collapsedIconColor: Colors.transparent,
                        iconColor: Colors.transparent,
                        backgroundColor: AppColors.navyblue,
                        trailing: null,
                        title: Text('Tower $index',style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 18),),
                        children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return
                        Card(
                          color: AppColors.navyblue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        child:
                        ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child:
                        ExpansionTile(
                        childrenPadding:const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        tilePadding: const EdgeInsets.only(left: 10,),
                        collapsedBackgroundColor: AppColors.lightBlue,
                        collapsedIconColor: Colors.transparent,
                        iconColor: Colors.transparent,
                        backgroundColor: AppColors.lightBlue,
                        trailing: null,
                        title: Text('Gr Floor',style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.normal),),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return
                              Card(
                              color: AppColors.extraLightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                                child:
                                ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child:
                                Container(
                                  height: 60,
                                  child: 
                                ExpansionTile(
                                tilePadding: const EdgeInsets.only(left: 10,),
                                collapsedBackgroundColor: AppColors.extraLightBlue,
                                collapsedIconColor: Colors.transparent,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.extraLightBlue,
                                trailing: null,
                                title: InkWell(
                                  onTap: (){
                                    context.pushNamed('COMPLETEDPARTICULARPROGRESS');
                                  },
                                  child:  Text('U1',style: textStyleHeadline3.copyWith(color: AppColors.white,fontSize: 14,fontWeight: FontWeight.normal),),
                                ),
                              )
                            )
                          )
                        );
                      }
                    )
                  ],
                ),
              )
            );
          }
        )
      ],
    ),
  )
);
}
)
),
],
)
)
);
}
}