import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:colab/network/client_project.dart';
import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
import '../models/labour_attendance.dart';
import '../models/progress_contractor.dart';
import '../models/progress_location_data.dart';
import '../models/progress_trade_data.dart';
import '../network/progress_network.dart';

// ignore: must_be_immutable
class NewProgressEntry2 extends StatefulWidget {
  NewProgressEntry2({Key? key, this.from, this.snagModel, this.locName, this.subLocName, this.subSubLocName }) : super(key: key);

 // ignore: prefer_typing_uninitialized_variables
 final from;
 // ignore: prefer_typing_uninitialized_variables
 final locName;
 // ignore: prefer_typing_uninitialized_variables
 final subLocName;
 // ignore: prefer_typing_uninitialized_variables
 final subSubLocName;
 dynamic snagModel;
  @override
  State<NewProgressEntry2> createState() => _SnagState();
}

class _SnagState extends State<NewProgressEntry2> {
  late String subV="";
  late String subSubV="";
  final getCompletedSiteProgressDataController=Get.find<GetCompletedSiteProgress>();
  final getInQualitySiteProgressDataController=Get.find<GetInEqualitySiteProgress>();
  final getOnGoingSiteProgressDataController=Get.find<GetOnGoingSiteProgress>();
  final categoryController=TextEditingController();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final locationId=TextEditingController();
  final subSubLocationId = TextEditingController();
  final subLocationId = TextEditingController();
  final remarkController = TextEditingController();
  final deSnagRemarkController=TextEditingController();
  final closingRemarkController=TextEditingController();
  final markController=TextEditingController();
  final debitToController=TextEditingController();
  final getProgressCount=Get.find<GetProgressCount>();
  final debitAmountController=TextEditingController();
  final snagAssignedByController=TextEditingController();
  final snagAssignedToController=TextEditingController();
  final priorityController=TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController contractorInput = TextEditingController(text: "No Contractor");
  final location = ["Select Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue = 'Select Contractor Name';  
  final location2 = ["Select Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue2 = 'Select Sub Location';  
  final location3 = ["Select Sub Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue3 = 'Select Sub Sub Location';  
  List debitTo = [];
  List<int> debitToID=[];
  String dropdownvalueDebitTo = 'Select Debit to';  
  final assignedTo=["Select Name","Name 1"];
  String dropdownvalueAssignedTo="Select Name";
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);
   List<String> imageData=[];
   List<bool> isCardEnabled = [];
   List<bool> isCardEnabled2 = [];
   List<String> deSnagImages=[];
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
  final List subItems=[];
  final List<String> _dropdownValues2 = [];
  final List<List<String>> _selectedDropdownValues2 = [];
  final List<TextEditingController> _controllers = [TextEditingController(text: "1",)];
  final List<List<TextEditingController>> _controllers2 = [];
  List<List> contractorLabourDetails=[];
  bool keyExists = false;
  final contractorLabourLinkingIDText=TextEditingController();
  List<String> locationList=[];
  Map<String, dynamic> itemsDebit={};
  List<int> locationID=[];
  List<int> contractorID=[];
  Map<int, List<int>> contractorLabourLinkingId={};
   List<String> priority=[
    "Labour Supply",
    "PRW",
    "Misc.",
   ];
  List viewpoints=[];
  List deSnagImage=[];
  List viewpointID=[];
  TextEditingController totalQuantity=TextEditingController();
  final signInController=Get.find<SignInController>();
  final activityController = TextEditingController();
  final linkingActivityId=TextEditingController();
  final activityHeadController = TextEditingController();
  final otherLocationController = TextEditingController();
  final quantityController=TextEditingController();
  final projectID=TextEditingController();
  TextEditingController achivedQuantity=TextEditingController();
  TextEditingController contractorName=TextEditingController();
  TextEditingController comulativeQuantity=TextEditingController(); 
  final clientID = TextEditingController();
  final  activityID=TextEditingController();
  final assignedToController=TextEditingController();
  TextEditingController achivedController=TextEditingController();
  TextEditingController comulativeController=TextEditingController();
  TextEditingController contractorIDIndex = TextEditingController();
  TextEditingController progressID = TextEditingController();
  final uomName=TextEditingController();
  final type=TextEditingController();
  TextEditingController contractorController=TextEditingController();
  TextEditingController contractorNameController=TextEditingController();

  File? image;
  CroppedFile? croppedFile;
  var groupedViewpoints = {};

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
    // _selectedDropdownValues2[outerIndex].add(groupedMapToList[innerIndex][0]);
    // _controllers2.add(TextEditingController(text: "1"));
    });
    }
     void _deleteMore2(outerIndex,innerIndex) {
    setState(() {
    _selectedDropdownValues2[outerIndex].removeAt(innerIndex);
    _controllers2[outerIndex].removeAt(innerIndex);
    });
    }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: AppColors.white,
          toolbarWidgetColor:AppColors.primary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Edit Image',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
  var imageTemp = File(croppedFile!.path);
  setState(() => this.image = imageTemp);
      } catch(e) {
        if (kDebugMode) {
          print('Failed to pick image: $e');
        }
      }
  }
  File?  _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage =File(image!.path);
    });
  }
    late List<bool> isSelected;
    final creationController = TextEditingController();
     List viewpoints2=[];
     var array2=[];
     var _sliderValue=0.0;
    List<String> contractorList=[];
    @override
  void initState() {
    super.initState(); 
    priorityController.text="PRW";
    locationController.text=widget.snagModel?.locationName??"";
    subLocationController.text=widget.snagModel?.subLocationName??"";
    subSubLocationController.text=widget.snagModel?.subSubLocationName ?? "";
    activityController.text=widget.snagModel?.activity??"";
    locationId.text=widget.snagModel?.locationID.toString()??"";
    subLocationId.text=widget.snagModel?.subLocationID.toString()??"";
    subSubLocationId.text=widget.snagModel?.subSubLocationID.toString()??"";
    activityHeadController.text=widget.snagModel?.activityHead.toString()??"";
    linkingActivityId.text=widget.snagModel?.linkingActivityId.toString()??"0";
    activityID.text=widget.snagModel?.activityId.toString()??"0";
    contractorNameController.text=widget.snagModel?.contractorName??"";
    getContractor();
    try {
      totalQuantity.text=widget.snagModel?.totalQuantity.toString()??"";
    } catch (e) {
      totalQuantity.text=widget.snagModel?.quantity.toString()??"";
    }
    try {
    uomName.text=widget.snagModel?.uomName??"";
    } catch (e) {
      uomName.text="";
    }
    activityID.text=widget.snagModel?.linkingActivityId.toString()??"";
    achivedQuantity.text="";
    comulativeQuantity.text="";
    _sliderValue=double.parse("0.0");
    remarkController.text=widget.snagModel?.description??"";
    clientID.text=widget.snagModel?.clientId.toString()??"";
    projectID.text=widget.snagModel?.projectId.toString()??"";
    progressID.text=widget.snagModel?.progressId.toString()??"";
    dateInput.text= DateFormat('dd/MM/yyyy').format(DateTime.now());
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
    final f = DateFormat('yyyy-MM-dd hh:mm a');
   getFormatedDate(date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
    }
 
   void clearCache()async{
    EasyLoading.show();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
       // ignore: use_build_context_synchronously
       context.pushNamed('LOGINPAGE');
      }
  
  getContractor() async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token=sharedPreferences.getString('token');
        try {
          var getContractorForPwRApiUrl=Uri.parse('${Config.getProgressPwrClientApi}${activityID.text}/${clientID.text}/${projectID.text}');
          var res=await http.get(
            getContractorForPwRApiUrl,
            headers: {
                    "Accept": "application/json",
                    "Authorization": "Bearer $token",
                  },
                );
            if (kDebugMode) {
              print(getContractorForPwRApiUrl);
              print(res.body);
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
  }

  bool iconPressed=false;
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
       if(signInController.getProgressLocationList?.data!=null){
      if(signInController.getProgressLocationList!.data!.isNotEmpty && locationList.isEmpty){
        List<ProgressLocationListData>? locationList1=signInController.getProgressLocationList?.data;
        locationList.add("Select Location");
        locationID.add(0);
        for(var data in locationList1!){
          locationList.add(data.locationName!);
          locationID.add(data.locationId!);
        }
      }
      if(signInController.getProgressContractorList!=null){
        if(signInController.getProgressContractorList!.data!=null){
      if(signInController.getProgressContractorList!.data!.isNotEmpty && contractorList.isEmpty){
        if(signInController.getProgressContractorList!.data!.isNotEmpty && debitTo.isEmpty){
        List<ProgressDataContractorListData>? debitToList1=signInController.getProgressContractorList?.data;
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
        List<MainData>? contractorList1=signInController.getLabourAttendance?.mainData;
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
      }
      }
      if(signInController.getProgressTradeList!.data!.isNotEmpty && _dropdownValues.isEmpty){
        List<ProgressTradeData>? locationList1=signInController.getProgressTradeList?.data;
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
    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("CREATE NEW PROGRESS ENTRY",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
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
                    builder: (BuildContext context, Widget? child) {
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
                    firstDate:DateTime.now().subtract(const Duration(days: 1)),
                    lastDate: DateTime.now());
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    dateInput.text =formattedDate;
                  });
                } else {}
              },
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 20),
            ),
               ),
                const SizedBox(height: 10,),
            Column(
              children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
               ),),
        SizedBox(
          height: 75,
          child: 
          ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 15,bottom: 15,left: 0,right: 0),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled2.add(false);
            return GestureDetector(
                onTap: (){
                  isCardEnabled2.replaceRange(0, isCardEnabled2.length, [for(int i = 0; i < isCardEnabled2.length; i++)false]);
                  isCardEnabled2[index]=true;
                  priorityController.text=(priority[index]);
                  setState(() {});
                },
                child: SizedBox(
                  height: 10,
                  width: 120,
                  child: Container(
                   decoration: BoxDecoration(
                    borderRadius:const BorderRadius.all(Radius.circular(5)),
                     color: priority[index].toString()==priorityController.text? AppColors.primary:AppColors.white,
                     border: Border.all(width: 1.2,color: AppColors.primary,),
                    ),
                    child: Center(
                      child: Text(priority[index],textAlign: TextAlign.center,
                        style: TextStyle(
                          color: priority[index].toString()==priorityController.text?Colors.black:AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                )
            );
          }),
          ),
          ]),
          if(priorityController.text!="Misc.")...{
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(locationController.text.isEmpty?"Location":locationController.text,style: textStyleBodyText1,),),
            //  const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text('${subLocationController.text.isEmpty?"Sub Location":subLocationController.text} / ${subSubLocationController.text.isEmpty?"Sub Sub Location":subSubLocationController.text}',style: textStyleBodyText1,),),
            // const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Center(child: Text(activityHeadController.text.isEmpty?"Sub Structure/Excavation":'${activityHeadController.text} / ${activityController.text}',style: textStyleBodyText1.copyWith(fontSize: 18),),),
            // const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          const SizedBox(height: 10,),
           CustomContainer2(
            child:
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Quantity: ${int.parse(_sliderValue.round().toString())} %",style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
            Slider(
              divisions: 100,
              activeColor: AppColors.primary,
              focusNode: null,
              inactiveColor: AppColors.lightGrey,
                value: _sliderValue.roundToDouble(),
                onChanged: (newValue) {
                  setState(() {
                    _sliderValue = newValue;
                    if(totalQuantity.text.isNotEmpty){
                    achivedController.text=((newValue.round()/100)*double.parse(totalQuantity.text).toInt()).toInt().toString();
                    comulativeController.text=((newValue.round()/100)*double.parse(totalQuantity.text).toInt()).toInt().toString();
                    }
                  });
                },
                min: 0,
                max: 100,
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text("${comulativeController.text} ${  uomName.text.isEmpty?"UNIT":uomName.text}",style: textStyleBodyText1),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("${totalQuantity.text.isEmpty?"X":totalQuantity.text} ${uomName.text.isEmpty?"UNIT":uomName.text}",style: textStyleBodyText1),
            ],),
            const SizedBox(height: 30,),
            Container(
              margin:const EdgeInsets.only(left: 20,right:20),
              child: 
            Row(children: [
               Text("TOTAL QUANTITY: ${totalQuantity.text}",style: textStyleBodyText4),
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
                  child:Center(child: Text(achivedController.text.isEmpty?"0.0":'${achivedController.text}.0',style: textStyleBodyText4,),),
                ),
                ),
              ),
              const SizedBox(height: 10,),
              Center(child: Text("Achived", style: textStyleBodyText4,),),
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
                  child:Center(child: Text(comulativeController.text.isEmpty?"0.0":'${comulativeController.text}.0',style: textStyleBodyText4,),),
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
          },
        const SizedBox(height: 10,),
        //////////////////////////////////////////////////////////////////
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
              Text("LABOUR", style: textStyleBodyText1.copyWith(fontSize: 18),)
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
                   for(var i = 0; i < subItems.length; i++) {
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
          if(subItems.isNotEmpty)
          if(subItems[outerIndex].isNotEmpty && _items2.isNotEmpty)
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
                      contractorLabourLinkingIDText.text= (contractorLabourLinkingId[contractorID[int.parse(contractorIDIndex.text)]]![subItems[outerIndex].indexOf(newValue)-1]).toString();
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
                          print("-------------------------------------------");
                          print("contractorID");
                          print(contractorID[outerIndex+1]);
                          print("-------------------------------------------");
                          print("entered value");
                          print(value);
                          print("+++++++++++++++++++++++++++++++++++++");
                          print(contractorLabourLinkingId[contractorID[outerIndex+1]]![index]);
                          print("============================================");
                          print(index);
                          print("}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
                          print(contractorLabourDetails);
                          print(contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)][0]);
                          print(contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)]);
                          print(contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)][1]);
                          print(contractorLabourDetails[outerIndex][index][int.parse(contractorLabourLinkingIDText.text)][1]);
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
                      print("hello");
                      print(_items2[outerIndex].values.toList().length);
                      print(_selectedDropdownValues2[outerIndex]);
                         if(_items2[outerIndex].containsKey('$outerIndex')){
                            _items2[outerIndex]['$outerIndex']!.add('Item ${_items2[outerIndex].length + 1}');
                          } else{
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
                          EasyLoading.showToast("Atleast one is required", toastPosition: EasyLoadingToastPosition.bottom);
                       }
                       } else {
                          EasyLoading.showToast("Please select before deleting", toastPosition: EasyLoadingToastPosition.bottom);
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
            SizedBox(
            width: MediaQuery.of(context).size.width,
            child:
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    SizedBox(
                      // height: 65,
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
                      height: 50,
                      child:Center(child: 
                      CustomTextFieldForNumber(
                          controller: _controllers[index],
                          onChanged : (value){
                            print("##############################");
                            print(value);
                                print("##############################");
                            enteredValues[index]=value.toString();
                          },
                        )
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
            CustomContainer2(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("REMARK",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               CustomTextField(enabled: true,controller: remarkController,hintText: "Enter here",)
          ])
            ),
            if(priorityController.text=="Labour Supply" || priorityController.text=="Misc.")...{
           CustomContainer2(
            child:
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
             value:debitToController.text.isNotEmpty?debitToController.text:null,
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
              items: itemsDebit.keys.map<DropdownMenuItem<String>>((String key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Text(itemsDebit[key]),
              );
            }).toList(),
              onChanged: (String? newValue) async {
                setState(() {
                  debitToController.text=newValue!;
                  dropdownvalueDebitTo = newValue;
                });
              },
            ),
          ),
          ]))},
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
                               // Call the _pickImage function with the gallery source
                               _pickImage(ImageSource.gallery);
                               // Close the modal pop-up
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
                               // Call the _pickImage function with the camera source
                               _pickImage(ImageSource.camera);
                               // Close the modal pop-up
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
              onPressed:(){
                 if(locationId.text.isEmpty){
                  EasyLoading.showToast('Location ID required',toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(subLocationId.text.isEmpty){
                  EasyLoading.showToast('SubLocation ID required',toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(subSubLocationId.text.isEmpty){
                  EasyLoading.showToast('SubSubLocation ID required',toastPosition: EasyLoadingToastPosition.bottom);
                }
                else{
                    context.pushNamed('ADD360IMAGE', queryParams: {
                    "locId": locationId.text,
                    "subLocId":subLocationId.text,
                    "subSubLocId":subSubLocationId.text,
                    "locName":locationController.text,
                    "subLocName":subLocationController.text,
                    "subSubLocName":subSubLocationController.text
              },);
                }
              },
              child: Text("Add 360 Images",style: textStyleBodyText1.copyWith(color: AppColors.black),),
             )
             ),
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
              onPressed:()async{
                 if(linkingActivityId.text.isEmpty && (priorityController.text=="Labour Supply" || priorityController.text=="PRW")){
                  EasyLoading.showToast("Linking Activity ID is required", toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(remarkController.text.isEmpty){
                  EasyLoading.showToast("Remark is required", toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(debitToController.text.isEmpty && (priorityController.text=="Labour Supply" || priorityController.text=="Misc.")){
                  EasyLoading.showToast("Debit To is required", toastPosition: EasyLoadingToastPosition.bottom);  
                }
                else if(contractorLabourDetails.isEmpty && (priorityController.text=="Labour Supply"|| priorityController.text=="Misc.")){
                  EasyLoading.showToast("Atleast one contractor is required", toastPosition: EasyLoadingToastPosition.bottom);  
                }
                else{
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var projectID=sharedPreferences.getString('projectIdd');
                var clientID=sharedPreferences.getString('client_id');
                FormData formData=FormData(); 
                var dio = Dio();
                if(priorityController.text=="Labour Supply"||priorityController.text=="Misc."){
                List progressDetails = [];
                for (var subList in contractorLabourDetails) {
                  for (var map in subList) {
                    // ignore: non_constant_identifier_names
                    var contractor_id = map.values.first[0];
                    var contractorLabourDetails1 = {
                      "contractor_labour_linking_id": map.keys.first.toString(),
                      "time": map.values.first[1].toString()
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
                formData.files.add(MapEntry("progress_image", await MultipartFile.fromFile(_selectedImage!.path, filename: "issueFile_image")));
                } catch (e) {
                  formData.fields.add(const MapEntry('progress_image', ''));
                }
                formData.fields.add(MapEntry('progress_data', jsonEncode(
                    {
                      "client_id": int.parse(clientID!),
                      "project_id": int.parse(projectID!),
                      "link_activity_id":linkingActivityId.text.isNotEmpty?int.parse(linkingActivityId.text):"",
                      "achived_quantity": achivedController.text.isNotEmpty? achivedController.text:"",
                      "total_quantity":totalQuantity.text.isNotEmpty?int.parse(totalQuantity.text):"",
                      "remarks": remarkController.text,
                      "contractor_id": pwrContractorId.text,
                      "progress_percentage":_sliderValue!=0.0?_sliderValue.toInt().toString():"",
                      "debet_contactor":int.parse(debitToController.text),
                      "progress_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      "cumulative_quantity": comulativeController.text,
                      "type":priorityController.text=="Misc."?1:0,
                      "save_type": "saveasdraft",
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
                   )
                   )
                   );
                  try {
                  var res= await dio.post(
                  Config.saveLabourSupplyProgressApi,
                  data: formData,
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status) {
                      return status! < 500;
                    },
                    headers: {
                      "authorization": "Bearer ${token!}",
                      "Content-type": "application/json",
                    },
                  ),
                    );
                    if(res.statusCode==200){
                    EasyLoading.showToast(priorityController.text=="Misc."?"Misc. Progress Saved":"Labour Supply Progress saved",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else{
                       EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                }catch(e){
                  EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                }
                }
                if(priorityController.text=="PRW"){
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var projectID=sharedPreferences.getString('projectIdd');
                var clientID=sharedPreferences.getString('client_id');
                  List pWRLabourDetailsList = [];
                    for(int i=0; i<_selectedDropdownValuesID.length; i++){
                      pWRLabourDetailsList.add({
                        "labour_count":int.parse((enteredValues[i].isNotEmpty?enteredValues[i]!="0"?enteredValues[i]:"1":"1")),
                        "pwr_type": _selectedDropdownValuesID[i]
                      });
                    }
                    List newList=[];
                    print(pWRLabourDetailsList);
                    if(pWRLabourDetailsList.isNotEmpty){
                     newList = [
                        {
                          "contractor_id": pwrContractorId.text,
                          "labours": [],
                          "contractorLabourDetails":[
                            {
                              "contractor_labour_linking_id": "",
                              "time": ""
                            }
                          ]
                        }
                      ];
                    }
                try {
                formData.files.add(MapEntry("progress_image", await MultipartFile.fromFile(_selectedImage!.path, filename: "issueFile_image")));
                } catch (e) {
                  formData.fields.add(const MapEntry('progress_image', ''));
                }
                formData.fields.add(MapEntry('progress_data', jsonEncode(
                    {
                      "client_id": int.parse(clientID!),
                      "project_id": int.parse(projectID!),
                      "link_activity_id":int.parse(linkingActivityId.text),
                      "achived_quantity": achivedController.text,
                      "total_quantity":int.parse(totalQuantity.text),
                      "remarks": remarkController.text,
                      "contractor_id":pwrContractorId.text.isNotEmpty?int.parse(pwrContractorId.text):0,
                      "progress_percentage": _sliderValue.toInt().toString(),
                      "debet_contactor":"0",
                      "progress_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      "cumulative_quantity": comulativeController.text,
                      "type": 2,
                      "save_type": "saveasdraft",
                      "created_by":int.parse(clientID),
                      "PWRLabourDetails": pWRLabourDetailsList,
                      "contractorLabourDetails": [],
                      "progressDetails": newList,
                    }
                   )
                   )
                   );
                  try {
                  var res= await dio.post(
                  Config.saveLabourSupplyProgressApi,
                  data: formData,
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status) {
                      return status! < 500;
                    },
                    headers: {
                      "authorization": "Bearer ${token!}",
                      "Content-type": "application/json",
                    },
                  ),
                    );
                    if(res.statusCode==200){
                    EasyLoading.showToast("PRW Progress saved", toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else{
                       EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                }catch(e){
                  EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                }
                }
                await getProgressCount.getProgressData(context: context);
                await getCompletedSiteProgressDataController.getCompletedListData(context: context);
                await getOnGoingSiteProgressDataController.getOnGoingListData(context: context);
                await getInQualitySiteProgressDataController.getInEqualityListData(context: context);
                 Get.put(GetCompletedSiteProgress());
                 Get.put(GetOnGoingSiteProgress());
                 Get.put(GetInEqualitySiteProgress());
                 EasyLoading.dismiss();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                }
              },
              child: Text("Save As Draft",style: textStyleBodyText4.copyWith(color: AppColors.black)),
             ),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:Size(MediaQuery.of(context).size.width/2.5,40),
                backgroundColor:  AppColors.green,
              elevation: 0,
              splashFactory: NoSplash.splashFactory),
              onPressed:()async{
                 if(linkingActivityId.text.isEmpty && (priorityController.text=="Labour Supply" || priorityController.text=="PRW")){
                  EasyLoading.showToast("Linking Activity ID is required", toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(remarkController.text.isEmpty){
                  EasyLoading.showToast("Remark is required", toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(debitToController.text.isEmpty && (priorityController.text=="Labour Supply" || priorityController.text=="Misc.")){
                  EasyLoading.showToast("Debit To is required", toastPosition: EasyLoadingToastPosition.bottom);  
                }
                else if(contractorLabourDetails.isEmpty && (priorityController.text=="Labour Supply"|| priorityController.text=="Misc.")){
                  EasyLoading.showToast("Atleast one contractor is required", toastPosition: EasyLoadingToastPosition.bottom);  
                }
                else{
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var projectID=sharedPreferences.getString('projectIdd');
                var clientID=sharedPreferences.getString('client_id');
                FormData formData=FormData(); 
                var dio = Dio();
                if(priorityController.text=="Labour Supply"||priorityController.text=="Misc."){
                List progressDetails = [];
                for (var subList in contractorLabourDetails) {
                  for (var map in subList) {
                    // ignore: non_constant_identifier_names
                    var contractor_id = map.values.first[0];
                    var contractorLabourDetails1 = {
                      "contractor_labour_linking_id": map.keys.first.toString(),
                      "time": map.values.first[1].toString()
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
                  if (!contractorExists){
                    newList.add({ "contractor_id": map["contractor_id"], "contractorLabourDetails": map["contractorLabourDetails"] });
                  }
                }
                try {
                formData.files.add(MapEntry("progress_image", await MultipartFile.fromFile(_selectedImage!.path, filename: "issueFile_image")));
                } catch (e) {
                  formData.fields.add(const MapEntry('progress_image', ''));
                }
                formData.fields.add(MapEntry('progress_data', jsonEncode(
                    {
                      "client_id": int.parse(clientID!),
                      "project_id": int.parse(projectID!),
                      "link_activity_id":linkingActivityId.text.isNotEmpty?int.parse(linkingActivityId.text):"",
                      "achived_quantity": achivedController.text.isNotEmpty? achivedController.text:"",
                      "total_quantity":totalQuantity.text.isNotEmpty?int.parse(totalQuantity.text):"",
                      "remarks": remarkController.text,
                      "contractor_id": pwrContractorId.text,
                      "progress_percentage":_sliderValue!=0.0?_sliderValue.toInt().toString():"",
                      "debet_contactor":int.parse(debitToController.text),
                      "progress_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      "cumulative_quantity": comulativeController.text,
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
                   )
                   )
                   );
                  try {
                  var res= await dio.post(
                  Config.saveLabourSupplyProgressApi,
                  data: formData,
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status) {
                      return status! < 500;
                    },
                    headers: {
                      "authorization": "Bearer ${token!}",
                      "Content-type": "application/json",
                    },
                  ),
                    );
                    if(res.statusCode==200){
                    EasyLoading.showToast(priorityController.text=="Misc."?"Misc. Progress Saved":"Labour Supply Progress saved",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else{
                       EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                }catch(e){
                  EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                }
                }
                if(priorityController.text=="PRW"){
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var projectID=sharedPreferences.getString('projectIdd');
                var clientID=sharedPreferences.getString('client_id');
                  List pWRLabourDetailsList = [];
                    for(int i=0; i<_selectedDropdownValuesID.length; i++){
                      pWRLabourDetailsList.add({
                        "labour_count":int.parse(enteredValues[i].isNotEmpty?enteredValues[i]!="0"?enteredValues[i]:"1":"1"),
                        "pwr_type": _selectedDropdownValuesID[i]
                      });
                    }
                    List newList=[];
                    if(pWRLabourDetailsList.isNotEmpty){
                     newList = [
                        {
                          "contractor_id": pwrContractorId.text,
                          "labours": [],
                          "contractorLabourDetails":[
                            {
                              "contractor_labour_linking_id": "",
                              "time": ""
                            }
                          ]
                        }
                      ];
                    }
                try {
                formData.files.add(MapEntry("progress_image", await MultipartFile.fromFile(_selectedImage!.path, filename: "issueFile_image")));
                } catch (e) {
                  formData.fields.add(const MapEntry('progress_image', ''));
                }
                formData.fields.add(MapEntry('progress_data', jsonEncode(
                    {
                      "client_id": int.parse(clientID!),
                      "project_id": int.parse(projectID!),
                      "link_activity_id":int.parse(linkingActivityId.text),
                      "achived_quantity": achivedController.text,
                      "total_quantity":int.parse(totalQuantity.text),
                      "remarks": remarkController.text,
                      "contractor_id":pwrContractorId.text.isNotEmpty?int.parse(pwrContractorId.text):0,
                      "progress_percentage": _sliderValue.toInt().toString(),
                      "debet_contactor":"0",
                      "progress_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      "cumulative_quantity": comulativeController.text,
                      "type": 2,
                      "save_type": "save",
                      "created_by":int.parse(clientID),
                      "PWRLabourDetails": pWRLabourDetailsList,
                      "contractorLabourDetails": [],
                      "progressDetails": newList,
                    }
                   )
                   )
                   );
                  try {
                  var res= await dio.post(
                  Config.saveLabourSupplyProgressApi,
                  data: formData,
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status) {
                      return status! < 500;
                    },
                    headers: {
                      "authorization": "Bearer ${token!}",
                      "Content-type": "application/json",
                    },
                  ),
                    );
                    print("###############################");
                    print(formData.fields);
                      print("###############################");
                    if(res.statusCode==200){
                    EasyLoading.showToast("PRW Progress saved", toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else{
                       EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                }catch(e){
                  EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                }
                }
                await getProgressCount.getProgressData(context: context);
                await getCompletedSiteProgressDataController.getCompletedListData(context: context);
                await getOnGoingSiteProgressDataController.getOnGoingListData(context: context);
                await getInQualitySiteProgressDataController.getInEqualityListData(context: context);
                 Get.put(GetCompletedSiteProgress());
                 Get.put(GetOnGoingSiteProgress());
                 Get.put(GetInEqualitySiteProgress());
                 EasyLoading.dismiss();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
               }},
              child: Text("Save",style: textStyleBodyText4.copyWith(color: AppColors.black),),
             )
            ]
           )
          )
        ]
      )
    )
);});
}
}