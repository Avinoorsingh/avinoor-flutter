import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:colab/config.dart';
import 'package:colab/models/progress_location_data.dart';
import 'package:colab/models/snag_data.dart';
import 'package:colab/network/client_project.dart';
import 'package:colab/routes.dart';
import 'package:colab/views/sub_location.dart';
import 'package:colab/views/sub_location_progress.dart';
import 'package:colab/views/sub_sub_location_progress.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
import '../models/progress_activityHead_data.dart';
import '../models/progress_sublocation_data.dart';

// ignore: must_be_immutable
class AddProgressEntry extends StatefulWidget {
  AddProgressEntry({Key? key, this.from, this.snagModel }) : super(key: key);

 // ignore: prefer_typing_uninitialized_variables
 final from;
 dynamic snagModel;
  @override
  State<AddProgressEntry> createState() => _AddProgressState();
}

class _AddProgressState extends State<AddProgressEntry> {
  final signInController=Get.find<SignInController>();
  late String subV="";
  late String subSubV="";
  final categoryController=TextEditingController();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final linking_activity_id=TextEditingController();
  final remarkController = TextEditingController();
  final deSnagRemarkController=TextEditingController();
  final closingRemarkController=TextEditingController();
  final markController=TextEditingController();
  final debitToController=TextEditingController();
  final debitAmountController=TextEditingController();
  final snagAssignedByController=TextEditingController();
  final snagAssignedToController=TextEditingController();
  final priorityController=TextEditingController();
  TextEditingController dateInput = TextEditingController();
  List<String> locationList=[];
  List<int> locationID=[];
  TextEditingController contractorInput = TextEditingController(text: "No Contractor");
  final location = ["Select Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue = 'Select Contractor Name';  
  final location2 = ["Select Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue2 = 'Select Sub Location';  
  final location3 = ["Select Activity Head", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue3 = 'Select Activity Head';  
  final debitTo = ["Select Debit to", "Person 1", "Person 2", "Person 3", "Person 4"];
  String dropdownvalueDebitTo = 'Select Debit to';  
  final assignedTo=["Select Name","Name 1"];
  String dropdownvalueAssignedTo="Select Name";
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);
  final locationId=TextEditingController();
  final subSubLocationId = TextEditingController();
  final subLocationId = TextEditingController();
  final projectId=TextEditingController();
  final clientId = TextEditingController();
  final categoryIDController=TextEditingController();

   List<String> imageData=[];
 
   List<bool> isCardEnabled = [];
   List<bool> isCardEnabled2 = [];
   List<String> deSnagImages=[];

   List<String> priority=[
    "Labour Supply",
    "PRW",
    "Misc.",
   ];
  List viewpoints=[];
  List deSnagImage=[];
  List viewpointID=[];
  TextEditingController contractorController=TextEditingController();
  TextEditingController uOfName=TextEditingController();
  TextEditingController totalQuantity=TextEditingController();

  File? image;
  CroppedFile? croppedFile;
  var groupedViewpoints = {};
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
     List<String> contractorList=["Select Contractor Name"];
    @override
  void initState() {
    super.initState(); 
    priorityController.text="PRW";
     for (var map in viewpoints) {
    // Check if the viewpoints is already in the map
    if (groupedViewpoints.containsKey(map['id'])) {
      // If it is, add the name to the list of names for that viewpoint
      groupedViewpoints[map['id']]?.add(map['fileName']);
    } else {
      // If it isn't, create a new list of names for that viewpoint and add the name
      groupedViewpoints[map['id']] = [map['fileName']];
    }
  }

    // print("I am here, here is the viewpoint");
    // print(groupedViewpoints);
    dateInput.text =getFormatedDate(DateTime.now().toString());
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
    final f = DateFormat('yyyy-MM-dd hh:mm a');
   getFormatedDate(date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
    }

  bool iconPressed=false;
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return
    GetBuilder<GetUserProfileNetwork>(builder: (_){
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
      }
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
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));
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
          if(priorityController.text!="Misc.")...{
           Container(
           margin: const EdgeInsets.only(left:20,right:20,),
           padding: const EdgeInsets.only(bottom: 20,),
            child: 
           DropdownButtonFormField(
              value: locationList[0],
             icon: const Padding( 
              padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_circle_outlined)
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
              items: locationList.map((String items){
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
                }).toList(),
                onChanged: (String? newValue) async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                  var projectID=sharedPreferences.getString('projectIdd');
                  var clientID=sharedPreferences.getString('client_id');
                  setState(() {
                  locationController.text=newValue!;
                  dropdownvalue = newValue;
                   });
                  try {
                    locationId.text=locationID[locationList.indexOf(newValue!)].toString();
                    var getSubLocationListUrl=Uri.parse(Config.getProgressSubLocationListApi);
                    var res=await http.post(
                    getSubLocationListUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                              "client_id":clientID,
                              "project_id":projectID,
                              "location_id":locationId.text,
                            }
                        );
                  Map<String,dynamic> cData3=jsonDecode(res.body);
                  print("------------------------------------------");
                  print(cData3);
                  ProgressSubLocationData result3=ProgressSubLocationData.fromJson(cData3);
                  signInController.getProgressSubLocationData=result3; 
                  } catch (e) {
                    if (kDebugMode) {
                    print(e);
                  }
                }
              },
            ),
          ),
          Container(
           margin: const EdgeInsets.only(left:20,right:20),
            child: 
            InkWell(
                onTap: () async {
                  if(locationController.text.isNotEmpty){
             String value= await Navigator.of(context).push(_createRoute(locationId.text));
             setState(() {
                  if(value.isNotEmpty){
                  subSubLocationId.text=value.substring(value.indexOf('?')+1,value.indexOf('&'));
                  clientId.text=value.substring(value.indexOf('&')+1,value.indexOf('*'));
                  projectId.text=value.substring(value.indexOf('*')+1,value.indexOf('#'));
                  locationId.text =value.substring(value.indexOf("#")+1,value.indexOf(":"));
                  subLocationId.text=value.substring(value.indexOf(":")+1,value.indexOf("@"));
                  subV=value.substring(0,value.indexOf('?')); 
                  subLocationController.text=value.substring(0,value.indexOf('?'));
                  }
                });
                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                 var token=sharedPreferences.getString('token');
                try {
                    var getActivityHeadApiUrl=Uri.parse(Config.getProgressActivityHeadListApi);
                    var res=await http.post(
                     getActivityHeadApiUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                              "client_id":signInController.getProjectData?.clientid.toString(),
                              "project_id":projectId.text,
                              "location_id":locationId.text,
                              "sub_loc_id":subLocationId.text,
                              "sub_sub_loc_id":subSubLocationId.text,
                            }
                            );
                            Map<String,dynamic> cData4=jsonDecode(res.body);
                            print("|||||||||||||||||||||||||||||||||||||");
                            print(signInController.getProjectData?.clientid.toString());
                            print(projectId.text);
                            print(locationId.text);
                            print(subLocationId.text);
                            print(subSubLocationId.text);
                            if(cData4['success']==true){
                            ProgressActivityHeadData result4=ProgressActivityHeadData.fromJson(cData4);
                            signInController.getProgressActivityHeadApi=result4;
                            }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
                  }
                  else if(locationController.text.isEmpty){
                    EasyLoading.showToast("Please select Location",toastPosition: EasyLoadingToastPosition.bottom);
                  }
            },
              child: 
              DropdownButtonFormField(
                onTap: () {
                  context.pushNamed('SUBLOCATION');
                },
                icon: const Padding( 
                  padding: EdgeInsets.only(left:20),
                  child:Icon(Icons.arrow_drop_down_circle_outlined)
                ), 
                iconEnabledColor: Colors.grey,
                style: const TextStyle(
                color: Colors.black,
                fontSize: 14
                ), 
                dropdownColor: AppColors.white,
                decoration: const InputDecoration(enabledBorder: OutlineInputBorder( //<-- SEE HERE
                borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              focusedBorder: OutlineInputBorder( //<-- SEE HERE
              borderSide: BorderSide(color: Colors.grey, width: 1),
               ),
                ),
              isExpanded: true,
              items: null,
              // ignore: unnecessary_null_comparison
              hint: Text(subV==null||subV.isEmpty?dropdownvalue2:subV, style:const TextStyle(color: Colors.black),),
              onChanged: (String? newValue){
                setState(() {
                  subLocationController.text=newValue!;
                  dropdownvalue2 = newValue;
                });
              },
            ),
            )
          ),
          Container(
           margin: const EdgeInsets.only(left:20,right:20),
           padding: const EdgeInsets.only(top: 20,bottom: 20),
            child:
             InkWell(
              onTap: () async {
              if(subLocationId.text.isNotEmpty && locationController.text.isNotEmpty){
             String value= await Navigator.of(context).push(_createRoute2(locationId.text, subLocationId.text,subSubLocationId.text,));
             setState(() {
              linking_activity_id.text=value.substring(value.indexOf('}')+1,value.indexOf(':'));
              subSubV=value.substring(0,value.indexOf('}'));
              subSubLocationController.text=value.substring(0,value.indexOf('}'));
              print(linking_activity_id.text);
              });
            }
            else if(locationController.text.isEmpty){
              EasyLoading.showToast("Please Select Location", toastPosition: EasyLoadingToastPosition.bottom);
            }
            else if(subLocationId.text.isEmpty){
              EasyLoading.showToast("Please Select SubLocation",toastPosition: EasyLoadingToastPosition.bottom);
            }
            },
              child:  
           DropdownButtonFormField(
             icon: const Padding( 
              padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_circle_outlined)
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
              items: null,
              // ignore: unnecessary_null_comparison
              hint:  Text(subSubV==null||subSubV.isEmpty?dropdownvalue3:subSubV, style:const TextStyle(color: Colors.black),),
              onChanged: (String? newValue){
                setState(() {
                  subSubLocationController.text=newValue!;
                  dropdownvalue3 = newValue;
                });
              },
            ),
             ),
          ),
           CustomContainer2(
            child:
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Quantity: ${int.parse(_sliderValue.toInt().toString())} %",style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
            Slider(
              divisions: 100,
              activeColor: AppColors.primary,
              focusNode: null,
              inactiveColor: Colors.transparent,
                value: _sliderValue,
                onChanged: (newValue) {
                  setState(() {
                    _sliderValue = newValue;
                  });
                },
                min: 0,
                max: 100,
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text("0 CUM",style: textStyleBodyText1),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("267 CUM",style: textStyleBodyText1),
            ],),
            const SizedBox(height: 30,),
            Container(
              margin:const EdgeInsets.only(left: 20,right:20),
              child: 
            Row(children: [
               Text("TOTAL QUANTITY: 267",style: textStyleBodyText4),
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
                Container(
                  width: 120,
                  child: 
                  Padding(
                  padding:const EdgeInsets.all(8.0),
                  child:Center(child: Text('0.0',style: textStyleBodyText4,),),
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
                Container(
                  width: 120,
                  child: 
                  Padding(
                  padding:const EdgeInsets.all(8.0),
                  child:Center(child: Text('0.0',style: textStyleBodyText4,),),
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
           margin: const EdgeInsets.only(left:20,right:20,top: 20),
           padding: const EdgeInsets.only(bottom: 10,),
            child: 
           DropdownButtonFormField(
              value: contractorList[0],
             icon: const Padding( 
              padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_circle_outlined)
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
              items: contractorList.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                setState(() {
                  contractorController.text=newValue!;
                  dropdownvalue = newValue;
                   });
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Over-Time',style: textStyleBodyText1.copyWith(color: Colors.grey),)],)
          },
          if(priorityController.text!='Labour Supply' && priorityController.text!="Misc.")...{
               CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text("Irshad Khan-COMP 3",style: textStyleBodyText1,),),
             const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Over-Time",style: textStyleBodyText1.copyWith(fontSize: 16),)
            ],),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    width: 120,
                    height: 40,
                    child:Center(child: Text('Skilled',style: textStyleBodyText1.copyWith(fontSize: 18,color: Colors.grey),),),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  height: 40,
                  width: 120,
                  child: 
                 TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Labour count',
                      hintStyle:const TextStyle(fontSize: 14),
                      enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    ),
                  )
                ),
              ],
            ),
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    width: 120,
                    height: 40,
                    child:Center(child: Text('Unskilled',style: textStyleBodyText1.copyWith(fontSize: 18,color: Colors.grey),),),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  height: 40,
                  width: 120,
                  child: 
                 TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Labour count',
                      hintStyle:const TextStyle(fontSize: 14),
                      enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    ),
                  )
                ),
              ],
            )
          }
          ],) 
            ),
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
           margin: const EdgeInsets.only(left:20,right:20,top: 20),
           padding: const EdgeInsets.only(bottom: 20,),
            child: 
           DropdownButtonFormField(
              value: debitTo[0],
             icon: const Padding( 
              padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_circle_outlined)
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
              items: debitTo.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                setState(() {
                  contractorController.text=newValue!;
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
              onPressed:(){},
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
              onPressed:(){},
              child: Text("Save As Draft",style: textStyleBodyText4.copyWith(color: AppColors.black)),
             ),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:Size(MediaQuery.of(context).size.width/2.5,40),
                backgroundColor:  AppColors.green,
              elevation: 0,
              splashFactory: NoSplash.splashFactory),
              onPressed:(){},
              child: Text("Save",style: textStyleBodyText4.copyWith(color: AppColors.black),),
             )
             ]
             )
             )
]
)
)
);
});
}
}

Route _createRoute(var locationID) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SubLocationProgress(locID: locationID,),
   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
},
  );
}

Route _createRoute2(var locationID, var subLocationID, var subSubLocationID) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SubSubLocationProgress(locID: locationID, subLocID:subLocationID, subSubLocID:subSubLocationID,),
   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
},
  );
}