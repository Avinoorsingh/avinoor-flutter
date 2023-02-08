import 'package:go_router/go_router.dart';
import 'package:colab/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../models/snag_offline.dart';
import '../../../services/local_database/local_database_service.dart';
import '../../../theme/text_styles.dart';

class OnGoingProgressOffline extends StatefulWidget {
  const OnGoingProgressOffline({Key? key,}) : super(key: key);

  @override
  State<OnGoingProgressOffline> createState() => _OnProgressState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;
// ignore: prefer_typing_uninitialized_variables
var update;

class _OnProgressState extends State<OnGoingProgressOffline> {
  List<String?> locationName=[];
  List<int?> locationDraft=[];
  List<int?> locationCount=[];
  List<String?> subLocationName=[];
  List<int?> subLocationCount=[];
  List<int?> subLocationID=[];
  List<int?> subLocationDraft=[];
  List<String?> subSubLocationName=[];
  List<String?> subSubLocationID=[];
  List<int?> subSubLocationCount=[];
  List<int?> subSubLocationDraft=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<int?> locationID=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  int? selectedIndex=-1;
  int? selectedIndex1=-1;
  int? selectedIndex2=-1;
  TextEditingController locationIDController=TextEditingController();
  TextEditingController subLocationIDController=TextEditingController();
  TextEditingController clientIDController=TextEditingController();
  TextEditingController projectIDController=TextEditingController();
  TextEditingController subLocationNameController=TextEditingController();
  TextEditingController subSubLocationNameController=TextEditingController();
  TextEditingController locationNameController=TextEditingController();
  List<SnagDataOffline> snagDataOffline=[];
  List snagData2=[];
  late DatabaseProvider databaseProvider;
  List formDataList = [];
  
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
     setState(() {
      snagDataOffline;
    });
    await fetchSnagsFromLocal();
    return snagDataOffline;
  }

  fetchSnagsFromLocal() async {
     formDataList=await databaseProvider.getAllOfflineModel();
     setState(() {
       
     });
  }

