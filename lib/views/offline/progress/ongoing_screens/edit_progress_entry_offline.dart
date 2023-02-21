import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:colab/config.dart';
import 'package:colab/models/labour_attendance.dart';
import 'package:colab/models/progress_contractor.dart';
import 'package:colab/models/progress_trade_data.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:http/http.dart' as http;
import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/colors.dart';
import '../../../../controller/signInController.dart';
import '../../../../services/local_database/local_database_service.dart';


// ignore: must_be_immutable
class EditProgressEntryOffline extends StatefulWidget {
  EditProgressEntryOffline({Key? key, this.from, this.editModel }) : super(key: key);

 // ignore: prefer_typing_uninitialized_variables
 final from;
 dynamic editModel;
  @override
  State<EditProgressEntryOffline> createState() => _ProgressState();
}

class _ProgressState extends State<EditProgressEntryOffline> {
  final signInController=Get.find<SignInController>();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final activityController = TextEditingController();
  final linkingActivityId=TextEditingController();
  final activityHeadController = TextEditingController();
  final otherLocationController = TextEditingController();
  final remarkController=TextEditingController();
  final projectId=TextEditingController();
  final clientId = TextEditingController();
  final assignedToController=TextEditingController();
  final statusController = TextEditingController();
  final quantityController=TextEditingController();
  final priorityController=TextEditingController();
  Random random = Random();
  late int randomNumber;
  final clientID=TextEditingController();
  final projectID=TextEditingController();
  final activityID=TextEditingController();
  TextEditingController totalQuantity=TextEditingController();
  TextEditingController dateInput=TextEditingController();
  TextEditingController achivedController=TextEditingController();
  TextEditingController comulativeController=TextEditingController();
  TextEditingController contractorIDIndex = TextEditingController();
  TextEditingController progressID = TextEditingController();
  final uomName=TextEditingController();
  final type=TextEditingController();
  List<bool> isCardEnabled2 = [];
  List<String> toggleList=[
    "Labour Supply",
    "PRW",
   ];
  TextEditingController achivedQuantity=TextEditingController();
  TextEditingController comulativeQuantity=TextEditingController(); 
  var _sliderValue=0.0;
  bool? update=false;
  List<String> contractorList=[];
  TextEditingController contractorController=TextEditingController();
  String dropdownvalue = 'Select Contractor Name';  
  File?  _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage =File(image!.path);
    });
  }

  ///////////////////////////Progress Trade-Handler things//////////////////////
  Map<String, List<String>> groupedList = {};
  List groupedMapToList=[];
  final pwrContractorId=TextEditingController();
  final pwrContractorName=TextEditingController();
  List<dynamic> finalList=[];
  final List labourList=["Item 1"];
  final List<String> _items = ['Item 1'];
  final List<String> _dropdownValues = [];
  final List<int> _dropdownValuesID = [];
  final List<String> _selectedDropdownValues = ['Please Select'];
  final List<int> _selectedDropdownValuesID = [0];
  final List<String> enteredValues=[""];
  final List _items2 = [];
  final List mainDropdownValue = [];
  final List subItems = [];
  final List<String> _dropdownValues2 = [];
  final List<List<String>> _selectedDropdownValues2 = [];
  final List<TextEditingController> _controllers = [TextEditingController(text: "1",)];
  final List<List<TextEditingController>> _controllers2 = [];
  List<List> contractorLabourDetails=[];
  bool keyExists = false;
  final contractorLabourLinkingIDText=TextEditingController();
  List<String> debitTo = [];
  Map<String, dynamic> itemsDebit={};
  String dropdownvalueDebitTo = 'Select Debit to'; 
  final debitToController=TextEditingController(); 
  List<int> locationID=[];
  List<int> contractorID=[];
  Map<int, List<int>> contractorLabourLinkingId={};
  List<int> debitToID=[];
  late DatabaseProvider databaseProvider;
  List formDataList = [];
  // ignore: prefer_typing_uninitialized_variables
  var progressContractor;
  // ignore: prefer_typing_uninitialized_variables
  var labourAttendance;
  // ignore: prefer_typing_uninitialized_variables
  var progressTrade;

  double calculatepercentage(double amount, double taxPercent) {
    if (amount == 0 || taxPercent == 0) {
      return 0;
    } else {
      return (taxPercent * amount) / 100;
    }
  }

