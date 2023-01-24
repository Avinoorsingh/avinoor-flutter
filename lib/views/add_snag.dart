import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/models/activity_head.dart';
import 'package:colab/models/sub_location_list.dart';
import 'package:colab/models/viewpoints.dart';
import 'package:http/http.dart' as http;
import 'package:image_painter/image_painter.dart';
import 'package:colab/models/location_list.dart';
import 'package:colab/views/activity_head.dart';
import 'package:colab/views/sub_location.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';
import '../models/category_list.dart';
import '../network/client_project.dart';

// ignore: must_be_immutable
class AddSnag extends StatefulWidget {
  AddSnag({Key? key,from}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var from;

  @override
  State<AddSnag> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<AddSnag> {
  final getSnag = Get.find<GetNewSnag>();
  late String subV="";
  late String subSubV="";
  final categoryController=TextEditingController();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final locationId=TextEditingController();
  final subSubLocationId = TextEditingController();
  final subLocationId = TextEditingController();
  final projectId=TextEditingController();
  final clientId = TextEditingController();
  final categoryIDController=TextEditingController();
  // ignore: non_constant_identifier_names
  final linking_activity_id=TextEditingController();
  final remarkController = TextEditingController();
  final debitToController=TextEditingController();
  final debitAmountController=TextEditingController();
  final snapAssignedToController=TextEditingController();
  final priorityController=TextEditingController();
  final assetImageController=TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput1 = TextEditingController();
  TextEditingController contractorInput = TextEditingController(text: "No Contractor");
  TextEditingController contractorID = TextEditingController();
  final location = ["Select Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue = 'Select Location';  
  final location2 = ["Select Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue2 = 'Select Sub Location';  
  final location3 = ["Select Sub Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue3 = 'Select Activity Head';  
  final debitTo = ["Select Debit to", "Person 1", "Person 2", "Person 3", "Person 4"];
  String dropdownvalueDebitTo = 'Select Debit to';  
  final assignedTo=["Select Name","Name 1"];
  String dropdownvalueAssignedTo="Select Name";
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);
 
   List<bool> isCardEnabled = [];
   List<bool> isCardEnabled2 = [];
   List<String> categoryNew=[];
   List<int> categoryID=[];
   List<String> locationList=[];
   List<String> assignedToList=[];
   List<int> assignedToListIndex=[];
   List<String> priority=[
    "Critical",
    "Major",
    "Minor",
   ];
   List<String> viewpoints=[];
   List viewpoints2=[];
   List<String> viewpointsToSent=[];
   List<String> viewpointsID=[];
   List<String> viewpointImagesUrl=[];
  final imageKey = GlobalKey<ImagePainterState>();
 
  File? image;
  CroppedFile? croppedFile;
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
          toolbarWidgetColor: AppColors.primary,
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
    late List<bool> isSelected;
  
    @override
  void initState() {
    super.initState(); 
    isSelected=[true,false,false];
    dateInput.text =getFormatedDate(DateTime.now().toString()); 
    dateInput1.text =getFormatedDate(DateTime.now().toString()); 
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
    return GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
      // if (kDebugMode) {
      //   print(signInController.getEmployeeList?.data!.first);
      // }
      if(signInController.getEmployeeList!.data!.isNotEmpty && assignedToList.isEmpty){
        assignedToList.add("Select Name");
        for(int i=0;i<signInController.getEmployeeList!.data!.length;i++){
          assignedToList.add(signInController.getEmployeeList!.data![i].userId.toString());
          assignedToListIndex.add(signInController.getEmployeeList!.data![i].id!);
        }
      }
      if(signInController.getCategoryList!=null){
      if(signInController.getCategoryList!.data!.isNotEmpty && categoryNew.isEmpty && categoryNew.isEmpty){
        List<Data>? categoryList=signInController.getCategoryList?.data;
        for(var data in categoryList!){
          categoryNew.add(data.name!);
          categoryID.add(data.id!);
        }
      }
      }
       if(signInController.getLocationList!.data!.isNotEmpty && locationList.isEmpty){
        List<LocationData>? locationList1=signInController.getLocationList?.data;
        locationList.add("Select Location");
        for(var data in locationList1!){
          locationList.add(data.locationName!);
        }
      }
     EasyLoading.dismiss();
   // print(dropDownNotifier.value);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.primary,
        title: Text("Create Snag",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            TextField(
               decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,),
                readOnly: true,
               controller: dateInput1,
             // "Date:  ${getFormatedDate(DateTime.now().toString())}",
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 22),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child:
          Text("Select Category",style: textStyleSubTitle1,),
          ),
          SizedBox(height: 90,child: 
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(15),
          itemCount: categoryNew.length,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled.add(false);
            return GestureDetector(
                onTap: (){
                  isCardEnabled.replaceRange(0, isCardEnabled.length, [for(int i = 0; i < isCardEnabled.length; i++)false]);
                  isCardEnabled[index]=true;
                  categoryController.text=categoryNew[index];
                  categoryIDController.text=categoryID[index].toString();
                  if (kDebugMode) {
                    print(categoryIDController.text);
                  }
                  setState(() {});
                },
                child: SizedBox(
                  height: 10,
                  width: 90,
                  child: Card(
                    elevation: 5,
                    color: isCardEnabled[index]? AppColors.primary:AppColors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color:  AppColors.primary,width: 1),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: 
                      FittedBox(child:
                      Text(categoryNew[index],textAlign: TextAlign.center,
                        style: TextStyle(
                            color: isCardEnabled[index]?Colors.black: AppColors.primary,
                          fontSize: 16
                        ),
                      ),
                      )
                    ),
                  ),
                )
            );
          }),
          ),
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
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) async{
                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                setState(() {
                  locationController.text=newValue!;
                  dropdownvalue = newValue;
                   });
                  try {
                    var getSubLocationListUrl=Uri.parse(Config.getSubLocationListApi);
                    var res=await http.post(
                    getSubLocationListUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                              "client_id":signInController.getProjectData?.clientid.toString(),
                              "project_id":1.toString(),
                              "location_id":locationList.indexOf(newValue!).toString(),
                            }
                            );
                  Map<String,dynamic> cData3=jsonDecode(res.body);
                  SubLocationList result3=SubLocationList.fromJson(cData3['data']);
                  signInController.getSubLocationList=result3; 
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
             String value= await Navigator.of(context).push(_createRoute());
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
                    var getActivityHeadApiUrl=Uri.parse(Config.getActivityHeadApi);
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
                  ActivityHead result4=ActivityHead.fromJson(cData4['data']);
                  signInController.getActivityHeadList=result4;
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
             String value= await Navigator.of(context).push(_createRoute2());
             setState(() {
              linking_activity_id.text=value.substring(value.indexOf('}')+1,value.indexOf(':'));
              subSubV=value.substring(0,value.indexOf('}'));
              subSubLocationController.text=value.substring(0,value.indexOf('}'));
             });
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                    var getContractorNameUrl=Uri.parse("${Config.getContractorName}${clientId.text}/${projectId.text}/${linking_activity_id.text}");
                    var res=await http.get(
                     getContractorNameUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                          );
                  Map<String,dynamic> cData5=jsonDecode(res.body);
                  if(res.body.isNotEmpty){
                    try {
                    contractorInput.text=cData5['data'][0]['contractor_name'];
                    contractorID.text=cData5['data'][0]['id'].toString();
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                      contractorInput.text="No Contractor";
                       setState(() {});
                    }
                  }
                  if(cData5['data'][0]['contractor_name']==null){
                    contractorInput.text="";
                  }
                    try {
                    var getViewPointsUrl=Uri.parse(Config.getViewpoints);
                    var res=await http.post(
                     getViewPointsUrl,
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                            "loc_id":locationId.text,
                            "sub_loc_id":  subLocationId.text,
                            "sub_sub_location_id":subSubLocationId.text,
                      }
                            );
                  Map<String,dynamic> cData6=jsonDecode(res.body);
                  ViewPointsApi result7=ViewPointsApi.fromJson(cData6);
                  if(res.body.isNotEmpty){
                    try {
                      if(viewpoints.isEmpty && viewpointsID.isEmpty){
                        for(int i=0;i<result7.data!.length;i++){
                          viewpoints2.add({'index':result7.data![i].viewpoint,'image':[]});
                          viewpoints.add(result7.data![i].viewpoint!);
                          viewpointsID.add(result7.data![i].viewpointNameId.toString());
                          viewpointImagesUrl.add(result7.data![i].masterFile.toString());
                          setState(() {});
                        }
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
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
           Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child:
            TextField(
              textAlign: TextAlign.center,
               decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,),
                readOnly: true,
                controller: contractorInput,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text("Mark Location",style: textStyleBodyText1,),),
            if(viewpointImagesUrl.isNotEmpty)
               Center(child:  Card(
            child:
            GestureDetector(
            onTap: () async {
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              assetImageController.text="";
              await sharedPreferences.remove('imgPath');
              await showDialog(
                useSafeArea: true,
                context: context,
                builder: (_) => imageDialog('Marker File','https://nodejs.hackerkernel.com/colab${viewpointImagesUrl.first}' , context, imageKey));
               assetImageController.text=sharedPreferences.getString('imgPath').toString();
               setState(() {});
              },
            child:
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: 
                      assetImageController.text.isEmpty?
                      NetworkImage('https://nodejs.hackerkernel.com/colab${viewpointImagesUrl.first}'):
                      FileImage(File(assetImageController.text)) as ImageProvider,
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter,
                    ),
                  ),
          ),
                )
              ),
              ),
              ])
          ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20.0),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Remark",style: textStyleBodyText1,),
                Text("*",style: textStyleBodyText1.copyWith(color: Colors.red),)
              ],),),
               const SizedBox(height: 10,),
            TextField(
              controller: remarkController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey[300],
                filled: true,
                hintText: "Type here",
                hintStyle: const TextStyle(color: Colors.black,),
                enabledBorder: OutlineInputBorder(
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
                disabledBorder: InputBorder.none,),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),
      ListView.builder(
              // padding: const EdgeInsets.only(bottom: 10,right: 120),
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: viewpoints2.length,
                itemBuilder: (context, index1) {
                  return 
                  Column(children: [
        Row(children: [
          Container(
           margin: const EdgeInsets.all(20.0),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child: 
          Text("VIEWPOINT: $index1",style: textStyleBodyText1,)
          )
         ],),
         Container(
           margin: const EdgeInsets.only(left:20,right: 20),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
         decoration:  BoxDecoration(
              color: Colors.grey[300],
              borderRadius:const BorderRadius.all(Radius.circular(10))
            ),
          child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
         Expanded(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewpoints2[index1]['image'].isEmpty?
            Image.asset('assets/images/ic_photo_black_48dp.png',height: 80,width: 80,):
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 10,right: 120),
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: viewpoints2[index1]['image'].length,
                itemBuilder: (context, index) {
                  return SizedBox(
                   height: 150,
                   width: 80,
                   child:
                  InkWell(
                      onTap: () {
                        return;
                      },
                          child:
                          FittedBox(
                           child:
                           Container(
                            margin: const EdgeInsets.only(top:10),
                            height: 150,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image:DecorationImage(
                                image:FileImage(File( viewpoints2[index1]['image'][index].path)),
                              fit: BoxFit.cover,
                              ),
                            )
                          )
                        )
                      )
                    );
                  }
                ),
              ],
            )
          ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                   Container(
                    margin: const EdgeInsets.all(10),
                  width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(173, 57, 54, 54),Color.fromARGB(250, 19, 14, 14)],
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
                      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      final File imagefile = File(image!.path);
                      viewpoints2[index1]['image'].add(imagefile);
                        setState(() { });
                  },
                  child: const Center(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
        ]),
        ]
      ),
         ),
          ]);}),
      const SizedBox(height: 10,),
             Container(
            width: double.infinity,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT TO",style: textStyleBodyText1,),
              ],),),
              const SizedBox(height: 10,),
              DropdownButtonFormField(
                 value: dropdownvalueDebitTo,
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
                 items: debitTo.map((String items){
                   return DropdownMenuItem(
                     value: items,
                     child: Text(items),
                   );
                 }).toList(),
                 onChanged: (String? newValue){
                   setState(() {
                     dropdownvalueDebitTo = newValue!;
                     debitToController.text=newValue;
                   });
                 },
               ),
          ])
            ),
            Column(children: [
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                padding: const EdgeInsets.only(top: 3,bottom: 3),
                child:
              Row(children: [Text("Due Date",style: textStyleHeadline3.copyWith(fontWeight: FontWeight.normal),)],),
              ),
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
               )
          ]),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20.0),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT AMOUNT",style: textStyleBodyText1,),
                Text("*",style: textStyleBodyText1.copyWith(color: Colors.red),)
              ],),),
               const SizedBox(height: 10,),
            TextField(
              keyboardType:TextInputType.number,
              controller: debitAmountController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                border: InputBorder.none,
                fillColor:Colors.grey[300],
                filled: true,
                hintText: "Enter here",
                hintStyle: const TextStyle(color: Colors.black,),
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
                disabledBorder: InputBorder.none,),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),
              Container(
            width: double.infinity,
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Snag Assigned To",style: textStyleBodyText1,),
              ],),),
              const SizedBox(height: 10,),
              DropdownButtonFormField(
                 value: dropdownvalueAssignedTo,
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
        focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
    ),
                 isExpanded: true,
                 items: assignedToList.map((String items){
                   return DropdownMenuItem(
                     value: items,
                     child: Text(items),
                   );
                 }).toList(),
                 onChanged: (String? newValue){
                   setState(() {
                    snapAssignedToController.text=assignedToListIndex[assignedToList.indexOf(newValue!)-1].toString();
                     dropdownvalueAssignedTo = newValue;
                   });
                 },
               ),
          ])
            ),
                Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(
              children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Snag Priority",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
           SizedBox(
            height: 75,child: 
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
                  width: 100,
                  child: Container(
                   decoration: BoxDecoration(
                     color: isCardEnabled2[index]? AppColors.primary:AppColors.white,
                     border: Border.all(width: 1.2,color:  AppColors.primary,),
                    ),
                    child: Center(
                      child: Text(priority[index],textAlign: TextAlign.center,
                        style: TextStyle(
                            color: isCardEnabled2[index]?Colors.black: AppColors.primary,
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
            ),
             Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: 
            [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: AppColors.white
              ),
              child: const Text("Cancel",style: TextStyle(color: Colors.black),)),
              ElevatedButton(onPressed: () async{
                if(categoryIDController.text.isEmpty){
                  EasyLoading.showToast("Please select Category",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(locationId.text.isEmpty){
                  EasyLoading.showToast("Please select Location",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(subLocationId.text.isEmpty){
                  EasyLoading.showToast("Please select Sub Location",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(subSubLocationId.text.isEmpty){
                  EasyLoading.showToast("Please select Activity Head",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(remarkController.text.isEmpty){
                  EasyLoading.showToast("Please enter a remark",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(debitAmountController.text.isEmpty){
                  EasyLoading.showToast("Please enter debit amount",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(snapAssignedToController.text.isEmpty){
                  EasyLoading.showToast("Please assign snag",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(viewpoints2[0]['image'].isEmpty){
                  EasyLoading.showToast("Please upload atleast one snag image",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else{
                // ignore: non_constant_identifier_names
                List VID=[];
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var createdById=sharedPreferences.getString('id');
                FormData formData=FormData(); 
                var dio = Dio();
                for(int i=0;i<viewpoints2.length;i++){
                  if(viewpoints2[i]['image'].isNotEmpty){
                  for(int j=0;j<viewpoints2[i]['image'].length;j++){
                    viewpointsToSent.add(viewpoints2[i]['image'][j].toString());
                    VID.add(viewpointsID[i]);
                  }
                  }
                }
                    if(viewpointsToSent.isNotEmpty){
                    for (var item in viewpointsToSent) {
                      formData.files.add(
                        MapEntry("viewpoint_${VID[viewpointsToSent.indexOf(item)]}", await MultipartFile.fromFile(viewpointsToSent[viewpointsToSent.indexOf(item)].split(': ')[1].substring(1,viewpointsToSent[viewpointsToSent.indexOf(item)].split(': ')[1].length-1), filename: 'image1'))
                      );
                    }
                    }
                try {
                formData.files.add(MapEntry("markup_file", await MultipartFile.fromFile(assetImageController.text, filename: "image_name")));
                } catch (e) {
                  formData.fields.add(const MapEntry('markup_file', ''));
                }
                formData.fields.add(MapEntry('snags_data', jsonEncode({
                      "client_id":int.parse(clientId.text),
                      "project_id": int.parse(projectId.text),
                      "category_id": int.parse(categoryIDController.text),
                      "location_id": int.parse(locationId.text),
                      "sub_loc_id": int.parse(subLocationId.text),
                      "sub_sub_loc_id": int.parse(subSubLocationId.text),
                      "activity_head_id": 1,
                      "activity_id":int.parse(signInController.getActivityHeadList!.data![0].activityId.toString()),
                      "contractor_id":contractorID.text.isNotEmpty? int.parse(contractorID.text.toString())-1:"",
                      'debet_contractor_id':2,
                      "remark": remarkController.text,
                      "debit_note": "this is debit note",
                      "debit_amount":int.parse(debitAmountController.text),
                      "due_date": dateInput.text,
                      "assigned_to": int.parse(snapAssignedToController.text),
                      "created_by": int.parse(createdById!),
                      "snag_status": "N",
                      "snag_priority": priorityController.text== "Critical"?'CR':priorityController.text=="Major"?'MA':priorityController.text=="Minor"?'MI':"",
                   }
                   )
                   )
                   );
                    if (kDebugMode) {
                      print(formData.fields);
                    }
                  try {
                    await dio.post(
                  "http://nodejs.hackerkernel.com/colab/api/add_snags",
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
                    EasyLoading.showToast("Snag Saved",toastPosition: EasyLoadingToastPosition.bottom); 
                    // await getSnag.getSnagData(context: context);
                    await getSnag.getSnagData(context: context);
                    Get.put(GetNewSnag()); 
                         // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     if (kDebugMode) {
                       print(e);
                     } 
                    }
                }
              }, 
               style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: const Color.fromARGB(255, 91, 235, 96)
              ),
              child: const Text("Save",style: TextStyle(color: Colors.black),))
            ],
          )
             )
            
        ])
          ));
  }
     );
  }
}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SubLocation(),
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


Route _createRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ActivityHeadPage(),
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

Widget imageDialog(text, path, context, imageKey) {
return Dialog(
  backgroundColor: Colors.transparent,
  elevation: 0,
  child: Column(
    children: [
      // ignore: avoid_unnecessary_containers
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              style: ElevatedButton.styleFrom(backgroundColor:  AppColors.primary,),
              child: const Text("CANCEL",style: TextStyle(color: AppColors.white),),
            ),
          ],
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/1.4,
        child: ImagePainter.network(
          '$path',
           controlsAtTop: false,
           initialColor: Colors.red,
          scalable: true,
          key:imageKey,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           IconButton(
            iconSize: 80,
            splashRadius: 1,
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.check_circle_sharp,
              color: Colors.red,
            ),
            onPressed: () async{
              var random = Random();
              var n1 = random.nextInt(10000000);
              final image = await imageKey.currentState.exportImage();
              final directory = (await getApplicationDocumentsDirectory()).path;
              await Directory('$directory/sample/$n1').create(recursive: true);
              final fullPath = '$directory/sample/$n1/image.png';
              final imgFile = File(fullPath);
              imgFile.writeAsBytesSync(image);
              // if (kDebugMode) {
              //   print(imgFile.path);
              // }
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("imgPath", imgFile.path);
              Navigator.of(context, rootNavigator: true,).pop('dialog');
            },
          ),
        ],
      ),
    ],
  ),
);}