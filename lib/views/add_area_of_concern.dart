import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:colab/constants/colors.dart';
import 'package:colab/models/activity_head.dart';
import 'package:colab/models/sub_location_list.dart';
import 'package:colab/services/textfield.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_painter/image_painter.dart';
import 'package:colab/models/location_list.dart';
import 'package:colab/views/activity_head.dart';
import 'package:colab/views/sub_location.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';
import '../network/area_of_concern_network.dart';
import '../network/client_project.dart';
import '../services/container2.dart';

// ignore: must_be_immutable
class AddAreaOfConcern extends StatefulWidget {
  AddAreaOfConcern({Key? key,from}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var from;

  @override
  State<AddAreaOfConcern> createState() => _AddAreaOfConcernState();
}

class _AddAreaOfConcernState extends State<AddAreaOfConcern> {
  final getAreaOfConcernDataController=Get.find<GetAreaOfConcern>();
  final descriptionController=TextEditingController();
  final otherLocationController=TextEditingController();
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
  // ignore: non_constant_identifier_names
  final linking_activity_id=TextEditingController();
  final activityId=TextEditingController();
  String dropdownvalue = 'Select Location';  
  String dropdownvalue2 = 'Select Sub Location';  
  String dropdownvalue3 = 'Select Activity Head';  
 
  List<String> locationList=[];
  List<String> assignedToList=[];
  List<int> assignedToListIndex=[];
  final imageKey = GlobalKey<ImagePainterState>();

  File?  _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage =File(image!.path);
    });
  }
 
  
    late List<bool> isSelected;
  
    @override
  void initState() {
    super.initState(); 
    isSelected=[true,false,false];
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
      if(signInController.getEmployeeList!.data!.isNotEmpty && assignedToList.isEmpty){
        assignedToList.add("Select Name");
        for(int i=0;i<signInController.getEmployeeList!.data!.length;i++){
          assignedToList.add(signInController.getEmployeeList!.data![i].userId.toString());
          assignedToListIndex.add(signInController.getEmployeeList!.data![i].id!);
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

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.primary,
        title: Text("Area of concern",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const SizedBox(height: 20,),
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
           margin: const EdgeInsets.only(left:20,right:20),
           padding: const EdgeInsets.only(top: 20,bottom: 20),
            child:
             InkWell(
                onTap: () async {
                  if(subLocationId.text.isNotEmpty && locationController.text.isNotEmpty){
             String value= await Navigator.of(context).push(_createRoute2());
             setState(() {
              activityId.text=value.substring(value.indexOf(':')+1,value.indexOf('|'));
              linking_activity_id.text=value.substring(value.indexOf('}')+1,value.indexOf(':'));
              subSubV=value.substring(0,value.indexOf('}'));
              subSubLocationController.text=value.substring(0,value.indexOf('}'));
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
            CustomContainer2(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Text("Other Location",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               CustomTextField3(enabled: true,controller: otherLocationController,hintText: "Type here",)
          ])
            ),
            const SizedBox(height: 10,),
             CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DESCRIPTION",style: textStyleBodyText1,),
                Text("*",style: textStyleBodyText1.copyWith(color: AppColors.tertiary),),
              ],),),
               const SizedBox(height: 10,),
               CustomTextFieldArea(enabled: true,controller: descriptionController,hintText: "Type here",)
          ])
            ),
            const SizedBox(height: 10,),
          CustomContainer2(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("ATTACH FILE/PHOTO",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.grey[300]),
                 onPressed: () {
                   showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return SimpleDialog(
                       children: <Widget>[
                         SimpleDialogOption(
                            child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  Text("Choose from Library",style: textStyleBodyText1,),
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
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 10),
                                Text("Take Photo",style:textStyleBodyText1,),
                              ],
                            ),
                             onPressed: () {
                               // Call the _pickImage function with the camera source
                               _pickImage(ImageSource.camera);
                               // Close the modal pop-up
                               Navigator.pop(context);
                             },
                           ),
                           SimpleDialogOption(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 10),
                                Text("Cancel",style:textStyleBodyText1,),
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
                 child: _selectedImage == null
                     ? const Icon(Icons.add,size: 80,)
                     : Image.file(_selectedImage!,height: 80,width: 80,),
               ),
          ])
          ),
           const SizedBox(height: 20,),
           Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            margin:const EdgeInsets.only(left: 20,right: 20),
              child: 
             ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
              elevation: 0,
              splashFactory: NoSplash.splashFactory),
              onPressed: () async{
                if(locationController.text.isEmpty && otherLocationController.text.isEmpty){
                  EasyLoading.showToast("Please select location & specify other location",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(locationController.text.isEmpty){
                    EasyLoading.showToast("Please select location",toastPosition: EasyLoadingToastPosition.bottom);
                }
                 else if(subLocationId.text.isEmpty){
                  EasyLoading.showToast("Please Select SubLocation",toastPosition: EasyLoadingToastPosition.bottom);
                }
                  else if(subSubLocationController.text.isEmpty){
                  EasyLoading.showToast("Please Select Activity Head",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else if(otherLocationController.text.isEmpty){
                  EasyLoading.showToast("Please specify other location",toastPosition: EasyLoadingToastPosition.bottom);
                }
                 else if(descriptionController.text.isEmpty){
                   EasyLoading.showToast("Please add Description",toastPosition: EasyLoadingToastPosition.bottom);
                }
                else{
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var id=sharedPreferences.getString('id');
                var projectID=sharedPreferences.getString('projectIdd');
                var clientID=sharedPreferences.getString('client_id');
                FormData formData=FormData(); 
                var dio = Dio();
                    try {
                formData.files.add(MapEntry("issueFile", await MultipartFile.fromFile(_selectedImage!.path, filename: "issueFile_image")));
                } catch (e) {
                  formData.fields.add(const MapEntry('issueFile', ''));
                }
                formData.fields.add(MapEntry('issueData', jsonEncode(
                  [
                    {
                        "client_id": int.parse(clientID!),
                        "project_id": int.parse(projectID!),
                        "issuer_id": int.parse(id!),
                        "assigned_to" : "",
                        "issue_date": DateTime.now().toString(),
                        "location_id":int.parse(locationId.text),
                        "sub_location_id": int.parse(subLocationId.text),
                        "sub_sub_location_id": int.parse(subSubLocationId.text),
                        "activity_id": int.parse(activityId.text),
                        "linking_activity_id": int.parse(linking_activity_id.text),
                        "other_location": otherLocationController.text,
                        "description": descriptionController.text,
                        "status": "Pending",
                    }
                ]
                   )
                   )
                   );
                    if (kDebugMode) {
                      print(formData.fields);
                    }
                  try {
                  var res= await dio.post(
                  Config.addAreaOfConcernApi,
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
                    EasyLoading.showToast("Concern saved",toastPosition: EasyLoadingToastPosition.bottom);
                    await getAreaOfConcernDataController.getAreaOfConcernData(context: context);
                    Get.put(GetAreaOfConcern()); 
                    // ignore: use_build_context_synchronously
                    context.pop();
                    // ignore: use_build_context_synchronously
                    context.pop();
                    // ignore: use_build_context_synchronously
                    context.pushNamed('AREASOFCONCERN');
                    }
                    else{
                       EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                }catch(e){
                  EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                  if (kDebugMode) {
                    print(e);
                  }
                }
              }
              }, 
               child: Text("Submit",style: textStyleBodyText1.copyWith(color: AppColors.black),))
           ),
          ])
        )
    );
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