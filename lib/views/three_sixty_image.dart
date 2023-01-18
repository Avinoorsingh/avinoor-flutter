import 'dart:convert';
import 'package:colab/views/activity_head.dart';
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
import '../models/activity_head.dart';
import '../models/location_list.dart';
import '../models/sub_location_list.dart';
import '../theme/text_styles.dart';
import 'sub_location.dart';

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
  late String subV="";
  late String subSubV="";
  String dropdownvalue = 'Select Location';  
  String dropdownvalue2 = 'Select Sub Location';  
  final signInController=Get.find<SignInController>();
 
 @override
 void initState(){
  super.initState();
  getAreaOfConcern.getAreaOfConcernData(context: context);
 }

  @override
  Widget build(BuildContext context) {
     if(signInController.getLocationList!.data!.isNotEmpty && locationList.isEmpty){
        List<LocationData>? locationList1=signInController.getLocationList?.data;
        locationList.add("Select Location");
        for(var data in locationList1!){
          locationList.add(data.locationName!);
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
          const SizedBox(height: 30,),
          Container(
          margin: const EdgeInsets.only(left:20,right:20),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: (){
              context.pushNamed('ADD360IMAGE');
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