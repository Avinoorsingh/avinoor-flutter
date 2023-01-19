import 'dart:convert';
import 'package:colab/views/sub_location_progress.dart';
import 'package:http/http.dart' as http;
import 'package:colab/constants/colors.dart';
import 'package:colab/network/area_of_concern_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';
import '../models/progress_activityHead_data.dart';
import '../models/progress_location_data.dart';
import '../models/progress_sublocation_data.dart';
import '../theme/text_styles.dart';

class ThreeSixtyImage extends StatefulWidget {
  const ThreeSixtyImage({Key? key,}) : super(key: key);

  @override
  State<ThreeSixtyImage> createState() => _ThreeSixtyImageState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class _ThreeSixtyImageState extends State<ThreeSixtyImage> {
  final getAreaOfConcern = Get.find<GetAreaOfConcern>();
  List<String?> locationName=[];
  List<String?> activity=[];
  List<String?> activityHead=[];
  List<String?> date=[];
  List<String?> description=[];
  List<String?> status=[];
  List areaData=[];
  List dateDifference=[];
  List<String> locationList=[];
  final locationId=TextEditingController();
  final categoryController=TextEditingController();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
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
  late String subV="";
  late String subSubV="";
  String dropdownvalue = 'Select Location';  
  String dropdownvalue2 = 'Select Sub Location';  
  final signInController=Get.find<SignInController>();
  List<int> locationID=[];
 
 @override
 void initState(){
  super.initState();
  getAreaOfConcern.getAreaOfConcernData(context: context);
 }

  @override
  Widget build(BuildContext context) {
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
    EasyLoading.dismiss();
    return 
    Scaffold(
    appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Add 360 Images",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
    body: 
    Container(margin: const EdgeInsets.only(top: 10),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            Column(children: [
           Container(
           margin: const EdgeInsets.only(left:10,right:10,),
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
           margin: const EdgeInsets.only(left:10,right:10),
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
          const SizedBox(height: 30,),
          Container(
          margin: const EdgeInsets.only(left:10,right:10),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: (){
              if(locationId.text.isEmpty){
                EasyLoading.showToast("Please select Location",toastPosition: EasyLoadingToastPosition.bottom);
              }
              else if(subLocationId.text.isEmpty){
                EasyLoading.showToast("Please select Sub Location",toastPosition: EasyLoadingToastPosition.bottom);
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black38,
          shadowColor: Colors.black,
          ), 
          child:const Text("Add 360 Image"),
          )
          )
            ],)
        ),
      ],
    )));
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