  @override
  Widget build(BuildContext context) {
     if(formDataList.isNotEmpty && locationName.isEmpty){
      for(int i=0;i<formDataList.length;i++){
        for(int j=0;j<formDataList[i].locationOfflineData.length;j++){
          locationName.add(formDataList[i].locationOfflineData[j].locationName);
          locationDraft.add(0);
          locationID.add(formDataList[i].locationOfflineData[j].locationId);
          locationCount.add(formDataList[i].locationOfflineData[j].countLoc??0);
        }
     }
     }
    EasyLoading.dismiss();
    return 
    Scaffold(
    floatingActionButton:FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            context.pushNamed('ADDPROGRESSENTRY');
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add,color: AppColors.black,),
        ),
    body: 
    Container(margin: const EdgeInsets.only(top: 90),
    child:
    ListView(
      key: Key(selectedIndex.toString()),
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: locationName.length,
              key:Key(selectedIndex.toString()),
              itemBuilder: (BuildContext context, int index){
                return 
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                    child:
                      ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: 
                        ExpansionTile(
                        key:Key(selectedIndex.toString()),
                        initiallyExpanded: index == selectedIndex,
                        childrenPadding:const EdgeInsets.only(left: 10,right: 10),
                        tilePadding: const EdgeInsets.only(bottom: 20,left: 10,right: 10),
                        collapsedBackgroundColor: AppColors.navyblue,
                        collapsedIconColor: AppColors.white,
                        iconColor: AppColors.white,
                        backgroundColor: AppColors.navyblue,
                        title:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Text(locationName[index]!,style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 18),),
                        locationCount[index]!=0?Text("${locationCount[index]} Activities ( ${locationDraft[index]} drafts )  ",style: textStyleBodyText3.copyWith(color: AppColors.white,fontWeight: FontWeight.w300,fontSize: 12),):const Text("")
                        ]),
                        onExpansionChanged:
                         (bool t) async{
                          if (t==true) {
                            setState(() {selectedIndex = index;});
                             subLocationName.clear();
                             subLocationID.clear();
                             subLocationCount.clear();
                             subLocationDraft.clear();
                                try {
                                  locationIDController.text=locationID[index].toString();
                                  locationNameController.text=locationName[index].toString();
                                      subLocationName.clear();
                                      subLocationID.clear();
                                      subLocationCount.clear();
                                      subLocationDraft.clear();
                                      var subLocData=[];
                                      for(int i=0;i<formDataList.length;i++){
                                        for(int j=0;j<formDataList[i].locationOfflineData.length;j++){
                                          if(formDataList[i].locationOfflineData[j].locationId==int.parse(locationIDController.text)){
                                            subLocData=formDataList[i].locationOfflineData[j].subLocationInfo;
                                          }
                                        }
                                      }
                                      for(int i=0;i<subLocData.length;i++){
                                      subLocationName.add(subLocData[i].subLocationName);
                                      subLocationID.add(subLocData[i].subLocId);
                                      subLocationCount.add(0);
                                      subLocationDraft.add(subLocData[i].countSubLoc);
                                    }
                                    setState(() {});
                                    }
                                    catch(e){
                                      if (kDebugMode) {
                                        print("Error");
                                        print(e);
                                      }
                                    }
                                 } else {
                                setState(() => selectedIndex = -1);
                              }},
                        children: [
                        ListView.builder(
                            key:Key(selectedIndex1.toString()),
                            shrinkWrap: true,
                            itemCount: subLocationName.length,
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
                        key:Key(selectedIndex1.toString()),
                        initiallyExpanded: index==selectedIndex1,
                        childrenPadding:const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        tilePadding: const EdgeInsets.only(left: 10,),
                        collapsedBackgroundColor: AppColors.lightBlue,
                        collapsedIconColor: Colors.transparent,
                        iconColor: Colors.transparent,
                        backgroundColor: AppColors.lightBlue,
                        trailing: null,
                        onExpansionChanged:
                              (bool t)  async{
                             if(t==true){
                             setState(() {selectedIndex1 = index;});
                             subSubLocationName.clear();
                             subSubLocationCount.clear();
                             subSubLocationDraft.clear();
                             subSubLocationID.clear();
                             subLocationIDController.text=subLocationID[index].toString();
                             subLocationNameController.text=subLocationName[index].toString();
                              try {
                              subSubLocationName.clear();
                              subSubLocationCount.clear();
                              subSubLocationDraft.clear();
                              subSubLocationID.clear();
                              var subSubLocData=[];
                              for(int i=0;i<formDataList.length;i++){
                                for(int j=0;j<formDataList[i].locationOfflineData.length;j++){
                                      for(int k=0;k<formDataList[i].locationOfflineData[j].subLocationInfo.length;k++){
                                        if(formDataList[i].locationOfflineData[j].subLocationInfo[k].subLocId==int.parse(subLocationIDController.text)){
                                          subSubLocData=formDataList[i].locationOfflineData[j].subLocationInfo[k].subSubLocationInfo;
                                        }
                                      }
                                    }
                                  }
                                if(subSubLocData.isNotEmpty){
                                  for(int i=0;i<subSubLocData.length;i++){
                                    subSubLocationName.add(subSubLocData[i].subSubLocationName);
                                    subSubLocationCount.add(subSubLocData[i].countSubSubLoc);
                                    subSubLocationDraft.add(0);
                                    subSubLocationID.add(subSubLocData[i].subLocationId.toString());
                                  }
                                }
                                setState(() {});
                               }
                                catch(e){
                                  subSubLocationName.clear();
                                  subLocationID.clear();
                                  setState(() {});
                                  if (kDebugMode) {
                                    print("Error is here");
                                    print(e);
                                    }
                                  }
                                 } else {
                                  setState(() {
                                     selectedIndex1=-1;
                                  });
                                 }},
                        title:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Text(subLocationName[index]!,style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.normal),),
                        // ignore: unrelated_type_equality_checks
                        (subLocationDraft[index]!=null)?Text("${subLocationDraft[index]} Activities ( ${subLocationCount[index]} drafts )    ",style: textStyleBodyText3.copyWith(color: AppColors.white,fontWeight: FontWeight.w300,fontSize: 12),):const Text("")
                        ]),
                        children: [
                        ListView.builder(
                        key: Key(selectedIndex2.toString()),
                        shrinkWrap: true,
                        itemCount: subSubLocationName.length,
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
                        SizedBox(
                          height: 60,
                          child: 
                        ExpansionTile(
                        initiallyExpanded: index == selectedIndex2,
                        tilePadding: const EdgeInsets.only(left: 10,),
                        collapsedBackgroundColor: AppColors.extraLightBlue,
                        collapsedIconColor: Colors.transparent,
                        iconColor: Colors.transparent,
                        backgroundColor: AppColors.extraLightBlue,
                        trailing: null,
                        title:
                            InkWell(
                            onTap: (){
                              context.pushNamed('ONGOINGHOMESCREENOFFLINE',queryParams:{"cID":clientIDController.text,"pID":projectIDController.text,"locID":locationIDController.text.toString(),"subLocID":subLocationIDController.text.toString(),"subSubLocID":subSubLocationID[index]!,"loc":locationNameController.text,"subLoc":subLocationNameController.text,"subSubLoc":subSubLocationName[index]!} );
                            },
                            child: 
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(subSubLocationName[index]!,style: textStyleHeadline4.copyWith(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.normal),),
                          subSubLocationCount[index]!=null?Text("${subSubLocationCount[index]} Activities ( ${subSubLocationDraft[index]} drafts )    ",style: textStyleBodyText3.copyWith(color: AppColors.white,fontWeight: FontWeight.w300,fontSize: 12),):const Text("")
                          ]),
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
))
);
}
}