// declare variables for total quantity, tax percentage and achieved and cumulative quantities
      double? totalQuantity1;
      double? taxPercent1;
      double? achievedQuantity1;
      double? cumulativeQuantity1;

    void _addMore() {
    setState(() {
    _items.add('Item ${_items.length + 1}');
    _selectedDropdownValues.add(_dropdownValues[0]);
    _selectedDropdownValuesID.add(_dropdownValuesID[0]);
    enteredValues.add("");
    _controllers.add(TextEditingController(text: "1"));
    });
    }
    void _addMore2(outerIndex,innerIndex) {
    setState(() {
    });
    }
    void _deleteMore2(outerIndex,innerIndex) {
    setState(() {
    _selectedDropdownValues2[outerIndex].removeAt(innerIndex);
    _controllers2[outerIndex].removeAt(innerIndex);
    });
  }

  @override
  void initState() {
    super.initState(); 
    EasyLoading.dismiss();
    databaseProvider = DatabaseProvider();
    databaseProvider.init();
    getContractorForDebitModel();
    getLabourAttendanceModel();
    getProgressTrade();
    super.initState();
    try {
      if (kDebugMode) {
        print("jjjjjjjqjsqj");
        print(widget.editModel);
        print(widget.editModel['progress_filter']['locationName']);
        print("ERFVEEWFWEFsss");
      }
    locationController.text=widget.editModel['progress_filter']['locationName']??"";
    subLocationController.text=widget.editModel['progress_filter']['subLocationName']??"";
    subSubLocationController.text=widget.editModel['progress_filter']['subSubLocationName']??"";
    activityController.text=widget.editModel['progress_filter']['activity']??"";
    activityHeadController.text=widget.editModel['progress_filter']['activityHead']??"";
    uomName.text=widget.editModel['progress_filter']['uomName']??"";
    for(int i=0;i<widget.editModel['progress_data'].length;i++){
    quantityController.text=(widget.editModel['progress_data'][i]['total_quantity']??0).toString();
    projectID.text=(widget.editModel['progress_data'][i]['project_id']??"").toString();
    clientID.text=(widget.editModel['progress_data'][i]['client_id']??"").toString();
    activityID.text=(widget.editModel['progress_data'][i]['link_activity_id']??"").toString();
    achivedQuantity.text=(widget.editModel['progress_data'][i]['achived_quantity']??"0.0").toString();
    comulativeQuantity.text=(widget.editModel['progress_data'][i]['cumulative_quantity']??"0.0").toString();
    _sliderValue=double.parse((widget.editModel['progress_data'][i]['progress_percentage']??"0.0").toString());
    remarkController.text=widget.editModel['progress_data'][i]['remarks']??"";
    progressID.text="1";
    type.text=widget.editModel['progress_data'][i]['type'].toString();
    dateInput.text= DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.editModel['progress_data'][i]['progress_date']??DateTime.now()));
    }
    type.text=="0"?priorityController.text="Labour Supply":priorityController.text="PRW";
    } catch (e) {
     try{
    locationController.text=widget.editModel?.locationName??"";
    subLocationController.text=widget.editModel?.subLocationName??"";
    subSubLocationController.text=widget.editModel?.subSubLocationName??"";
    activityController.text=widget.editModel?.activity??"";
    activityHeadController.text=widget.editModel?.activityHead??"";
    quantityController.text=widget.editModel?.totalQuantity.toString()??"";
    uomName.text=widget.editModel?.uomName??"";
    projectID.text=widget.editModel?.projectId.toString()??"";
    clientID.text=widget.editModel?.clientId.toString()??"";
    activityID.text=widget.editModel?.linkActivityId.toString()??"";
    achivedQuantity.text=widget.editModel?.achivedQuantity.toDouble().toString()??"";
    comulativeQuantity.text=widget.editModel?.cumulativeQuantity.toDouble().toString()??"";
    _sliderValue=double.parse(widget.editModel?.progressPercentage.toString()??"0.0");
    remarkController.text=widget.editModel?.remarks??"";
    progressID.text=widget.editModel?.progressId.toString()??"";
    type.text=widget.editModel?.type.toString()??"";
    type.text=="0"?priorityController.text="Labour Supply":priorityController.text="PRW";
    dateInput.text= DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.editModel?.createdAt??DateTime.now()));
    }catch(e){
      if (kDebugMode) {
        print(e);
        print("Hey! error is here");
      }
    }
    }}

  Future<ProgressContractor> getContractorForDebitModel() async {
    progressContractor = await databaseProvider.getContractorForDebitModel();
    return progressContractor;
  }

  Future<LabourAttendance> getLabourAttendanceModel() async {
    labourAttendance = await databaseProvider.getLabourAttendanceModel();
    return labourAttendance;
  }

  Future<ProgressTrade> getProgressTrade() async {
    progressTrade = await databaseProvider.getTradeModel();
    return progressTrade;
  }


  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
      final signInController=Get.find<SignInController>();
      if(progressContractor!=null){
      if(progressContractor.data.isNotEmpty){
      if(progressContractor.data.isNotEmpty && contractorList.isEmpty){
        if(progressContractor.data.isNotEmpty && debitTo.isEmpty){
        List<ProgressDataContractorListData>? debitToList1=progressContractor.data;
        if(debitTo.isEmpty){
        debitTo.add("Select Debit to");
        debitToID.add(99999);
        itemsDebit={};
        for(var data in debitToList1!){
          itemsDebit[data.pid.toString()] = data.contractorName;
          debitTo.add(data.contractorName!);
          debitToID.add(data.pid!);
        }
        debitTo.toSet().toList();
        debitToID.toSet().toList();
        }
      }
      List<MainData>? contractorList1=labourAttendance.mainData;
        if(contractorList.isEmpty){
        contractorList.add("Select Contractor Name");
        subItems.add([]);
        contractorID.add(99999);
        contractorLabourLinkingId={28282828:[]};
        if(contractorList1!=null){
        for(var data in contractorList1){
          contractorList.add(data.contractorName!);
          contractorID.add(data.id!);
          subItems.add([]);
          if(data.labourDetails!.isNotEmpty){
          for(var data2 in data.labourDetails!){
             if (contractorLabourLinkingId.containsKey(data2.contractorId)) {
                    contractorLabourLinkingId[data2.contractorId]!.add(data2.contractorLabourLinkingId!);
                      } 
              else {
                    contractorLabourLinkingId[data2.contractorId!] = [data2.contractorLabourLinkingId!];
                  }
                }
              }
            }
          }
        }
      }
      if(progressTrade!.data!.isNotEmpty && _dropdownValues.isEmpty){
        List<ProgressTradeData>? locationList1=progressTrade?.data;
        _dropdownValues.add("Please Select");
        _dropdownValues.add("Skilled");
        _dropdownValues.add("UnSkilled");
        _dropdownValuesID.add(43929329191);
        _dropdownValuesID.add(0);
        _dropdownValuesID.add(1);
        for(var data in locationList1!){
          _dropdownValues.add(data.trade!);
          _dropdownValuesID.add(data.id!);
        }
      }
    }
      }
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Edit Progress Entry",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:const EdgeInsets.only(right: 20,top: 10),
                  child:
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor:update==false? Colors.brown:Colors.green),
                onPressed: () async {
                  setState(() {
                    if(update==false){
                    remarkController.text="";
                    update=true;
                    }
                    else{
                      update=false;
                    }
                });
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                 try {
                    var getContractorForPwRApiUrl=Uri.parse('${Config.getProgressPwrClientApi}${clientID.text}/${projectID.text}/${activityID.text}');
                    var res=await http.get(
                     getContractorForPwRApiUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                            );
                      if (kDebugMode) {
                        print(getContractorForPwRApiUrl);
                      }
                            if(res.statusCode==200){
                              try{
                            pwrContractorName.text=(jsonDecode(res.body)['data'][0]['contractor_name']);
                            pwrContractorId.text=(jsonDecode(res.body)['data'][0]['Pid']).toString();
                              // ignore: empty_catches
                              }catch(e){}
                            }
                            setState(() {});
                          } 
                          catch (e) {
                          if (kDebugMode)
                          {
                            print(e);
                            print("Error is here f!");
                          }
                        }
                      },
                 child: Text("Update",style: textStyleButton,),),
                )
            ]),
          CustomContainer(
            child: 
            InkWell(
              onTap:() async {
                if(update==true){
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                          primaryColor: AppColors.primary,
                          buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary,
                          ), colorScheme: const ColorScheme.light(primary:AppColors.primary,).copyWith(secondary: const Color(0xFF8CE7F1)),
                        ),
                     child: child!,
                    );
                    }, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    dateInput.text =formattedDate;
                  });
                } else {}
                }
              },
              child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Text(dateInput.text,style: textStyleBodyText1.copyWith(fontSize: 18),),
             const Icon(Icons.calendar_month),
            ])
            )
        ),
        //done
        Column(
          children: [
              Center(
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  ),
              ),
           SizedBox(
            height: 65,
            child: 
          ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 15,bottom: 0,left: 0,right: 0),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled2.add(false);
            return GestureDetector(
                onTap: (){
                  if(update==true){
                  isCardEnabled2.replaceRange(0, isCardEnabled2.length, [for(int i = 0; i < isCardEnabled2.length; i++)false]);
                  isCardEnabled2[index]=true;
                  priorityController.text=(toggleList[index]);
                  setState(() {});
                  }
                  else{}
                },
                child: SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width/2.2,
                  child: Container(
                   decoration: BoxDecoration(
                    borderRadius:const BorderRadius.all(Radius.circular(5)),
                     color:toggleList[index].toString()==priorityController.text? AppColors.primary:AppColors.white,
                     border: Border.all(width: 1.2,color: AppColors.primary,),
                    ),
                    child: Center(
                      child: Text(toggleList[index],textAlign: TextAlign.center,
                        style: TextStyle(
                          color: toggleList[index].toString()==priorityController.text?Colors.black:AppColors.primary,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
            );
          }),
          ),
          ]),
          CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(locationController.text.isEmpty?"D Series (D01- D06)":locationController.text,style: textStyleBodyText1.copyWith(fontSize: 18),),),
              const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
            CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subLocationController.text.isEmpty?"Sub Level/D-01":'${subLocationController.text} ',style: textStyleBodyText1.copyWith(fontSize: 18))),
             const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Center(child: Text(activityHeadController.text.isEmpty?"Sub Structure/Excavation":'${activityHeadController.text} / ${activityController.text}',style: textStyleBodyText1.copyWith(fontSize: 18),),),
            const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          const SizedBox(height: 10,),
          CustomContainer2(
            child:
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Quantity: ${_sliderValue.toInt()} %",style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
            SizedBox(height: 50,
            width: 350,
            child:
            FittedBox(
              fit: BoxFit.cover,
              child: 
            Slider(
              divisions: 100,
              activeColor: AppColors.primary,
              focusNode: null,
              inactiveColor: AppColors.lightGrey,
                value:_sliderValue,
                onChanged: (newValue) {
                  setState(() {
                   if(update==true){
                    double calculatepercentage(double amount, double taxPercent) {
                      if (amount == 0 || taxPercent == 0) {
                        return 0;
                      } else {
                        return (taxPercent * amount) / 100;
                      }
                    }
                    totalQuantity1=double.parse(quantityController.text);
                    taxPercent1=double.parse(comulativeQuantity.text);
                    achievedQuantity1 =calculatepercentage(totalQuantity1!, _sliderValue.toDouble());
                    cumulativeQuantity1 = (totalQuantity1! - achievedQuantity1!);
                    _sliderValue = newValue;
                    achivedQuantity.text=(achievedQuantity1!.toStringAsFixed(2));
                    comulativeQuantity.text= (cumulativeQuantity1!.toStringAsFixed(2));
                   }
                   else{}
                  });
                },
                min: 0,
                max: 100,
              ),
            ),
            ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text("0 ${uomName.text}",style: textStyleBodyText1),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("${quantityController.text} ${uomName.text}",style: textStyleBodyText1),
            ],),
            const SizedBox(height: 30,),
            Container(
              margin:const EdgeInsets.only(left: 20,right:20),
              child: 
            Row(children: [
               Text("TOTAL QUANTITY: ${quantityController.text}",style: textStyleBodyText1),
            ],)
            ),
            const SizedBox(height: 30,),
            Container(
              margin:const EdgeInsets.only(left: 20,right:20),
              child: 
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
              Card(
                elevation: 4,
                color: AppColors.primary,
                child: 
                SizedBox(
                  width: 120,
                  child: 
                  Padding(
                  padding:const EdgeInsets.all(8.0),
                  child:Center(child: Text(achivedQuantity.text,style: textStyleBodyText1,),),
                ),
                ),
              ),
              const SizedBox(height: 10,),
              Center(child: Text("Achived",style: textStyleBodyText4,),),
              ]),
              Column(children: [
                Card(
                elevation: 4,
                color: AppColors.primary,
                child: 
                SizedBox(
                  width: 120,
                  child: 
                  Padding(
                  padding:const EdgeInsets.all(8.0),
                  child:Center(child: Text(comulativeQuantity.text,style: textStyleBodyText1,),),
                ),
                ),
              ),
              const SizedBox(height: 10,),
              Center(child: Text("Cumulative",style: textStyleBodyText4,),),
              ])
            ],
          )
            ),
            
          ],) 
            ),
          const SizedBox(height: 20,),
            if(update==true)...{
          ListView.builder(
          physics:const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: labourList.length,
          itemBuilder: (context, outerIndex) {
            finalList.add(outerIndex);
            finalList.insert(outerIndex,groupedList[contractorController.text]);
            // finalList.add(outerIndex);
          return 
          Column(children: [
          CustomContainer2(
            child:
          Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("LABOUR",style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
            if(priorityController.text=='Labour Supply' || priorityController.text=="Misc.")...{
          Container(
           margin: const EdgeInsets.only(top: 20,),
           padding: const EdgeInsets.only(bottom: 10,),
           child: 
           DropdownButtonFormField(
             value:contractorList.isNotEmpty?contractorList[0]:"",
             icon: const Padding( 
             padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_outlined,size: 30)
             ), 
            iconEnabledColor: Colors.grey,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17
            ), 
          dropdownColor: AppColors.white,
          decoration: const InputDecoration(enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
              isExpanded: true,
              items:contractorList.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items,style: TextStyle(color: !mainDropdownValue.contains(items)?Colors.black:Colors.grey),),
                );
              }).toList(),
              onChanged:(String? newValue) async {
                !mainDropdownValue.contains(newValue)?
                setState(() {
                  if(newValue!="Select Contractor Name"){
                  _items2.add({'$outerIndex':['Item ${_items2.length + 1}']});
                  contractorLabourDetails.add([]);
                  _dropdownValues2.clear();
                  groupedList.clear();
                  mainDropdownValue.add(newValue);
                  contractorController.text=newValue!;
                  dropdownvalue = newValue;
                     if(signInController.getLabourAttendance!.data!.isNotEmpty && _dropdownValues2.isEmpty){
                      List<MainData>? list1=signInController.getLabourAttendance?.mainData;
                      _dropdownValues2.add("Please Select");
                      for(var data in list1!){
                        for(var data2 in data.labourDetails!){
                          if (groupedList.containsKey(data2.contractorName)) {
                                groupedList[data2.contractorName]!.add(data2.name!);
                                } 
                          else {
                                groupedList[data2.contractorName!] = [data2.name!];
                                }
                          if(data2.contractorId==contractorID[contractorList.indexOf(newValue)]){
                        _dropdownValues2.add(data2.name!);
                          }
                        }
                      }
                      contractorIDIndex.text=contractorList.indexOf(newValue).toString();
                      groupedMapToList=groupedList.values.toList();
                      for (var sublist in groupedMapToList) {
                              sublist.insert(0, "Please Select");
                       }
                      // ignore: unused_local_variable
                      for (var sublist in groupedMapToList) {
                              _selectedDropdownValues2.add(["Please Select"]);
                              _controllers2.add([TextEditingController()]);
                       }
                      finalList.insert(outerIndex,groupedList[contractorController.text]!);
                    }
                    subItems.insert(outerIndex,groupedList[contractorController.text]);
                   }else{}}):null;
                   if(newValue!="Select Contractor Name"){
                   for (var i = 0; i < subItems.length; i++) {
                        for (var j = 0; j < subItems[i].length; j++) {
                          if (subItems[i][j] != 'Please Select'){
                            _selectedDropdownValues2[i].add('Please Select');
                            _controllers2[i].add(TextEditingController());
                          }
                        }
                      }
                   }
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Over-Time',style: textStyleBodyText1.copyWith(color: Colors.grey),)],),
          if(subItems[outerIndex].isNotEmpty)
          ListView.builder(
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _items2[outerIndex]['$outerIndex'].length,
              itemBuilder: (context, index){
                // print(contractorIDIndex.text);
                // print(outerIndex);
                // print(contractorLabourLinkingId);
                // print(contractorLabourLinkingId[contractorID[outerIndex+1]]!);
                // print(contractorLabourLinkingId[contractorID[int.parse(contractorIDIndex.text)]]!);
              return 
                Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SizedBox(
                    height: 65,
                    width: 250,
                    child:
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    ),
                    width: 200,
                    child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    value: _selectedDropdownValues2[outerIndex][index],
                    items:subItems[outerIndex]
                    .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                    value: value,
                    child: Padding(padding:const EdgeInsets.only(left: 10),child: Text(value,style:!_selectedDropdownValues2[outerIndex].contains(value)?textStyleBodyText1:textStyleBodyText1.copyWith(color: Colors.grey),)),
                    ))
                    .toList(),
                    onChanged: (newValue) {
                       if(newValue!="Please Select"){
                      // print("-------------------------------------------");
                      // print("contractorID");
                      // print(contractorID[outerIndex+1]);
                      // print("-------------------------------------------");
                      // print("Selected value");
                      // print(newValue);
                      // print("-----------------------------------");
                      // print("contractor labour linking id");
                      contractorLabourLinkingIDText.text= (contractorLabourLinkingId[contractorID[int.parse(contractorIDIndex.text)]]![subItems[outerIndex].indexOf(newValue)-1]).toString();
                      // print(contractorLabourLinkingIDText.text);
                    setState(() {
                    // ignore: unused_local_variable
                    int index1;
                    !_selectedDropdownValues2[outerIndex].contains(newValue)? _selectedDropdownValues2[outerIndex][index]=(newValue.toString()):null;

                    if(_selectedDropdownValues2[outerIndex].contains(newValue)){
                    for (var i = 0; i < contractorLabourDetails[outerIndex].length; i++) {
                      if (contractorLabourDetails[outerIndex][i].containsKey(contractorLabourLinkingId[contractorID[int.parse(contractorIDIndex.text)]]![subItems[outerIndex].indexOf(newValue)-1])) {
                        keyExists = true;
                        index1 = i;
                        break;
                      }
                    }
                    if(keyExists){
                     contractorLabourDetails[outerIndex][index]={contractorLabourLinkingId[contractorID[outerIndex+1]]![subItems[outerIndex].indexOf(newValue)-1]:[contractorID[outerIndex+1],""]};
                    }
                    if(!keyExists){
                      try {
                    contractorLabourDetails[outerIndex][index]={contractorLabourLinkingId[contractorID[int.parse(contractorIDIndex.text)]]![subItems[outerIndex].indexOf(newValue)-1]:[contractorID[outerIndex+1],""]};
                      }catch(e){
                         contractorLabourDetails[outerIndex].add({contractorLabourLinkingId[contractorID[int.parse(contractorIDIndex.text)]]![subItems[outerIndex].indexOf(newValue)-1]:[contractorID[outerIndex+1],""]});
                      }
                    }
                    }
                    });}
                    },
                    )
                      )
                    ),
                      SizedBox(           
                      width: 60,
                      height: 55,
                      child:
                      CustomTextFieldForNumber(
                          onSubmitted:(value){
                          if (kDebugMode) {
                          // print("-------------------------------------------");
                          // print("contractorID");
                          // print(contractorID[outerIndex+1]);
                          // print("-------------------------------------------");
                          // print("entered value");
                          // print(value);
                          // print("+++++++++++++++++++++++++++++++++++++");
                          // print(contractorLabourLinkingId[contractorID[outerIndex+1]]![index]);
                          // print("============================================");
                          // print(index);
                          // print("}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
                          // print(contractorLabourDetails);
                          // print(contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)][0]);
                          // print(contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)]);
                          // print(contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)][1]);
                          // print(contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)][1]);
                          }
                          contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)][1]=value;
                          // print("-----------------------------------");
                          // print(contractorLabourDetails);
                          },
                          controller: _controllers2[outerIndex][index],
                        ),
                      )
                    ,],),
                    Row(children: [
                    if(index==_items2[outerIndex]['$outerIndex'].length-1)
                    IconButton(
                    icon:const Icon(Icons.add_circle),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () {
                    setState(() {
                         if(_items2[outerIndex].containsKey('$outerIndex')){
                            _items2[outerIndex]['$outerIndex']!.add('Item ${_items2[outerIndex].length + 1}');
                          }else{
                            _items2[outerIndex] = ['Item ${_items2[outerIndex].length + 1}'];
                          }
                       _addMore2(outerIndex,index);
                      }
                    );
                    }),
                    if(_selectedDropdownValues2[outerIndex].isNotEmpty)
                    IconButton(
                    icon:const Icon(Icons.delete),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () {
                       if(_selectedDropdownValues2[outerIndex][index]!="Please Select") {
                         if(index!=0){
                      setState((){
                      _items2[outerIndex]['$outerIndex'].remove(_items2[outerIndex]['$outerIndex'][index]);
                      contractorLabourDetails[outerIndex].removeAt(index);
                      _deleteMore2(outerIndex,index); 
                        if (kDebugMode) {}
                       });}else{
                          EasyLoading.showToast("First contractor cannot be deleted",toastPosition: EasyLoadingToastPosition.bottom);
                       }
                       } else {
                          EasyLoading.showToast("Please select before deleting",toastPosition: EasyLoadingToastPosition.bottom);
                          if (kDebugMode) {
                            print(_items2[outerIndex]['$outerIndex']);
                          }
                          if (kDebugMode) {
                            print("i am here");
                          }
                          if (kDebugMode) {
                            print(index);
                          }
                      }
                    }
                    ),
                    ]),
                    ]);
                    },
                    ),
          },
          if(priorityController.text!='Labour Supply' && priorityController.text!="Misc.")...{
          CustomContainer(
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(pwrContractorName.text.isNotEmpty?pwrContractorName.text:"No Contractor Selected",style: textStyleBodyText1,),),
             const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Over-Time",style: textStyleBodyText1.copyWith(fontSize: 16),)
            ],),
            const SizedBox(height: 20,),
            SizedBox(height:100,
            width: MediaQuery.of(context).size.width,
            child:
            ListView.builder(
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    SizedBox(
                      height: 65,
                      width: 250,
                      child:
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    ),
                    width: 200,
                    child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    value: _selectedDropdownValues[index],
                    items: _dropdownValues
                    .map((value) => DropdownMenuItem(
                    value: value,
                    child: Padding(padding:const EdgeInsets.only(left: 10),child: Text(value,style: textStyleBodyText1,)),
                    ))
                    .toList(),
                    onChanged: (newValue) {
                    setState(() {
                      if (kDebugMode) {
                        print(newValue);
                      }
                    _selectedDropdownValues[index] = newValue.toString();
                    _selectedDropdownValuesID[index]=_dropdownValuesID[_dropdownValues.indexOf(_selectedDropdownValues[index])];
                    });
                    },
                    )
                      )
                    ),
                      SizedBox(           
                      width: 60,
                      height: 55,
                      child:
                      CustomTextFieldForNumber(
                          controller: _controllers[index],
                          onSubmitted: (value){
                            enteredValues[index]=value.toString();
                          },
                        )
                      )
                    ,]);
                    },
                    ),
                    ),
                    Row(children: [
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    child: const Text("Add More"),
                    onPressed: () {_addMore();}
                    ),
                    ])
          },
             if((priorityController.text=="Labour Supply"||priorityController.text=="Misc.") && contractorController.text.isNotEmpty)...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              if(labourList.length+2<=contractorList.length)...{
            IconButton(onPressed: (){
              setState(() {
                _items2.add({'${outerIndex+1}':['Item ${_items2.length+1}']});
                contractorLabourDetails.add([]);
                labourList.add("1");
              });
            }, icon:const Icon(Icons.add_circle)),
              },
            IconButton(onPressed: (){
              setState(() {
                if(outerIndex==1){
                labourList.removeAt(outerIndex);
                }
              });
            }, icon:const Icon(Icons.delete)),
           ])
          }
          ],
          )
          ),
          ],
          );
          }),
            },
          const SizedBox(height: 10,),
            CustomContainer2(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Remark",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               CustomTextField3(enabled:update==true? true:false,controller: remarkController,hintText: "Enter here",)
          ])
            ),
            const SizedBox(height: 10,),
          CustomContainer2(child:
          Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT TO",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
             Container(
           margin: const EdgeInsets.only(top: 20),
           padding: const EdgeInsets.only(bottom: 20,),
            child: 
           DropdownButtonFormField(
             value: debitToController.text.isNotEmpty?debitToController.text:null,
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
              isExpanded: true,
              items:update==true? itemsDebit.keys.map<DropdownMenuItem<String>>((String key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Text(itemsDebit[key]),
              );
            }).toList():null,
              onChanged: (String? newValue) async {
                setState(() {
                  debitToController.text=newValue!;
                  dropdownvalueDebitTo = newValue;
                });
              },
            ),
          ),
          ])
            ),
            const SizedBox(height: 20,),
          if(_selectedImage != null)
            Container(
              margin:const EdgeInsets.only(top: 20),
              child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.file(_selectedImage!,height: 200,width: 100,),
            ],),),
            Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            margin:const EdgeInsets.only(left: 20,right: 20,bottom: 20, top: 20),
              child: 
             ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey,
              elevation: 0,
              splashFactory: NoSplash.splashFactory),
              onPressed:(){
                    showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return SimpleDialog(
                      alignment: Alignment.center,
                       children: <Widget>[
                        Text("      Choose",style: textStyleHeadline3.copyWith(fontWeight: FontWeight.normal),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                         SimpleDialogOption(
                            child: 
                            Column(
                                children: <Widget>[     
                                  const SizedBox(width: 10),
                                  const Icon(Icons.image,size: 70,color: Colors.grey,),
                                  Text("Gallery",style: textStyleBodyText1.copyWith(color: Colors.grey),),
                                ],
                              ),
                             onPressed: () {
                               _pickImage(ImageSource.gallery);
                               Navigator.pop(context);
                             },
                           ),
                          SimpleDialogOption(
                            child: Column(
                              children: <Widget>[
                                const SizedBox(width: 10),
                                 const Icon(Icons.camera_alt,size: 70,color: Colors.grey,),
                                Text("Camera",style:textStyleBodyText1.copyWith(color: Colors.grey),),
                              ],
                            ),
                             onPressed: () {
                               _pickImage(ImageSource.camera);
                               Navigator.pop(context);
                             },
                           ),
                        ]),
                           SimpleDialogOption(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const SizedBox(width: 10),
                                Text("Cancel",style:textStyleBodyText1.copyWith(color: AppColors.primary),),
                              ],
                            ),
                             onPressed: () {
                               Navigator.pop(context);
                             },
                           ),
                         ],
                       );
                     },
                   );
              },
              child: Text("Add Image",style: textStyleBodyText1.copyWith(color: AppColors.black),),
             )
             ),
            Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            margin:const EdgeInsets.only(left: 20,right: 20,),
              child: 
             ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey,
              elevation: 0,
              splashFactory: NoSplash.splashFactory),
              onPressed:(){},
              child: Text("Add 360 Images",style: textStyleBodyText1.copyWith(color: AppColors.black),),
             )
             ),
             if(update==true)
            Container(
            height: 35,
            width: MediaQuery.of(context).size.width,
            margin:const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
              child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:Size(MediaQuery.of(context).size.width/2.5,40),
                backgroundColor: const Color.fromARGB(255, 0, 203, 173),
              elevation: 0,
              splashFactory: NoSplash.splashFactory),
              onPressed:(){},
              child: Text("Save As Draft",style: textStyleBodyText4.copyWith(color: AppColors.black)),
             ),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:Size(MediaQuery.of(context).size.width/2.5,40),
                backgroundColor:  AppColors.green,
              elevation: 0,
              splashFactory: NoSplash.splashFactory),
              onPressed:()async {
             if(activityID.text.isEmpty){
                      EasyLoading.showToast("Linking Activity ID is required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    if(remarkController.text.isEmpty){
                      EasyLoading.showToast("Remark is required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else if(debitToController.text.isEmpty){
                      EasyLoading.showToast("Debit To is required",toastPosition: EasyLoadingToastPosition.bottom);  
                    }
                    else if(contractorLabourDetails.isEmpty){
                      EasyLoading.showToast("Atleast one contractor is required",toastPosition: EasyLoadingToastPosition.bottom);  
                    }
                    else{
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    var projectID=sharedPreferences.getString('projectIdd');
                    var clientID=sharedPreferences.getString('client_id');
                    randomNumber=random.nextInt(90) + 10;
                    Map<String, dynamic> outerProgress = {};
                    FormData formData=FormData(); 
                    if(priorityController.text=="Labour Supply"|| priorityController.text=="Misc."){
                    List progressDetails = [];
                    for (var subList in contractorLabourDetails){
                      for (var map in subList) {
                        // ignore: non_constant_identifier_names
                        var contractor_id = map.values.first[0];
                        var contractorLabourDetails1 = {
                          "contractor_labour_linking_id": map.keys.first.toString(),
                          "time": map.values.first[1].toString(),
                        };
                        bool contractorExist = false;
                        for (var progress in progressDetails) {
                          if (progress['contractor_id'] == contractor_id) {
                            contractorExist = true;
                            progress['contractorLabourDetails'].add(contractorLabourDetails1);
                            break;
                          }
                        }
                        if (!contractorExist) {
                          progressDetails.add({
                            "contractor_id": contractor_id.toString(),
                            "contractorLabourDetails": [contractorLabourDetails1]
                          });
                        }
                      }
                    }
                    List<Map<String, dynamic>> newList = [];
                    for (Map<String, dynamic> map in progressDetails) {
                      bool contractorExists = false;
                      for (Map<String, dynamic> newMap in newList) {
                        if (newMap["contractor_id"] == map["contractor_id"]) {
                          newMap["contractorLabourDetails"].addAll(map["contractorLabourDetails"]);
                          contractorExists = true;
                          break;
                        }
                      }
                      if (!contractorExists) {
                        newList.add({ "contractor_id": map["contractor_id"], "contractorLabourDetails": map["contractorLabourDetails"] });
                      }
                    }
                    try {
                    outerProgress["progress_image_$randomNumber"]= _selectedImage!.path;
                    } catch (e) {
                      formData.fields.add(MapEntry('progress_image_$randomNumber', ''));
                    }
                    outerProgress["progress_data"]= (
                        {
                          "daily_progress_random_id":randomNumber,
                          "client_id": int.parse(clientID!),
                          "project_id": int.parse(projectID!),
                          "prog_type": 0,
                          "draft_status": 0,
                          "link_activity_id":activityID.text.isNotEmpty?int.parse(activityID.text):"",
                          "achived_quantity": achivedQuantity.text.isNotEmpty? achivedController.text:"",
                          "total_quantity":quantityController.text.isNotEmpty?int.parse(quantityController.text):"",
                          "remarks": remarkController.text,
                          "contractor_id": "7",
                          "progress_percentage":_sliderValue!=0.0?_sliderValue.toInt().toString():"",
                          "debet_contactor":int.parse(debitToController.text),
                          "progress_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          "cumulative_quantity": comulativeQuantity.text,
                          "type":priorityController.text=="Misc."?1:0,
                          "save_type": "save",
                          "created_by":int.parse(clientID),
                          "PWRLabourDetails": [
                              {
                                  "labour_count": 1,
                                  "pwr_type": 0
                              }
                          ],
                          "contractorLabourDetails": [],
                          "progressDetails": newList,
                        }
                      );
                    try {
                      var resOriginal = await databaseProvider.getOuterProgressFormData();
                      var resEdited=resOriginal;
                      await databaseProvider.deleteOuterProgressFormData();
                      for(int i=0;i<resEdited.length;i++){
                          for(int j=0;j<resEdited[i]['progress_data'].length;j++){
                          if(resEdited[i]['progress_data'][j]['link_activity_id'].toString() == outerProgress['progress_data']['link_activity_id'].toString()) {
                            resEdited[i]['progress_data'].add(outerProgress['progress_data']);
                            break;
                          }
                          }
                        }
                      await databaseProvider.insertOuterProgressFormData(resEdited);
                         // ignore: use_build_context_synchronously
                         Navigator.pop(context);
                        // await databaseProvider.insertOuterProgressFormData(outerProgress);
                        EasyLoading.showToast(priorityController.text=="Misc."?"Misc. Progress Saved":"Labour Supply Progress saved",toastPosition: EasyLoadingToastPosition.bottom);
                    }catch(e){
                      EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    // ignore: use_build_context_synchronously
                    // Navigator.pop(context);
                    }
                    if(priorityController.text=="PRW"){
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    var projectID=sharedPreferences.getString('projectIdd');
                    var clientID=sharedPreferences.getString('client_id');
                      List pWRLabourDetailsList = [];
                        for(int i=0; i<_selectedDropdownValuesID.length; i++){
                          pWRLabourDetailsList.add({
                            "labour_count": enteredValues[i],
                            "pwr_type": _selectedDropdownValuesID[i]
                          });
                        }
                    try {
                    outerProgress["progress_image"]= _selectedImage!.path;
                    } catch (e) {
                      formData.fields.add(const MapEntry('progress_image', ''));
                    }
                    outerProgress['progress_data'] =(
                        {
                          "client_id": int.parse(clientID!),
                          "project_id": int.parse(projectID!),
                          "link_activity_id":int.parse(activityID.text),
                          "achived_quantity": achivedQuantity.text,
                          "total_quantity":quantityController.text.isNotEmpty?int.parse(quantityController.text):"",
                          "remarks": remarkController.text,
                          "contractor_id": int.parse(pwrContractorId.text),
                          "progress_percentage": _sliderValue.toInt().toString(),
                          "debet_contactor":"0",
                          "progress_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          "cumulative_quantity": comulativeController.text,
                          "type": 2,
                          "save_type": "save",
                          "created_by":int.parse(clientID),
                          "PWRLabourDetails": pWRLabourDetailsList,
                          "contractorLabourDetails": [],
                          "progressDetails": [],
                        }
                      );
                    try {
                     var resOriginal = await databaseProvider.getOuterProgressFormData();
                      var resEdited=resOriginal;
                      await databaseProvider.deleteOuterProgressFormData();
                      for(int i=0;i<resEdited.length;i++){
                          for(int j=0;j<resEdited[i]['progress_data'].length;j++){
                          if(resEdited[i]['progress_data'][j]['link_activity_id'].toString() == outerProgress['progress_data']['link_activity_id'].toString()) {
                            resEdited[i]['progress_data'].add(outerProgress['progress_data']);
                            break;
                          }
                          }
                        }
                      await databaseProvider.insertOuterProgressFormData(resEdited);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      EasyLoading.showToast("PRW Progress saved", toastPosition: EasyLoadingToastPosition.bottom);
                    }catch(e){
                      EasyLoading.showToast("Something went wrong", toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    // ignore: use_build_context_synchronously
                    // Navigator.pop(context);
                  }else{
                    // ignore: use_build_context_synchronously
                    // Navigator.pop(context);
                    EasyLoading.showToast("Progress Saved", toastPosition: EasyLoadingToastPosition.bottom);
                  }}
              },
              child: Text("Save",style: textStyleBodyText4.copyWith(color: AppColors.black),),
             )
             ]
             )
             )
          ]
        ),
      )
    );
  }
}
