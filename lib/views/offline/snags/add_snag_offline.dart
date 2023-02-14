import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/models/contractor_data_offline.dart';
import 'package:colab/views/activity_head_offline.dart';
import 'package:colab/views/sub_location_offline.dart';
import 'package:flutter/services.dart';
import 'package:image_painter/image_painter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/signInController.dart';
import '../../../models/all_offline_data2.dart';
import '../../../models/category_list.dart';
import '../../../models/clientEmployee.dart';
import '../../../network/client_project.dart';
import '../../../services/local_database/local_database_service.dart';

// ignore: must_be_immutable
class AddSnagOffline extends StatefulWidget {
  AddSnagOffline({Key? key,from}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var from;

  @override
  State<AddSnagOffline> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<AddSnagOffline> {
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
  String dropdownvalue = 'Select Location';  
  final location2 = ["Select Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue2 = 'Select Sub Location';  
  final location3 = ["Select Sub Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue3 = 'Select Activity Head';  
  List<String> debitTo = [];
  Map<String, dynamic> itemsDebit={};
  List<int> debitToId=[];
  String dropdownvalueDebitTo = 'Select Debit to';  
  final assignedTo=["Select Name","Name 1"];
  String dropdownvalueAssignedTo="Select Name";
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);
 
   List<bool> isCardEnabled = [];
   List<bool> isCardEnabled2 = [];
   List<String> categoryNew=[];
   List<int> categoryID=[];
   List<String> locationList=[];
   List<int> locationListID=[];
   var subLocationList=[];
   var activityHead=[];
   List<int> subSubLocationListID=[];
   List<String> assignedToList=[];
   List<int> assignedToListIndex=[];
   List<String> priority=[
    "Critical",
    "Major",
    "Minor",
   ];
   List<String> viewpoints=[];
   List viewpoints2=[];
   List viewpointsName=[];
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
    List<AllOfflineData> allOfflineData=[];
    CategoryList? categoryData;
    ContractorDataOffline? contractorData;
    ClientEmployee? employeeData;
    List snagData2=[];
    late DatabaseProvider databaseProvider;
    List dateDifference=[];
  
    @override
  void initState() {
    super.initState(); 
    isSelected=[true,false,false];
    databaseProvider = DatabaseProvider();
    databaseProvider.init();
    super.initState();
    fetchAllData();
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

    Future<List<AllOfflineData>> fetchAllData() async {
    allOfflineData= await databaseProvider.getAllOfflineModel();
     await fetchCategoryData();
     await fetchContractorData();
     await fetchEmployeeData();
     setState(() {
       
     });
    return allOfflineData;
    }

    Future<CategoryList> fetchCategoryData() async {
    categoryData = await databaseProvider.getCategoryModel();
    return categoryData!;
    }

    Future<ContractorDataOffline> fetchContractorData() async {
    contractorData = await databaseProvider.getContractorModel();
    return contractorData!;
    }

    Future<ClientEmployee> fetchEmployeeData() async {
    employeeData = await databaseProvider.getEmployeeModel();
    return employeeData!;
    }

  bool iconPressed=false;
  @override
  Widget build(BuildContext context) {
      final signInController=Get.find<SignInController>();
      if(allOfflineData.isNotEmpty && assignedToList.isEmpty){
        assignedToList.add("Select Name");
        assignedToListIndex.add(8989898);
        if(employeeData!=null){
          if(employeeData!.data!=null){
        for(int i=0;i<employeeData!.data!.length;i++){
          assignedToList.add(employeeData!.data![i].userId.toString());
          assignedToListIndex.add(employeeData!.data![i].id!);
            }
          }
        }
      if(categoryData!=null){
      if(categoryData!.data!=null){
      if(categoryData!.data!.isNotEmpty && categoryNew.isEmpty){
        for(int i=0;i<categoryData!.data!.length;i++){
          categoryNew.add(categoryData!.data![i].name!);
          categoryID.add(categoryData!.data![i].id!); 
        }
      }
      }
      }
      if(contractorData!=null){
      if(contractorData!.data!=null){
      if(contractorData!.data!.isNotEmpty && debitTo.isEmpty){
        debitTo.add("Select Debit to");
        debitToId.add(8989898);
        itemsDebit={};
        for(int i=0;i<contractorData!.data!.length;i++){
          itemsDebit[contractorData!.data![i].id.toString()] = contractorData!.data![i].contractorName;
          debitTo.add(contractorData!.data![i].contractorName!);
          debitToId.add(contractorData!.data![i].id!); 
        }
      }
      }
      }
       if(allOfflineData.isNotEmpty && locationList.isEmpty){
        locationList.add("Select Location");
        locationListID.add(999098);
        for(int i=0;i<allOfflineData[0].locationOfflineData!.length;i++){
          locationList.add(allOfflineData[0].locationOfflineData![i].locationName!);
          locationListID.add(allOfflineData[0].locationOfflineData![i].locationId!); 
        }
       }
        if(allOfflineData.isNotEmpty && subLocationList.isEmpty){
        for(int i=0;i<allOfflineData[0].locationOfflineData!.length;i++){
          subLocationList.add(allOfflineData[0].locationOfflineData![i].subLocationInfo!);
        }
       }
       try {
        if(allOfflineData.isNotEmpty && activityHead.isEmpty){
        for(int i=0;i<allOfflineData[0].locationOfflineData!.length;i++){
          if(allOfflineData[0].locationOfflineData!.isNotEmpty){
          for(int j=0;j<allOfflineData[0].locationOfflineData![i].subLocationInfo!.length;j++){
            for(int k=0;k<allOfflineData[0].locationOfflineData![i].subLocationInfo![j].subSubLocationInfo!.length;k++) {
                 activityHead.add(allOfflineData[0].locationOfflineData![i].subLocationInfo![j].subSubLocationInfo![k].subSubLocationActivity!);
            }
          }
          }
        }
       }
       } catch (e) {
        if (kDebugMode) {
          print(e);
        } 
       }
       }
    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.primary,
        title: Text("Create Snag", style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body:allOfflineData.isNotEmpty? SingleChildScrollView(
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
              items: locationList.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) async{
                setState(() {
                  locationController.text=newValue!;
                  dropdownvalue = newValue;
                  subLocationController.text="";  
                  subV="";
                  linking_activity_id.text="";
                  subSubV="";
                  subSubLocationController.text="";
                  subSubLocationId.text="";
                  subLocationId.text="";
                   });
                  try {
                  // ignore: prefer_typing_uninitialized_variables
                  var item;
                  for(int i=0;i<subLocationList.length;i++){
                    for(int j=0;j<subLocationList[i].length;j++){
                      if(subLocationList[i][j].locationId==locationListID[locationList.indexOf(newValue!)]){
                         item=subLocationList[i];
                         break;
                      }
                    }
                  }
                  signInController.getSubLocationList=item;
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
                try {
                    signInController.getActivityHeadList=activityHead;
                  } catch (e) {
                      if (kDebugMode) {
                        print("Error");
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
           margin: const EdgeInsets.only(left:20, right:20),
           padding: const EdgeInsets.only(top: 20, bottom: 20),
            child:
             InkWell(
                onTap: () async {
                  if(subLocationId.text.isNotEmpty && locationController.text.isNotEmpty){
                  String value= await Navigator.of(context).push(_createRoute2());
                  setState((){
                    linking_activity_id.text=value.substring(value.indexOf('}')+1,value.indexOf(':'));
                    subSubV=value.substring(0,value.indexOf('}'));
                    subSubLocationController.text=value.substring(0,value.indexOf('}'));
                  });
                  try {
                    List subLocationInfo = [];
                    List subSubLocationInfo = [];
                    List viewPointNumberList = [];
                    List masterImage=[];
                    subLocationInfo.clear();
                    subSubLocationInfo.clear();
                    viewPointNumberList.clear();
                    viewpointImagesUrl.clear();
                    masterImage.clear();
                    for (var i = 0; i < allOfflineData.length; i++) {
                      if (allOfflineData[0].locationOfflineData![i].locationId == int.parse(locationId.text)) {
                        subLocationInfo = allOfflineData[0].locationOfflineData![i].subLocationInfo!;
                        masterImage=allOfflineData[0].masterImageOfSnag!;
                        break;
                      }
                    }
                    for (var i = 0; i < subLocationInfo.length; i++) {
                      if (subLocationInfo[i].locationId == int.parse(locationId.text) &&
                          subLocationInfo[i].subLocId == int.parse(subLocationId.text)) {
                        subSubLocationInfo = subLocationInfo[i].subSubLocationInfo;
                        break;
                      }
                    }
                    for (var i = 0; i < subSubLocationInfo.length; i++) {
                      if (subSubLocationInfo[i].locationId == int.parse(locationId.text) &&
                          subSubLocationInfo[i].subLocId == int.parse(subLocationId.text) &&
                          subSubLocationInfo[i].subLocationId == int.parse(subSubLocationId.text)){
                          viewPointNumberList = subSubLocationInfo[i].viewPointNumberlist;
                          viewpointImagesUrl.add(masterImage[i].masterFile.toString());
                          break;
                      }
                    }
                    for(int i=0; i < subSubLocationInfo.length; i++) {
                        for(int j=0; j < subSubLocationInfo[i].subSubLocationActivity.length; j++) {
                          if(subSubLocationInfo[i].subSubLocationActivity[j].linkingActivityId == int.parse(linking_activity_id.text)) {
                            contractorInput.text = subSubLocationInfo[i].subSubLocationActivity[j].contractorName;
                            contractorID.text=subSubLocationInfo[i].subSubLocationActivity[j].contId.toString();
                            break;
                          }
                        }
                      }
                  if(viewPointNumberList.isNotEmpty){
                    try {
                      if(viewpoints.isEmpty && viewpointsID.isEmpty){
                        for(int i=0;i<viewPointNumberList.length;i++){
                          viewpoints2.add({'index':viewPointNumberList[i].viewpoint,'image':[]});
                          viewpoints.add(viewPointNumberList[i].viewpoint!);
                          viewpointsID.add(viewPointNumberList[i].id.toString());
                          setState(() {});
                        }
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  }
                  setState(() {});
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
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text("Mark Location",style: textStyleBodyText1,),),
            if(viewpointImagesUrl.isNotEmpty)
            Center(child:  
            Card(
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: 
                      assetImageController.text.isEmpty ||assetImageController.text=='null' ?
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
      if(viewpoints2.isNotEmpty)...{
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child: 
          Text("Select Viewpoints",style: textStyleBodyText1.copyWith(color: Colors.grey,fontSize: 14),)
          )
         ],),
      },
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
          Text("VIEWPOINT: View ${index1+1}",style: textStyleBodyText1,)
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
            const Icon(Icons.image,size: 85,color: Colors.black54,):
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
                            width: 65,
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
                        fontSize: 14,
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
                items: itemsDebit.keys.map<DropdownMenuItem<String>>((String key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Text(itemsDebit[key]),
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
                    firstDate: DateTime.now(),
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
                Text("DEBIT AMOUNT ",style: textStyleBodyText1,),
                Text("\u20B9 *",style: textStyleBodyText1.copyWith(color: Colors.red),)
              ],),),
               const SizedBox(height: 10,),
            TextField(
              keyboardType:TextInputType.number,
              controller: debitAmountController,
              inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(7),
                    ],
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
                      width: 1, color:Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!),
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
              items: assignedToList.map((String items){
              return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                   );
                 }).toList(),
              onChanged: (String? newValue){
                   setState(() {
                    snapAssignedToController.text=assignedToListIndex[assignedToList.indexOf(newValue!)].toString();
                    dropdownvalueAssignedTo = newValue.toString();
                   });
                 },
               ),
          ])
            ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
            padding: const EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 10),
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
                  width: MediaQuery.of(context).size.width/3.7,
                  child: Container(
                   decoration: BoxDecoration(
                     color: isCardEnabled2[index]? AppColors.primary:AppColors.white,
                     border: Border.all(width: 1.2,color:  AppColors.primary,),
                    ),
                    child: Center(
                      child: Text(priority[index],textAlign: TextAlign.center,
                        style: TextStyle(
                            color: isCardEnabled2[index]?Colors.white: AppColors.primary,
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
              child: const Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.normal),)),
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
                 else if(viewpoints2.isNotEmpty && viewpoints2[0]['image'].isEmpty){
                  EasyLoading.showToast("Please upload atleast one snag image",toastPosition: EasyLoadingToastPosition.bottom);
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
                else if(priorityController.text.isEmpty){
                  EasyLoading.showToast("Please assign priority",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else{
                // ignore: non_constant_identifier_names
                List VID=[];
                Map<String, dynamic> snagData = {};
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var createdById=sharedPreferences.getString('id');
                FormData formData=FormData(); 
                for(int i=0;i<viewpoints2.length;i++){
                  if(viewpoints2[i]['image'].isNotEmpty){
                  for(int j=0;j<viewpoints2[i]['image'].length;j++){
                    viewpointsToSent.add(viewpoints2[i]['image'][j].toString());
                    VID.add(viewpointsID[i]);
                  }
                  }
                }
                  if(viewpointsToSent.isNotEmpty){
                    for (var item in viewpointsToSent){
                      snagData["viewpoint_${VID[viewpointsToSent.indexOf(item)]}"]=viewpointsToSent[viewpointsToSent.indexOf(item)].split(': ')[1].substring(1,viewpointsToSent[viewpointsToSent.indexOf(item)].split(': ')[1].length-1);
                    }
                  }
                try {
                  snagData['markup_file']=assetImageController.text;
                } catch (e) {
                  formData.fields.add(const MapEntry('markup_file', ''));
                }
                snagData['snags_data']= ({
                      "client_id":int.parse(clientId.text),
                      "project_id": int.parse(projectId.text),
                      "category_id": int.parse(categoryIDController.text),
                      "location_id": int.parse(locationId.text),
                      "sub_loc_id": int.parse(subLocationId.text),
                      "sub_sub_loc_id": int.parse(subSubLocationId.text),
                      "activity_head_id": 1,
                      // "activity_id":int.parse(signInController.getActivityHeadList!.data![0].activityId.toString()),
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
                   });
                    snagData['snags_info']= ({
                      "locationName": locationController.text,
                      "subLocName": subLocationController.text,
                      "subSubLocName": subSubLocationController.text,
                      "activity": subSubV,
                      "assigned_to": dropdownvalueAssignedTo,
                      "createdBy": "The Lake Admin",
                   });
                    if (kDebugMode) {
                      print("{{{{{{{{{{{{{}}}");
                      print(snagData);
                      print("{{{{{{{{{{{{{}}}");
                    }
                  try {
                    await databaseProvider.insertSnagFormData(snagData);
                    EasyLoading.showToast("Snag Saved", toastPosition: EasyLoadingToastPosition.bottom); 
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    } catch (e) {
                      EasyLoading.showToast("unknown error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     if (kDebugMode) {
                       print(e);
                     } 
                    }
                }
              }, 
               style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor:const Color.fromARGB(255, 84, 216, 88)
              ),
              child: const Text("Save", style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal),))
            ],
          )
             )
            
        ])
          ):const Center(child: CircularProgressIndicator(color: AppColors.primary,)));
  }
    //  );
  }
// }


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  const SubLocationOffline(),
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
    pageBuilder: (context, animation, secondaryAnimation) => const ActivityHeadOffline(),
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
);
}