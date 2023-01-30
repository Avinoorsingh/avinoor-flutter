import 'package:colab/constants/colors.dart';
import 'package:colab/network/labourData/labour_data_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controller/signInController.dart';
import '../theme/text_styles.dart';

class LabourData extends StatefulWidget {
  const LabourData({Key? key,}) : super(key: key);

  @override
  State<LabourData> createState() => _LabourState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class _LabourState extends State<LabourData> {
  final getLabourByDate = Get.find<GetLabourDataToday>();
  List<String?> contractorName=[];
  List<String?> name=[];
  List<String?> inTime=[];
  List<String?> otRate=[];
  List<String?> hours=[];
  
  List<String?> outTime=[];
  List dateOfLabourData=[];
  List dateDifference=[];
  TextEditingController dateInput = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  TextEditingController labourDate = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
 
 @override
 void initState(){
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return 
    GetBuilder<GetLabourDataToday>(builder: (_){
    final signInController=Get.find<SignInController>();
    if(signInController.getLabourByDate!=null){
     if(signInController.getLabourByDate!.data!.isNotEmpty && contractorName.isEmpty){
      for(int i=0;i<signInController.getLabourByDate!.data!.length;i++){
        contractorName.add(signInController.getLabourByDate!.data![i].contractorName??"");
        name.add(signInController.getLabourByDate!.data![i].name??"");
        inTime.add(signInController.getLabourByDate!.data![i].inTime??"--");
        outTime.add(signInController.getLabourByDate!.data![i].outTime??"--");
        hours.add(signInController.getLabourByDate!.data![i].workingHours.toString());
        otRate.add(signInController.getLabourByDate!.data![i].otRate.toString());
        dateOfLabourData.add(signInController.getLabourByDate!.data![i].labourDate);
      }
     }
    }
    EasyLoading.dismiss();
    return 
    Scaffold(
    appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Labour Data",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
    body:
    Container(margin: const EdgeInsets.only(top: 10),
    child:
    ListView(
      children: [
          Container(
            height: 35,
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,top: 10),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            TextField(
              decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit_calendar),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,),
              readOnly: true,
              controller: dateInput,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    builder: (BuildContext context, Widget? child){
                    return Theme(
                      data: ThemeData.light().copyWith(
                          primaryColor: AppColors.primary,
                          buttonTheme: const ButtonThemeData(
                            textTheme: ButtonTextTheme.primary
                          ), colorScheme: const ColorScheme.light(primary:AppColors.primary,).copyWith(secondary: const Color(0xFF8CE7F1)),
                      ),
                     child: child!,
                    );
                    }, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      contractorName.clear();
                      name.clear();
                      inTime.clear();
                      outTime.clear();
                      hours.clear();
                      otRate.clear();
                      dateOfLabourData.clear();
                      dateInput.text =formattedDate;
                      await getLabourByDate.getContractorListData(context: context, date: formattedDate);
                      setState(() {});
                      setState(() {});
                } else {}
              },
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 20),
            ),
         ),
        contractorName.isNotEmpty?
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: contractorName.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 
                        Column(
                          children: [
                        Row(children: [
                          Text("${name[index]}",style: textStyleHeadline4.copyWith(fontSize: 14),)
                        ]),
                        const SizedBox(height: 8,),
                          Row(children: [
                          Text("${contractorName[index]}", style: textStyleBodyText1.copyWith(fontSize: 14,color: Colors.grey),)
                        ]),
                        const SizedBox(height: 8,),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 10, right:10),
                              height: 50.0,
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("In-Time", style: textStyleBodyText1.copyWith(fontSize: 14,color: Colors.grey),),
                                const SizedBox(height: 5,),
                                Text("${inTime[index]}", style: textStyleHeadline4.copyWith(fontSize: 14),),
                              ]),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right:10),
                              height: 50.0,
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                 ),
                               ),
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Out-Time", style: textStyleBodyText1.copyWith(fontSize: 14,color: Colors.grey),),
                                const SizedBox(height: 5,),
                                Text("${outTime[index]}", style: textStyleHeadline4.copyWith(fontSize: 14),),
                              ]),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              padding: const EdgeInsets.only(left: 10,right:10),
                              height: 50.0,
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hours", style: textStyleBodyText1.copyWith(fontSize: 14, color: Colors.grey),),
                                const SizedBox(height: 5,),
                                Text("${hours[index]}", style: textStyleHeadline4.copyWith(fontSize: 14),),
                              ]),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right:10),
                              height: 50.0,
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("OT Rate", style: textStyleBodyText1.copyWith(fontSize: 14,color: Colors.grey),),
                                const SizedBox(height: 5,),
                                Text("${otRate[index]}", style: textStyleHeadline4.copyWith(fontSize: 14),),
                              ]),
                            ),
                          ],
                        ),
                         Column(
                          children: [
                          const SizedBox(height: 20,),
                        Row(children: [
                          Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(dateOfLabourData[index])),style: textStyleBodyText1.copyWith(fontSize: 14,color: Colors.grey),)
                        ]),
                        ])
                    ]),
                    ));
                    }
                  )
        ):Center(child:Container(margin:const EdgeInsets.only(top: 100), child: Text("No data Available for this date.",style: textStyleBodyText3,),),),
      ],
    )),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('ADDLABOURDATA');
        },
        backgroundColor:AppColors.primary,
        child: const Icon(Icons.add,color: Colors.black,),
      ));
  });
}
}