import 'package:colab/constants/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../models/snag_offline.dart';
import '../../../../services/local_database/local_database_service.dart';
import '../../../../theme/text_styles.dart';

class NewSnagOffline extends StatefulWidget {
  const NewSnagOffline({Key? key,}) : super(key: key);

  @override
  State<NewSnagOffline> createState() => _NewSnagOfflineState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;
// ignore: prefer_typing_uninitialized_variables
var update;

class _NewSnagOfflineState extends State<NewSnagOffline> {
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List<SnagDataOffline> snagData=[];
  List snagData2=[];
  late DatabaseProvider databaseProvider;
  List dateDifference=[];
  List formDataList = [];
  FormData formData=FormData(); 
  var dio = Dio();
  bool b=false;
 
 @override
 void initState(){
  databaseProvider = DatabaseProvider();
  databaseProvider.init();
  super.initState();
  fetchSnagData();
  super.initState();
 }

  Future<List<SnagDataOffline>> fetchSnagData() async {
    snagData= await databaseProvider.getSnagModel();
    await fetchSnagsFromLocal();
     setState(() {
      snagData;
    });
    return snagData;
  }

  fetchSnagsFromLocal() async {
    formDataList=await databaseProvider.getSnagFormData();
    // List<dynamic> snagsDataList = formDataList.map((snag) => snag['snags_data']).toList();
    // // Iterate through each snag
    // if(snagsDataList.isNotEmpty){
    //    formData.fields.add(MapEntry('snags_data',jsonEncode(snagsDataList)));
    // }
    // for (int i = 0; i < formDataList.length; i++) {
    //   Map<String, dynamic> snag = formDataList[i];
    //   // Iterate through each viewpoint in the snag
    //   snag.forEach((key, value) {
    //     if (key.startsWith("viewpoint_")) {
    //       // Add the viewpoint file to the formData
    //       formData.files.add(MapEntry(key, MultipartFile.fromFileSync(value, filename: "image${i + 1}")));
    //     }
    //   });
    // }
    //   for (int i = 0; i < formDataList.length; i++) {
    //   Map<String, dynamic> markup = formDataList[i];
    //   // Iterate through each viewpoint in the snag
    //   markup.forEach((key, value) {
    //     if (key.startsWith("markup_")) {
    //       // Add the viewpoint file to the formData
    //       if(value.isNotEmpty){
    //       formData.files.add(MapEntry(key, MultipartFile.fromFileSync(value, filename: "image${i + 1}")));
    //       }
    //       else{
    //          formData.fields.add(const MapEntry('markup_file', ''));
    //       }
    //     }
    //   });
    // }
    //  try {
    //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //   var token=sharedPreferences.getString('token');
    //   var res=await dio.post(
    //     "http://nodejs.hackerkernel.com/colab/api/add_offline_snags",
    //     data: formData,
    //     options: Options(
    //       followRedirects: false,
    //       validateStatus: (status) {
    //         return status! < 500;
    //         },
    //         headers: {
    //           "authorization": "Bearer ${token!}",
    //           "Content-type": "application/json",
    //           },
    //       ),
    //     );
    //     if (kDebugMode) {
    //       print(res.data);
    //     }
    //     EasyLoading.showToast("Snag Saved",toastPosition: EasyLoadingToastPosition.bottom);
    //     } catch (e) {
    //     EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
    //     EasyLoading.dismiss();
    //     if (kDebugMode) {
    //       print(e);
    //     }
    //   }
    // if (kDebugMode) {
    //   print("######################");
    //   // print(formData.fields);
    // }
  }

  @override
  Widget build(BuildContext context) {
    if(mounted){
      fetchSnagsFromLocal();
        setState(() {});
    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputFormat1 = DateFormat('dd/MM/yyyy');
     if(snagData.isNotEmpty && subLocationName.isEmpty){
      for(int i=0;i<snagData.length;i++){
       if(snagData[0].data![i].snagStatus=="N"){
       subLocationName.add("${snagData[0].data![i].subLocation!.subLocationName} / ${snagData[0].data![i].subSubLocation!.subSubLocationName}");
       subSubLocationName.add("");
       locationName.add(snagData[0].data![i].location!.locationName);
       remark.add(snagData[0].data![i].remark);
       dueDates.add(snagData[0].data![i].dueDate);
       createdDates.add(snagData[0].data![i].createdAt);
       snagData2.add(snagData[0].data![i]);
       dateDifference.add(DateTime.now().difference(DateTime.parse(snagData[0].data![i].createdAt!)).inDays);
      }
      }
      if(formDataList.isNotEmpty){
        for(int i=0;i<formDataList.length;i++){
            subLocationName.add(formDataList[i]['snags_info']['subLocName']);
            subSubLocationName.add(formDataList[i]['snags_info']['subSubLocName']);
            locationName.add(formDataList[i]['snags_info']['locationName']);
            remark.add(formDataList[i]['snags_data']['remark']);
            dueDates.add(formDataList[i]['snags_data']['due_date']);
            createdDates.add(formDataList[i]['snags_data']['due_date']);
            snagData2.add(formDataList[i]);
            dateDifference.add(DateTime.now().difference(DateTime.parse(formDataList[i]['snags_data']['due_date']!)).inDays); 
        }
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                width: 335,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${subLocationName[index]}",style: textStyleHeadline4.copyWith(fontSize: 14),),
                                    Text("${locationName[index]}",style: textStyleHeadline4.copyWith(fontSize: 14),),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text("Date: ${outputFormat1.format(DateTime.parse(createdDates[index]!))}",style: textStyleHeadline4.copyWith(fontSize: 10,color: Colors.grey),),
                                      Text("Due Date: ${outputFormat.format(DateTime.parse(dueDates[index]!))}",style: textStyleHeadline4.copyWith(fontSize: 10,color: Colors.grey),),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                  ],),
                            )),
                            ),
                            Positioned(
                              top: 10,
                              bottom: 20,
                              left: 320,
                              child: InkWell(
                                onTap: () {},
                                child:  Center(
                                  child:  Container(
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
                        if(show==true && index==tapped)
                        Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 0),
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 50,
                            width: 330,
                            decoration: BoxDecoration(
                                    color:  Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                            child:InkWell(
                              onTap: (){
                                if (kDebugMode) {
                                  print(snagData2[index]);
                                }
                                // context.pushNamed('SNAGDETAILOFFLINE',
                                // queryParams: {"from": "new"},
                                // extra: snagData2[index]);
                              },
                              child: 
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Text("Snag Remark: ",style: textStyleHeadline4,overflow: TextOverflow.ellipsis,),
                              Text((remark[index]!=null? (remark[index]!.length>30?"${remark[index]!.substring(0,29)}...":remark[index] ?? ""):""),style: textStyleBodyText2,overflow: TextOverflow.ellipsis,),
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
          context.pushNamed('ADDSNAGOFFLINE');
        },
        backgroundColor:AppColors.primary,
        child: const Icon(Icons.add,color: Colors.black,),
      ),);
      }
  }