import 'dart:convert';
import 'package:colab/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:image_painter/image_painter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';
import 'package:http/http.dart' as http;
import '../network/labourData/labour_data_network.dart';

// ignore: must_be_immutable
class AddLabourData extends StatefulWidget {
  AddLabourData({Key? key,from}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var from;

  @override
  State<AddLabourData> createState() => _AddLabourDataState();
}

class _AddLabourDataState extends State<AddLabourData> {
  final getLabourDataOfSelectedContractor=Get.find<GetSelectedContractorData>();
  final getLabourDataContractorListController=Get.find<GetLabourDataContractor>();
  final getLabourDataOfSelectedContractorController=Get.find<GetSelectedContractorData>();
  final getLabourDataTodayController=Get.find<GetLabourDataToday>();
  List<String?> contractorName=[];
  List<String?> name=[];
  List inTime=[];
  List contractorID=[];
  List contractorLabourLinkingID=[];
  List<String?> otRate=[];
  List<String?> hours=[];
  List<String?> rate=[];
  List dateOfLabourData=[];
  List<String> contractorList=[];
  List contractorData=[];
  List selectedContractorData=[];
  List<int> contractorListID=[];
  final imageKey = GlobalKey<ImagePainterState>();
  TimeOfDay? selectedTime;
  final timeController = TextEditingController();
  
  late List<bool> isSelected;
  
    @override
  void initState() {
    super.initState(); 
    isSelected=[true,false,false];
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    getLabourDataOfSelectedContractor.getSelectedContractorData(context: context);
  }
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetLabourDataContractor>(builder: (_){
      final signInController=Get.find<SignInController>();
      if(signInController.getLabourDataContractorListData!=null){
        if(signInController.getLabourDataContractorListData!.data!=null){
      if(signInController.getLabourDataContractorListData!.data!.isNotEmpty && contractorList.isEmpty){
        contractorList.add("Select Name");
        contractorListID.add(88899182);
        for(int i=0;i<signInController.getLabourDataContractorListData!.data!.length;i++){
          if(signInController.getLabourDataContractorListData!.data![i].type=="supply"){
          contractorList.add(signInController.getLabourDataContractorListData!.data![i].contractorName.toString());
          contractorListID.add(signInController.getLabourDataContractorListData!.data![i].pid!);
          }
        }
      }
        }
      }
      if(signInController.getLabourDataOfSelectedContractor!=null){
        if(signInController.getLabourDataOfSelectedContractor!.data!=null){
      if(signInController.getLabourDataOfSelectedContractor!.data!.isNotEmpty && contractorData.isEmpty){
        for(int i=0;i<signInController.getLabourDataOfSelectedContractor!.data!.length;i++){
          contractorData.add(signInController.getLabourDataOfSelectedContractor!.data![i]);
        }
      }
      }
    }
    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.primary,
        title: Text("Labour Attendance",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const SizedBox(height: 20,),
          Center(child: Text("Contractor Name", style: textStyleBodyText1,),),
          Container(
           margin:const EdgeInsets.only(left: 10,right: 10),
           padding: const EdgeInsets.only(bottom: 20,),
            child: 
           DropdownButtonFormField(
             value:contractorList.isNotEmpty?contractorList[0]:"Select Name",
             icon: const Padding( 
              padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_outlined,size: 30)
             ), 
            iconEnabledColor: Colors.grey,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14
            ), 
          dropdownColor: AppColors.white,
          decoration: const InputDecoration(enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
          isExpanded: false,
          isDense: true,
          items: contractorList.map((String items){
              return DropdownMenuItem(
                  value: items,
                  child:Container(
                  padding:const EdgeInsets.only(left:10,right: 10),
                  child: Text(items),
                ));
              }).toList(),
              onChanged: (String? newValue) async{
                  selectedContractorData.clear();
                   contractorName.clear();
                   name.clear();
                   inTime.clear();
                   rate.clear();
                   hours.clear();
                   otRate.clear();
                   contractorID.clear();
                   contractorLabourLinkingID.clear();
                   dateOfLabourData.clear();
                if(newValue!="Select Name"){
                  if(contractorData.isNotEmpty){
                  for(int i=0;i<contractorData.length;i++){
                   if(contractorData[i].clientContractorId==contractorListID[contractorList.indexOf(newValue!)]){
                    selectedContractorData.add(contractorData[i]);
                    name.add(contractorData[i].name);
                    rate.add(contractorData[i].rate.toString());
                    otRate.add(contractorData[i].otRate.toString());
                    inTime.add("00:00 AM");
                    contractorID.add(contractorListID[contractorList.indexOf(newValue)]);
                    hours.add(contractorData[i].workingHrs.toString());
                    contractorLabourLinkingID.add(contractorData[i].id);
                   }
                  }
                  }
                }
                   setState(() {});
              }
           )),
           const SizedBox(height: 10,),
           if(name.isNotEmpty)
           ListView.builder(
                shrinkWrap: true,
                itemCount: selectedContractorData.length,
                itemBuilder: (context, index) {
                  return 
                  Container(
                    margin:const EdgeInsets.only(left: 10,right: 10),
                    child: 
                  Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 
                        Column(
                          children: [
                        Row(children: [
                          Text("${name[index]}", style: textStyleHeadline4.copyWith(fontSize: 14),)
                        ]),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 10, right:10),
                              height: 50.0,
                              width: 100,
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Rate", style: textStyleBodyText1.copyWith(fontSize: 14,color: Colors.grey),),
                                const SizedBox(height: 5,),
                                Text("${rate[index]}", style: textStyleHeadline4.copyWith(fontSize: 14),),
                              ]),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right:10),
                              height: 50.0,
                              width: 100,
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                 ),
                               ),
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("OT Rate", style: textStyleBodyText1.copyWith(fontSize: 14,color: Colors.grey),),
                                const SizedBox(height: 5,),
                                Text("${otRate[index]}", style: textStyleHeadline4.copyWith(fontSize: 14),),
                              ]),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              padding: const EdgeInsets.only(left: 10,right:10),
                              height: 50.0,
                              width: 100,
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(child:
                                Column(children: [
                                Text("In Time", style: textStyleBodyText1.copyWith(fontSize: 14, color: Colors.grey),),
                                const SizedBox(height: 5,),
                                Text(inTime[index].toString(), style: textStyleHeadline4.copyWith(fontSize: 14),),
                                ]),
                                onTap: () async {
                                selectedTime=null;
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime == null ? TimeOfDay.now() : TimeOfDay.fromDateTime(DateTime.parse(selectedTime.toString())),
                                );
                                if (picked != null) {
                                  setState(() {
                                    selectedTime = picked;
                                    inTime[index]=selectedTime?.format(context);
                                  });
                                }
                              },
                            ),
                              ]),
                            ),
                            const SizedBox(width: 10,),
                          ],
                        ),]))));
                },
              ),
              Align(
              child:
              Container(margin:EdgeInsets.only(left: 10,right: 10,top:otRate.length<=3?otRate.length<2?500:200:50),
              child:
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/3,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(100),
                   gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Colors.black,Color.fromARGB(255, 131, 124, 124)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                   Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(174, 218, 108, 108),Color.fromARGB(251, 236, 85, 85)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                    if(otRate.isNotEmpty){
                      try {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                     var token=sharedPreferences.getString('token');
                     var projectID=sharedPreferences.getString('projectIdd');
                     var clientID=sharedPreferences.getString('client_id');
                     List finalList = [];
                     for (int i = 0; i < otRate.length; i++) {
                      finalList.add({
                              "client_id":clientID.toString(),
                              "project_id":projectID.toString(),
                              "contractor_id": int.parse(contractorID[i].toString()),
                              "contractor_labour_linking_id":int.parse(contractorLabourLinkingID[i].toString()),
                              "in_time":  DateFormat("HH:mm").format(DateFormat("h:mm a").parse(inTime[i])).toString(),
                              "labour_date": DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                              "out_time": null,
                              "working_hours": int.parse(hours[i]!),
                              "ot":int.parse(otRate[i]!),
                          });
                        }
                    var res=await http.post(
                    Uri.parse(Config.saveLabourDataApi),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body:jsonEncode(finalList)
                          );
                    if (kDebugMode) {
                      print(res);
                      print(finalList);
                      print(res.body);
                      print("hello");
                    }
                    if(res.statusCode==200){
                    EasyLoading.showToast("Saved",toastPosition: EasyLoadingToastPosition.bottom);
                    } 
                    await getLabourDataContractorListController.getContractorListData(context: context);
                    await getLabourDataOfSelectedContractorController.getSelectedContractorData(context: context);
                    await getLabourDataTodayController.getContractorListData(context: context, date:DateFormat('yyyy-MM-dd').format(DateTime.now()));
                    Get.put(GetLabourDataContractor());
                    Get.put(GetSelectedContractorData());
                    Get.put(GetLabourDataToday());
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);           
                    } catch (e) {
                      EasyLoading.showToast("server error occured", toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     if (kDebugMode) {
                       print(e);
                     } 
                    }
                    }
                    else{
                       EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  },
                  child: const Center(
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              ],
            )))
          ])
        )
    );
  }
    );
  }
}